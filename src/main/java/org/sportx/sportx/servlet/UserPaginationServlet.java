package org.sportx.sportx.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.sportx.sportx.model.User;
import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.UserDAO;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("UserPagination")
public class UserPaginationServlet extends HttpServlet {

    // Número de usuários por página
    private static final int USERS_PER_PAGE = 10;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obter o número da página atual, padrão é 1
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                // Se não for um número válido, assume-se a página 1
                currentPage = 1;
            }
        }

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);

            // Buscar todos os usuários
            List<User> allUsers = userDAO.getUsers(null, null, null);  // Aqui, você pode passar filtros se necessário
            int totalUsers = allUsers.size();

            // Calcular a quantidade de páginas
            int totalPages = (int) Math.ceil((double) totalUsers / USERS_PER_PAGE);

            // Calcular o índice inicial e final para os usuários desta página
            int startIndex = (currentPage - 1) * USERS_PER_PAGE;
            int endIndex = Math.min(startIndex + USERS_PER_PAGE, totalUsers);

            // Obter os usuários para esta página
            List<User> usersForPage = allUsers.subList(startIndex, endIndex);

            // Passar a lista de usuários e a informação de paginação para o JSP
            request.setAttribute("users", usersForPage);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao carregar os dados.");
        }

        // Redireciona para o JSP
        request.getRequestDispatcher("/AdminPage_UsersManagement.jsp").forward(request, response);
    }
}

