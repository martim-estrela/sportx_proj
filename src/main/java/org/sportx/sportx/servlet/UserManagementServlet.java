package org.sportx.sportx.servlet;

import jakarta.servlet.annotation.WebServlet;
import org.sportx.sportx.model.User;
import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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
            int usersPerPage = 10; // Número de utilizadores por página

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
            int totalUsers = userDAO.getTotalPages(role, name);
            int totalPages = (int) Math.ceil((double) totalUsers / usersPerPage);

            // Garantir que a página atual não ultrapasse o total de páginas
            if (page > totalPages && totalPages > 0) {
                page = totalPages;
            }

            // Buscar utilizadores com base nos filtros
            List<User> filteredUsers = userDAO.getUsers(role, name, page, usersPerPage);
            request.setAttribute("filteredUsers", filteredUsers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalUsers", totalUsers);

            // Buscar todas as roles disponíveis (apenas 'user' e 'admin')
            List<String> allRoles = List.of("user", "admin"); // Apenas 'user' e 'admin'
            request.setAttribute("allRoles", allRoles);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao carregar os dados.");
        }

        request.getRequestDispatcher("/AdminPage_UserManagement.jsp").forward(request, response);
    }

    // Código para as ações de atualização e deleção (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");

        if ("deleteUser".equals(action)) {

            try (Connection conn = DBConnection.getConnection()) {
                int userId = Integer.parseInt(userIdStr);
                UserDAO userDAO = new UserDAO(conn);
                boolean success = userDAO.deleteUser(userId);
                response.getWriter().write(success ? "success" : "failure");

            } catch (NumberFormatException e) {
                response.getWriter().write("erro: ID inválido (não é número)");
            } catch (SQLException e) {
                response.getWriter().write("erro: erro de base de dados");
                e.printStackTrace();
            }
        }
    }

}
