package org.sportx.sportx.servlet;

import org.sportx.sportx.model.User;
import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.OrderDAO;
import org.sportx.sportx.DTO.OrderHistoryDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Loginpage.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            OrderDAO orderDAO = new OrderDAO(conn);

            // Pagination parameters
            int page = 1;
            int ordersPerPage = 5;

            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // Get total count of orders for this user
            int totalOrders = orderDAO.getTotalOrdersForUser(user.getUserId());
            int totalPages = (int) Math.ceil((double) totalOrders / ordersPerPage);

            // Ensure current page doesn't exceed total pages
            if (page > totalPages && totalPages > 0) {
                page = totalPages;
            }

            // Calculate pagination range
            int startPage = Math.max(1, page - 2);
            int endPage = Math.min(totalPages, page + 2);

            // Get orders for this page
            List<OrderHistoryDTO> orders = orderDAO.getOrdersForUser(user.getUserId(), page, ordersPerPage);

            // Set attributes for JSP
            request.setAttribute("orders", orders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

            request.getRequestDispatcher("/Orderhistory.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading order history");
            request.getRequestDispatcher("/Orderhistory.jsp").forward(request, response);
        }
    }
}