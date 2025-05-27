package org.sportx.sportx.servlet;

import org.sportx.sportx.model.*;
import org.sportx.sportx.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Check if user is logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Loginpage.jsp");
            return;
        }

        // Get cart items
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // Check if cart is empty
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp");
            return;
        }

        // Get shipping method and totals
        ShippingMethod shippingMethod = (ShippingMethod) session.getAttribute("selectedShippingMethod");
        double cartTotal = Double.parseDouble(request.getParameter("subtotal"));
        double totalWithShipping = Double.parseDouble(request.getParameter("total"));

        // Get payment information
        String paymentMethod = request.getParameter("payment-method");

        try (Connection conn = DBConnection.getConnection()) {
            // Disable auto-commit for transaction
            conn.setAutoCommit(false);

            try {
                // 1. Create and insert payment info
                int paymentInfoId = createPaymentInfo(conn, user.getUserId(), paymentMethod, request);

                // 2. Insert into order_table
                int orderId = createOrder(conn, user.getUserId(), cartTotal, shippingMethod.getShippingId(), paymentInfoId);

                // 3. Insert order lines for each cart item
                for (CartItem item : cart) {
                    createOrderLine(conn, orderId, item);

                    // 4. Update inventory (reduce stock)
                    updateInventory(conn, item.getProductItemId(), item.getQuantity());
                }

                // If everything is successful, commit the transaction
                conn.commit();

                // Clear the cart after successful order
                session.removeAttribute("cart");
                session.removeAttribute("cartTotal");
                session.removeAttribute("totalWithShipping");

                // Set success message
                session.setAttribute("orderSuccess", true);
                session.setAttribute("orderId", orderId);

                // Redirect to success page
                response.sendRedirect(request.getContextPath() + "/OrderCompletePage.jsp");

            } catch (SQLException e) {
                // If there's an error, rollback the transaction
                conn.rollback();
                e.printStackTrace();

                // Set error message
                session.setAttribute("orderError", true);
                session.setAttribute("errorMessage", "Failed to process your order. Please try again.");

                // Redirect back to checkout page
                response.sendRedirect(request.getContextPath() + "/CheckoutPage.jsp");
            } finally {
                // Reset auto-commit to default
                conn.setAutoCommit(true);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("orderError", true);
            session.setAttribute("errorMessage", "Database connection error. Please try again later.");
            response.sendRedirect(request.getContextPath() + "/CheckoutPage.jsp");
        }
    }

    private int createPaymentInfo(Connection conn, int userId, String paymentMethodId, HttpServletRequest request) throws SQLException {
        String sql = "INSERT INTO payment_info (card_number, exp_date, user_id, payment_type_id) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            int paymentTypeId = Integer.parseInt(paymentMethodId);

            if (paymentTypeId == 2) { // PayPal
                String paypalEmail = request.getParameter("paypal-email");
                stmt.setString(1, paypalEmail != null ? paypalEmail : "");
                stmt.setDate(2, null); // No expiry date for PayPal
            } else { // Credit Card or Debit Card
                String cardNumber = request.getParameter("card-number");
                String expDate = request.getParameter("exp-date");

                // Clean card number (remove spaces)
                if (cardNumber != null) {
                    cardNumber = cardNumber.replaceAll("\\s", "");
                    // Mask the card number for security (store only last 4 digits)
                    String maskedCardNumber = "**** **** **** " + cardNumber.substring(Math.max(0, cardNumber.length() - 4));
                    stmt.setString(1, maskedCardNumber);
                } else {
                    stmt.setString(1, "");
                }

                // Convert MM/YY to date format (last day of the month for expiry)
                if (expDate != null && expDate.contains("/")) {
                    try {
                        String[] parts = expDate.split("/");
                        String month = parts[0];
                        String year = "20" + parts[1]; // Convert YY to YYYY

                        // Set to last day of the month for expiry
                        LocalDate expiryDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), 1)
                                .plusMonths(1).minusDays(1);
                        stmt.setDate(2, Date.valueOf(expiryDate));
                    } catch (Exception e) {
                        System.err.println("Error parsing expiry date: " + expDate);
                        stmt.setDate(2, null);
                    }
                } else {
                    stmt.setDate(2, null);
                }
            }

            stmt.setInt(3, userId);
            stmt.setInt(4, paymentTypeId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Creating payment info failed, no rows affected.");
            }

            // Get the generated payment info ID
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating payment info failed, no ID obtained.");
                }
            }
        }
    }

    private int createOrder(Connection conn, int userId, double orderTotal, int shippingId, int paymentInfoId) throws SQLException {
        String sql = "INSERT INTO order_table (order_date, order_total, order_status_id, shipping_id, user_id, payment_info_id) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            // Set current date for order date
            stmt.setDate(1, Date.valueOf(LocalDate.now()));
            stmt.setDouble(2, orderTotal);
            stmt.setInt(3, 1); // 1 = pending (status_id from order_status table)
            stmt.setInt(4, shippingId);
            stmt.setInt(5, userId);
            stmt.setInt(6, paymentInfoId);

            stmt.executeUpdate();

            // Get the generated order ID
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        }
    }

    private void createOrderLine(Connection conn, int orderId, CartItem item) throws SQLException {
        String sql = "INSERT INTO order_line (quantity, product_price, sub_total, order_id, product_item_id) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, item.getQuantity());
            stmt.setDouble(2, item.getPrice());
            stmt.setDouble(3, item.getPrice() * item.getQuantity());
            stmt.setInt(4, orderId);
            stmt.setInt(5, item.getProductItemId());

            stmt.executeUpdate();
        }
    }

    private void updateInventory(Connection conn, int productItemId, int quantityOrdered) throws SQLException {
        String sql = "UPDATE product_item SET qty_in_stock = qty_in_stock - ? WHERE product_item_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantityOrdered);
            stmt.setInt(2, productItemId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Failed to update inventory for product item: " + productItemId);
            }
        }
    }
}