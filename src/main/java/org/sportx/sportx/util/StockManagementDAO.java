package org.sportx.sportx.util;

import org.sportx.sportx.DTO.*;
import org.sportx.sportx.model.ProductCategoryChild;
import org.sportx.sportx.model.ProductCategoryParent;
import org.sportx.sportx.model.VariationOption;

import java.sql.Connection;
import java.sql.*;
import java.util.*;

public class StockManagementDAO {
    private static Connection conn = null;

    public StockManagementDAO(Connection conn) {
        StockManagementDAO.conn = conn;
    }

    /*
    public void updateStock(ProductDTO product)
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
            stmt.setInt(1, product.getStock());
            stmt.setInt(2, product.getProductItemId());
            stmt.setString(3, product.getOptionType());
            stmt.setString(4, product.getOptionValue());

            stmt.executeUpdate();
        }
    }*/

    //Eliminar produto da BD
    public void deleteProduct(int productItemId)
            throws SQLException {

        String query = "DELETE FROM product_item WHERE product_item_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query);) {

            stmt.setInt(1, productItemId);

            stmt.executeUpdate();


        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<ProductDTO> getFilteredProducts(String category, String subcategory, String brand, String color,
                                                String size, String name, int page, int productsPerPage) {
        List<ProductDTO> products = new ArrayList<>();
        Map<Integer, ProductDTO> productMap = new HashMap<>(); // Para agregar variações por produto

        String sql = "SELECT * FROM product_detailed_view pdv " +
                "JOIN product_category_child sc ON pdv.sub_category_id = sc.sub_category_id " +
                "JOIN product_category_parent c ON sc.category_id = c.category_id " +
                "WHERE 1=1";

        if (category != null && !category.isEmpty()) {
            sql += " AND c.category_name = ?";
        }
        if (subcategory != null && !subcategory.isEmpty()) {
            sql += " AND sc.sub_category_name = ?";
        }
        if (brand != null && !brand.isEmpty()) {
            sql += " AND pdv.brand = ?";
        }
        if (color != null && !color.isEmpty()) {
            sql += " AND (pdv.variation_type = 'Color' AND pdv.variation_value = ?)";
        }
        if (size != null && !size.isEmpty()) {
            sql += " AND (pdv.variation_type = 'Size' AND pdv.variation_value = ?)";
        }
        if (name != null && !name.isEmpty()) {
            sql += " AND pdv.name LIKE ?";
        }

        sql += " ORDER BY pdv.product_id LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            int index = 1;

            if (category != null && !category.isEmpty()) {
                stmt.setString(index++, category);
            }
            if (subcategory != null && !subcategory.isEmpty()) {
                stmt.setString(index++, subcategory);
            }
            if (brand != null && !brand.isEmpty()) {
                stmt.setString(index++, brand);
            }
            if (color != null && !color.isEmpty()) {
                stmt.setString(index++, color);
            }
            if (size != null && !size.isEmpty()) {
                stmt.setString(index++, size);
            }
            if (name != null && !name.isEmpty()) {
                stmt.setString(index++, "%" + name + "%");
            }

            // Paginação
            stmt.setInt(index++, productsPerPage);
            stmt.setInt(index++, (page - 1) * productsPerPage);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                ProductDTO product = productMap.get(productId);

                if (product == null) {
                    product = new ProductDTO();
                    product.setProductId(productId);
                    product.setProductItemId(rs.getInt("product_item_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setBrand(rs.getString("brand"));
                    product.setPrice(rs.getDouble("price"));
                    product.setImage(rs.getString("product_image"));
                    product.setStock(rs.getInt("stock"));
                    product.setColors(new HashSet<>());
                    product.setSizes(new HashSet<>());

                    productMap.put(productId, product);
                }

                String variationType = rs.getString("variation_type");
                String variationValue = rs.getString("variation_value");

                if ("Color".equalsIgnoreCase(variationType) && variationValue != null) {
                    product.getColors().add(variationValue);
                } else if ("Size".equalsIgnoreCase(variationType) && variationValue != null) {
                    product.getSizes().add(variationValue);
                }
            }

            products.addAll(productMap.values());

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }


    public static int getTotalProducts(String category, String subcategory, String brand, String color, String size, String name) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(DISTINCT pdv.product_id) AS total " +
                        "FROM product_detailed_view pdv " +
                        "JOIN product_category_child sc ON pdv.sub_category_id = sc.sub_category_id " +
                        "JOIN product_category_parent c ON sc.category_id = c.category_id " +
                        "WHERE 1=1 "
        );

        List<Object> parameters = new ArrayList<>();

        if (category != null && !category.isEmpty()) {
            sql.append("AND c.category_name = ? ");
            parameters.add(category);
        }

        if (subcategory != null && !subcategory.isEmpty()) {
            sql.append("AND sc.sub_category_name = ? ");
            parameters.add(subcategory);
        }

        if (brand != null && !brand.isEmpty()) {
            sql.append("AND pdv.brand = ? ");
            parameters.add(brand);
        }

        if (color != null && !color.isEmpty()) {
            sql.append("AND (pdv.variation_type = 'Color' AND pdv.variation_value = ?) ");
            parameters.add(color);
        }

        if (size != null && !size.isEmpty()) {
            sql.append("AND (pdv.variation_type = 'Size' AND pdv.variation_value = ?) ");
            parameters.add(size);
        }

        if (name != null && !name.isEmpty()) {
            sql.append("AND pdv.name LIKE ? ");
            parameters.add("%" + name + "%");
        }

        try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        }

        return 0;
    }




    // Buscar todas as categorias
    public List<ProductCategoryParent> getAllCategories() throws SQLException {
        List<ProductCategoryParent> categories = new ArrayList<>();

        String sql = "SELECT category_id, category_name FROM product_category_parent";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("category_id");
                String name = rs.getString("category_name");

                ProductCategoryParent category = new ProductCategoryParent(id, name);
                categories.add(category);
            }
        }

        return categories;
    }

    // Buscar todas as subcategorias
    public List<ProductCategoryChild> getAllSubcategories() throws SQLException {
        List<ProductCategoryChild> subcategories = new ArrayList<>();

        String sql = "SELECT sub_category_id, sub_category_name, category_id FROM product_category_child";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("sub_category_id");
                String name = rs.getString("sub_category_name");
                int categoryId = rs.getInt("category_id");

                ProductCategoryChild subcategory = new ProductCategoryChild(id, name, categoryId);
                subcategories.add(subcategory);
            }
        }

        return subcategories;
    }


    //Busca todas as brands num array de strings
    public List<String> getAllBrands() throws SQLException {
        List<String> brands = new ArrayList<>();
        String sql = "SELECT DISTINCT brand FROM product";  // Marca dentro da tabela product
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                brands.add(rs.getString("brand"));
            }
        }
        return brands;
    }

    //Busca todas as cores e tamanhos
    public List<VariationOption> getVariationOptions() throws SQLException {
        List<VariationOption> variationOptions = new ArrayList<>();
        String sql = "SELECT vo.variation_option_id, vo.value, vo.variation_id, v.name AS variation_name" +
                " FROM variation_option vo" +
                " INNER JOIN variation v ON vo.variation_id = v.variation_id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                VariationOption option = new VariationOption(
                        rs.getInt("variation_option_id"),
                        rs.getString("value"),
                        rs.getInt("variation_id"),
                        rs.getString("variation_name")
                );
                variationOptions.add(option);
            }
        }
        return variationOptions;
    }

    public Map<String, List<VariationOption>> getGroupedVariationOptions() throws SQLException {
        Map<String, List<VariationOption>> groupedOptions = new HashMap<>();

        // Consultar todas as variações
        List<VariationOption> options = getVariationOptions();

        // Agrupar por tipo de variação
        for (VariationOption option : options) {
            String key = option.getVariationName();
            groupedOptions.putIfAbsent(key, new ArrayList<>());
            groupedOptions.get(key).add(option);
        }

        return groupedOptions;
    }


}
