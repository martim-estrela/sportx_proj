package org.sportx.sportx.dao;

import org.sportx.sportx.model.ShippingMethod;
import org.sportx.sportx.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ShippingMethodDAO {

    public List<ShippingMethod> getAllShippingMethods() {
        List<ShippingMethod> methods = new ArrayList<>();
        String sql = "SELECT shipping_id, price, name FROM shipping_method";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ShippingMethod method = new ShippingMethod();
                method.setShippingId(rs.getInt("shipping_id"));
                method.setPrice(rs.getDouble("price"));
                method.setName(rs.getString("name"));
                methods.add(method);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return methods;
    }

    public ShippingMethod getShippingMethodById(int shippingId) {
        String sql = "SELECT shipping_id, price, name FROM shipping_method WHERE shipping_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, shippingId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ShippingMethod method = new ShippingMethod();
                    method.setShippingId(rs.getInt("shipping_id"));
                    method.setPrice(rs.getDouble("price"));
                    method.setName(rs.getString("name"));
                    return method;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}