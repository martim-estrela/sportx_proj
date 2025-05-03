package org.sportx.sportx.servlet;

import org.sportx.sportx.model.User;
import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class UserManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            // Obter filtros dos parâmetros da request
            String role = request.getParameter("role");
            String name = request.getParameter("name");

            // Parâmetros de paginação
            int page = 1;
            int usersPerPage = 5; // Número de utilizadores por página

            // Verificar se foi solicitada uma página específica
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) {
                        page = 1;
                    }
                } catch (NumberFormatException _) {

                }
            }

            // Contar o total de usuários para calcular o número de páginas
            int totalUsers = userDAO.getTotalUsers(role, name);
            int totalPages = (int) Math.ceil((double) totalUsers / usersPerPage);

            // Garantir que a página atual não ultrapasse o total de páginas
            if (page > totalPages && totalPages > 0) {
                page = totalPages;
            }

            int startPage = Math.max(1, page - 2);
            int endPage = Math.min(totalPages, page + 2);


            // Buscar utilizadores com base nos filtros
            List<User> filteredUsers = userDAO.getUsers(role, name, page, usersPerPage);
            request.setAttribute("filteredUsers", filteredUsers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

            // Buscar todas as roles disponíveis (apenas 'user' e 'admin')
            List<String> allRoles = List.of("user", "admin"); // Apenas 'user' e 'admin'
            request.setAttribute("allRoles", allRoles);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao carregar os dados.");
        }

        request.getRequestDispatcher("/AdminPage_UserManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            if ("deleteUser".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean success = userDAO.deleteUser(userId);

                if (!success) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Falha ao excluir usuário");
                    return;
                }

                response.setStatus(HttpServletResponse.SC_OK);
            }
            else if ("addUser".equals(action)) {

                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String phoneNumber = request.getParameter("phoneNumber");
                String userType = request.getParameter("userType");
                String status = request.getParameter("status");
                LocalDate registerDate = LocalDate.now();


                User newUser = new User(0, email, password, phoneNumber, name, userType, status, registerDate);
                /*
                newUser.setName(name);
                newUser.setEmail(email);
                newUser.setPassword(password);
                newUser.setPhoneNumber(phoneNumber);
                newUser.setUserType(userType);
                newUser.setStatus(status);
                */


                boolean success = userDAO.saveUser(newUser);

                if (success) {
                    // Redirecionar de volta para a página com um parâmetro de sucesso
                    response.sendRedirect(request.getContextPath() + "/manageUser?success=true");
                } else {
                    // Redirecionar com um parâmetro de erro
                    response.sendRedirect(request.getContextPath() + "/manageUser?error=true");
                }
            } else if ("updateUser".equals(action)) {
                // Obter parâmetros do formulário
                int userId = Integer.parseInt(request.getParameter("userId"));
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String phoneNumber = request.getParameter("phoneNumber");
                String userType = request.getParameter("userType");
                String status = request.getParameter("status");

                // Validações (básicas)
                if (name == null || name.trim().isEmpty() ||
                        email == null || email.trim().isEmpty() ||
                        userType == null || userType.trim().isEmpty() ||
                        status == null || status.trim().isEmpty()) {

                    request.setAttribute("errorMessage", "Todos os campos obrigatórios devem ser preenchidos.");
                    request.getRequestDispatcher("/AdminPage_UserManagement.jsp").forward(request, response);
                    return;
                }

                // Verificar senha apenas se foi fornecida
                if (password != null && !password.trim().isEmpty() && password.length() < 8) {
                    request.setAttribute("errorMessage", "A senha deve ter pelo menos 8 caracteres.");
                    request.getRequestDispatcher("/AdminPage_UserManagement.jsp").forward(request, response);
                    return;
                }

                // Buscar utilizador atual para preservar a senha se não foi alterada
                User existingUser = userDAO.getUserById(userId);

                if (existingUser == null) {
                    request.setAttribute("errorMessage", "Usuário não encontrado.");
                    request.getRequestDispatcher("/AdminPage_UserManagement.jsp").forward(request, response);
                    return;
                }

                // Atualizar os dados do utilizador
                existingUser.setName(name);
                existingUser.setEmail(email);
                existingUser.setPhoneNumber(phoneNumber);
                existingUser.setUserType(userType);
                existingUser.setStatus(status);

                // Atualizar senha apenas se uma nova foi fornecida
                if (password != null && !password.trim().isEmpty()) {
                    existingUser.setPassword(password);
                }

                // Atualizar o utilizador no banco de dados
                userDAO.updateUser(existingUser);

                // Redirecionar para a página
                response.sendRedirect(request.getContextPath() + "/AdminPage_UserManagement.jsp");
            }
                
             else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar a requisição: " + e.getMessage());
        }
    }

}
