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

@WebServlet("/manageUser")
public class UserManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            // Obter filtros dos parâmetros da request
            String role = request.getParameter("role");
            String subRole = request.getParameter("subRole");
            String name = request.getParameter("name");

            // Buscar utilizadores com base nos filtros
            List<User> filteredUsers = userDAO.getUsers(role, subRole, name);
            request.setAttribute("filteredUsers", filteredUsers);

            // Buscar todas as roles e sub-roles disponíveis
            List<String> allRoles = userDAO.getAllRoles();
            List<String> allSubRoles = userDAO.getAllSubRoles();

            request.setAttribute("allRoles", allRoles);
            request.setAttribute("allSubRoles", allSubRoles);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao carregar os dados.");
        }

        request.getRequestDispatcher("/AdminPage_UsersManagement.jsp").forward(request, response);
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
