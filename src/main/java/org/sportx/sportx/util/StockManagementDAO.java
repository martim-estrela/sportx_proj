package org.sportx.sportx.util;

import org.sportx.sportx.DTO.*;
import org.sportx.sportx.model.*;

import java.sql.Connection;
import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;

public class StockManagementDAO {
    private static Connection conn = null;

    public StockManagementDAO(Connection conn) {
        StockManagementDAO.conn = conn;
    }


    public void updateStock(ProductDTO product)
            throws SQLException {

        String query = "UPDATE product_item pi " +
                "SET pi.qty_in_stock = ?, pi.price = ? " +
                "WHERE pi.product_item_id = ?";


        try (PreparedStatement stmt = conn.prepareStatement(query);) {
            stmt.setInt(1, product.getStock());
            stmt.setDouble(2, product.getPrice());
            stmt.setInt(3, product.getProductItemId());
            stmt.executeUpdate();
        }
    }

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
    //Adicionar produto na DB
    public boolean addProduct(Product product, ProductItem productItem, String subCategory) throws SQLException {
        int subCategoryId = -1;

        String query2 = "SELECT sub_category_id FROM product_category_child" +
                "WHERE value = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query2);) {
            stmt.setString(1, subCategory);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                subCategoryId = rs.getInt("sub_category_id");
            }
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }

        product.setSub_category_id(subCategoryId);


        String query =  "INSERT INTO product (brand, name, description, sub_category_id) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(query);) {
            stmt.setString(1, product.getBrand());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getDescription());
            stmt.setInt(4, product.getSub_category_id());
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }

        String query1 = "INSERT INTO product_item (qty_in_stock, SKU, price, product_image, product_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query1);) {
            stmt.setInt(1, productItem.getQtyInStock());
            stmt.setString(2, productItem.getSKU());
            stmt.setDouble(3, productItem.getPrice());
            stmt.setString(4, productItem.getImageUrl());
            stmt.setInt(4, productItem.getProductItemId());

        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;

    }

    //Linkar as cores aos produtos
    public void linkColorWithProduct(ProductItem productItem, String color) throws SQLException {
        int variationOptionId = -1;

        String query1 = "SELECT variation_option_id FROM variation_option" +
                "WHERE value = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query1);) {
            stmt.setString(1, color);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                variationOptionId = rs.getInt("variation_option_id");
            }
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }


        String query = "INSERT INTO product_item_variation_option (product_item_id, variation_option_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query);) {
            stmt.setInt(1, productItem.getProductItemId());
            stmt.setInt(2, variationOptionId);
            stmt.executeUpdate();
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    //Linkar os tamanhos aos produtos
    public void linkSizeWithProduct(ProductItem productItem, String size) throws SQLException {
        int variationOptionId = -1;

        String query1 = "SELECT variation_option_id FROM variation_option" +
                "WHERE value = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query1);) {
            stmt.setString(1, size);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                variationOptionId = rs.getInt("variation_option_id");
            }
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }


        String query = "INSERT INTO product_item_variation_option (product_item_id, variation_option_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query);) {
            stmt.setInt(1, productItem.getProductItemId());
            stmt.setInt(2, variationOptionId);
            stmt.executeUpdate();
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }
    }



    //Busca produtos consoante os filtros
    public List<ProductDTO> getFilteredProducts(String category, String subcategory, String brand, String color,
                                                String size, String name, int page, int productsPerPage) {
        List<ProductDTO> products = new ArrayList<>();
        String sql = "SELECT pdv.*, sc.sub_category_name, c.category_name " +
                "FROM product_detailed_view_agg pdv " +
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
            sql += " AND pdv.variation_pairs LIKE ?";
        }
        if (size != null && !size.isEmpty()) {
            sql += " AND pdv.variation_pairs LIKE ?";
        }
        if (name != null && !name.isEmpty()) {
            sql += " AND pdv.name LIKE ?";
        }

        sql += " ORDER BY pdv.product_item_id LIMIT ? OFFSET ?";

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
                stmt.setString(index++, "%Color:" + color + "%");
            }
            if (size != null && !size.isEmpty()) {
                stmt.setString(index++, "%Size:" + size + "%");
            }
            if (name != null && !name.isEmpty()) {
                stmt.setString(index++, "%" + name + "%");
            }

            stmt.setInt(index++, productsPerPage);
            stmt.setInt(index, (page - 1) * productsPerPage);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setProductId(rs.getInt("product_id"));
                product.setProductItemId(rs.getInt("product_item_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setImage(rs.getString("product_image"));
                product.setStock(rs.getInt("stock"));

                // Separar variações da string variation_pairs
                String variationPairs = rs.getString("variation_pairs");
                if (variationPairs != null) {
                    for (String pair : variationPairs.split(",")) {
                        String[] parts = pair.split(":");
                        if (parts.length == 2) {
                            if (parts[0].equalsIgnoreCase("Color")) {
                                product.setColor(parts[1]);
                            } else if (parts[0].equalsIgnoreCase("Size")) {
                                product.setSize(parts[1]);
                            }
                        }
                    }
                }

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

/*
    public List<ProductDTO> getFilteredProducts(String category, String subcategory, String brand, String color,
                                                String size, String name, int page, int productsPerPage) {
        List<ProductDTO> products = new ArrayList<>();
        List<Integer> productIds = new ArrayList<>();

        // Parte 1: Buscar os product_ids paginados
        String idSql = "SELECT DISTINCT pdv.product_id FROM product_detailed_view_agg pdv " +
                "JOIN product_category_child sc ON pdv.sub_category_id = sc.sub_category_id " +
                "JOIN product_category_parent c ON sc.category_id = c.category_id " +
                "WHERE 1=1";
        if (category != null && !category.isEmpty()) idSql += " AND c.category_name = ?";
        if (subcategory != null && !subcategory.isEmpty()) idSql += " AND sc.sub_category_name = ?";
        if (brand != null && !brand.isEmpty()) idSql += " AND pdv.brand = ?";
        if (color != null && !color.isEmpty()) idSql += " AND (pdv.variation_type = 'Color' AND pdv.variation_value = ?)";
        if (size != null && !size.isEmpty()) idSql += " AND (pdv.variation_type = 'Size' AND pdv.variation_value = ?)";
        if (name != null && !name.isEmpty()) idSql += " AND pdv.name LIKE ?";
        idSql += " ORDER BY pdv.product_id LIMIT ? OFFSET ?";

        try (PreparedStatement idStmt = conn.prepareStatement(idSql)) {
            int index = 1;
            if (category != null && !category.isEmpty()) idStmt.setString(index++, category);
            if (subcategory != null && !subcategory.isEmpty()) idStmt.setString(index++, subcategory);
            if (brand != null && !brand.isEmpty()) idStmt.setString(index++, brand);
            if (color != null && !color.isEmpty()) idStmt.setString(index++, color);
            if (size != null && !size.isEmpty()) idStmt.setString(index++, size);
            if (name != null && !name.isEmpty()) idStmt.setString(index++, "%" + name + "%");
            idStmt.setInt(index++, productsPerPage);
            idStmt.setInt(index, (page - 1) * productsPerPage);

            ResultSet idRs = idStmt.executeQuery();
            while (idRs.next()) {
                productIds.add(idRs.getInt("product_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return products;
        }

        if (productIds.isEmpty()) return products;

        // Parte 2: Buscar os dados das variações por product_item_id
        String dataSql = "SELECT * FROM product_detailed_view pdv " +
                "JOIN product_category_child sc ON pdv.sub_category_id = sc.sub_category_id " +
                "JOIN product_category_parent c ON sc.category_id = c.category_id " +
                "WHERE pdv.product_id IN (" +
                productIds.stream().map(id -> "?").collect(Collectors.joining(", ")) +
                ") ORDER BY pdv.product_id, pdv.product_item_id";

        try (PreparedStatement stmt = conn.prepareStatement(dataSql)) {
            int idx = 1;
            for (Integer id : productIds) {
                stmt.setInt(idx++, id);
            }

            ResultSet rs = stmt.executeQuery();

            Map<Integer, ProductDTO> productItemMap = new HashMap<>();

            while (rs.next()) {
                int productItemId = rs.getInt("product_item_id");
                int productId = rs.getInt("product_id");
                ProductDTO product = productItemMap.get(productId);
                if (product == null) {
                    product = new ProductDTO();
                    product.setProductId(rs.getInt("product_id"));
                    product.setProductItemId(productItemId);
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setBrand(rs.getString("brand"));
                    product.setPrice(rs.getDouble("price"));
                    product.setImage(rs.getString("product_image"));
                    product.setStock(rs.getInt("stock"));
                    productItemMap.put(productItemId, product);
                }

                String variationType = rs.getString("variation_type");
                String variationValue = rs.getString("variation_value");

                if ("Color".equalsIgnoreCase(variationType)) {
                    product.setColor(variationValue);
                } else if ("Size".equalsIgnoreCase(variationType)) {
                    product.setSize(variationValue);
                }
            }

            products.addAll(productItemMap.values());

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
*/




    public static int getTotalProducts(String category, String subcategory, String brand, String color, String size, String name) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(DISTINCT pdv.product_item_id) AS total " +
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
