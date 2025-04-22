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

@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            // Obter filtros dos parâmetros da request
            String roleFilter = request.getParameter("role");
            String nameFilter = request.getParameter("name");

            // Buscar todas as roles disponíveis
            List<String> roles = userDAO.getAllRoles();
            request.setAttribute("roles", roles);

            // Buscar utilizadores com base nos filtros
            List<User> filteredUsers = userDAO.getUsers(roleFilter, nameFilter);
            request.setAttribute("users", filteredUsers);
            request.setAttribute("selectedRole", roleFilter);
            request.setAttribute("selectedName", nameFilter);


        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao carregar os dados.");
        }

        request.getRequestDispatcher("AdminPage_UsersManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);
            if ("updateStatus".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String newStatus = request.getParameter("status");

                boolean success = userDAO.updateUserStatus(userId, newStatus);
                response.getWriter().write(success ? "success" : "failure");
            } else if ("deleteUser".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));

                boolean success = userDAO.deleteUser(userId);
                response.getWriter().write(success ? "success" : "failure");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
