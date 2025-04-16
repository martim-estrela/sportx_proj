package org.sportx.sportx.util;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.sportx.sportx.DTO.ProductDTO;
import org.sportx.sportx.DTO.ProductItemDTO;
import org.sportx.sportx.DTO.StockManagementDTO;
import org.sportx.sportx.model.Product;
import org.sportx.sportx.model.ProductItem;
import org.sportx.sportx.model.Variation;
import org.sportx.sportx.model.VariationOption;

import java.io.IOException;
import java.sql.Connection;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class StockManagementDAO {
    private static Connection conn = null;

    public StockManagementDAO(Connection conn) {
        StockManagementDAO.conn = conn;
    }

    public void updateStock(StockManagementDTO stockManagementDTO)
            throws SQLException {

        String query = "UPDATE product_item pi" +
        "JOIN product_item_variation_option povo ON pi.product_item_id = povo.product_item_id" +
        "JOIN variation_option vo ON povo.variation_option_id = vo.variation_option_id" +
        "JOIN variation v ON vo.variation_id = v.variation_id" +
        "SET pi.qty_in_stock = ?" +
                "WHERE pi.product_id = ?" +
                "AND v.name = ?" +
                "AND vo.value = ? ";

        try (PreparedStatement stmt = conn.prepareStatement(query);) {
            stmt.setInt(1, stockManagementDTO.getQtyInStock());
            stmt.setInt(2, stockManagementDTO.getProductItemID());
            stmt.setString(3, stockManagementDTO.getOptionType());
            stmt.setString(4, stockManagementDTO.getOptionValue());

            stmt.executeUpdate();
        }
    }


    public void deleteProduct(int product_item_id)
            throws SQLException {

        String query = "DELETE FROM product_item WHERE product_item_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query);) {

            stmt.setInt(1, product_item_id);

            stmt.executeUpdate();


        }
    }

    public List<ProductDTO> listAllProductsWithItems() throws SQLException {
        List<ProductDTO> products = new ArrayList<>();

        String productQuery = "SELECT p.product_id, p.name, p.description FROM product p";
        String itemQuery =
                "SELECT pi.product_item_id, v.name AS variation, vo.value AS variation_option, pi.qty_in_stock , pi.product_image, pi.price" +
                        "FROM product_item pi " +
                        "JOIN variation_option vo ON pi.variation_option_id = vo.id " +
                        "JOIN variation_type v ON vo.variation_type_id = v.id " +
                        "WHERE pi.product_id = ?";

        try (
                PreparedStatement productStmt = conn.prepareStatement(productQuery);
                ResultSet productRs = productStmt.executeQuery()
        ) {
            while (productRs.next()) {
                int productId = productRs.getInt("product_id");
                String name = productRs.getString("name");
                String description = productRs.getString("description");

                List<ProductItemDTO> items = new ArrayList<>();
                ProductDTO product = new ProductDTO(productId, name, description);

                try (PreparedStatement itemStmt = conn.prepareStatement(itemQuery)) {
                    itemStmt.setInt(1, productId);
                    try (ResultSet itemRs = itemStmt.executeQuery()) {
                        while (itemRs.next()) {
                            int productItemId = itemRs.getInt("product_item_id");
                            String variation = itemRs.getString("variation");
                            String variationOption = itemRs.getString("variation_option");
                            int qtyInStock = itemRs.getInt("qty_in_stock");
                            String productImage = itemRs.getString("product_image");
                            double price = itemRs.getDouble("price");


                            ProductItemDTO item = new ProductItemDTO(productItemId, price, qtyInStock, productImage);
                            item.addVariation(variationOption, variation);
                            items.add(item);
                        }
                    }
                }

                product.setItems(items);
                products.add(product);
            }
        }

        return products;
    }

}
