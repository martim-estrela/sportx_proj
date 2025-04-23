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

            // Buscar utilizadores com base nos filtros
            List<User> filteredUsers = userDAO.getUsers(role, name);
            request.setAttribute("filteredUsers", filteredUsers);

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
