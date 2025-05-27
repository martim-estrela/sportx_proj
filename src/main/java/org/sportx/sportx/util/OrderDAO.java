package org.sportx.sportx.util;

import org.sportx.sportx.DTO.OrderHistoryDTO;
import org.sportx.sportx.DTO.OrderItemDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private final Connection conn;

    public OrderDAO(Connection conn) {
        this.conn = conn;
    }

    /**
     * Get orders for a specific user with pagination
     */
    public List<OrderHistoryDTO> getOrdersForUser(int userId, int page, int ordersPerPage) throws SQLException {
        List<OrderHistoryDTO> orders = new ArrayList<>();

        String sql = "SELECT " +
                "    ot.order_id, " +
                "    ot.order_date, " +
                "    ot.order_total, " +
                "    os.status as order_status, " +
                "    sm.name as shipping_method, " +
                "    CONCAT(ai.street, ', ', ai.city, ', ', ai.country) as shipping_address, " +
                "    (SELECT pi.product_image " +
                "     FROM order_line ol " +
                "     JOIN product_item pi ON ol.product_item_id = pi.product_item_id " +
                "     WHERE ol.order_id = ot.order_id " +
                "     ORDER BY ol.order_line_id ASC " +
                "     LIMIT 1) as first_product_image, " +
                "    (SELECT COUNT(*) " +
                "     FROM order_line ol " +
                "     WHERE ol.order_id = ot.order_id) as total_items " +
                "FROM order_table ot " +
                "JOIN order_status os ON ot.order_status_id = os.order_status_id " +
                "JOIN shipping_method sm ON ot.shipping_id = sm.shipping_id " +
                "JOIN user u ON ot.user_id = u.user_id " +
                "JOIN address_info ai ON u.user_id = ai.user_id " +
                "WHERE ot.user_id = ? " +
                "ORDER BY ot.order_date DESC, ot.order_id DESC " +
                "LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, ordersPerPage);
            stmt.setInt(3, (page - 1) * ordersPerPage);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderHistoryDTO order = new OrderHistoryDTO(
                        rs.getInt("order_id"),
                        rs.getDate("order_date").toLocalDate(),
                        rs.getDouble("order_total"),
                        rs.getString("order_status"),
                        rs.getString("shipping_method"),
                        rs.getString("shipping_address"),
                        rs.getString("first_product_image"),
                        rs.getInt("total_items")
                );
                orders.add(order);
            }
        }

        return orders;
    }

    /**
     * Get total count of orders for a user
     */
    public int getTotalOrdersForUser(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM order_table WHERE user_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }

    /**
     * Get detailed order items for a specific order
     */
    public List<OrderItemDTO> getOrderItems(int orderId) throws SQLException {
        List<OrderItemDTO> orderItems = new ArrayList<>();

        String sql = "SELECT " +
                "    ol.order_line_id, " +
                "    p.name as product_name, " +
                "    pi.product_image, " +
                "    ol.quantity, " +
                "    ol.product_price, " +
                "    ol.sub_total, " +
                "    GROUP_CONCAT(CONCAT(v.name, ':', vo.value) ORDER BY v.name ASC SEPARATOR ',') as variation_pairs " +
                "FROM order_line ol " +
                "JOIN product_item pi ON ol.product_item_id = pi.product_item_id " +
                "JOIN product p ON pi.product_id = p.product_id " +
                "LEFT JOIN product_item_variation_option pivo ON pi.product_item_id = pivo.product_item_id " +
                "LEFT JOIN variation_option vo ON pivo.variation_option_id = vo.variation_option_id " +
                "LEFT JOIN variation v ON vo.variation_id = v.variation_id " +
                "WHERE ol.order_id = ? " +
                "GROUP BY ol.order_line_id, p.name, pi.product_image, ol.quantity, ol.product_price, ol.sub_total " +
                "ORDER BY ol.order_line_id";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderItemDTO item = new OrderItemDTO(
                        rs.getInt("order_line_id"),
                        rs.getString("product_name"),
                        rs.getString("product_image"),
                        rs.getInt("quantity"),
                        rs.getDouble("product_price"),
                        rs.getDouble("sub_total"),
                        rs.getString("variation_pairs")
                );
                orderItems.add(item);
            }
        }

        return orderItems;
    }

    /**
     * Get order with its items by order ID
     */
    public OrderHistoryDTO getOrderWithItems(int orderId) throws SQLException {
        OrderHistoryDTO order = null;

        String sql = "SELECT " +
                "    ot.order_id, " +
                "    ot.order_date, " +
                "    ot.order_total, " +
                "    os.status as order_status, " +
                "    sm.name as shipping_method, " +
                "    CONCAT(ai.street, ', ', ai.city, ', ', ai.country) as shipping_address, " +
                "    (SELECT pi.product_image " +
                "     FROM order_line ol " +
                "     JOIN product_item pi ON ol.product_item_id = pi.product_item_id " +
                "     WHERE ol.order_id = ot.order_id " +
                "     ORDER BY ol.order_line_id ASC " +
                "     LIMIT 1) as first_product_image, " +
                "    (SELECT COUNT(*) " +
                "     FROM order_line ol " +
                "     WHERE ol.order_id = ot.order_id) as total_items " +
                "FROM order_table ot " +
                "JOIN order_status os ON ot.order_status_id = os.order_status_id " +
                "JOIN shipping_method sm ON ot.shipping_id = sm.shipping_id " +
                "JOIN user u ON ot.user_id = u.user_id " +
                "JOIN address_info ai ON u.user_id = ai.user_id " +
                "WHERE ot.order_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                order = new OrderHistoryDTO(
                        rs.getInt("order_id"),
                        rs.getDate("order_date").toLocalDate(),
                        rs.getDouble("order_total"),
                        rs.getString("order_status"),
                        rs.getString("shipping_method"),
                        rs.getString("shipping_address"),
                        rs.getString("first_product_image"),
                        rs.getInt("total_items")
                );

                // Get order items
                List<OrderItemDTO> orderItems = getOrderItems(orderId);
                order.setOrderItems(orderItems);
            }
        }

        return order;
    }
}