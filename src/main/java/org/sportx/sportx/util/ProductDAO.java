package org.sportx.sportx.util;

import org.sportx.sportx.model.Product;
import org.sportx.sportx.model.Promotion;

import java.sql.*;
import java.time.LocalDate;
import java.util.*;

public class ProductDAO {

    /**
     * Retrieves all unique brands from the product table
     * @return List of all unique brands
     */
    public List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        String query = "SELECT DISTINCT brand FROM product WHERE brand IS NOT NULL ORDER BY brand";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                String brand = rs.getString("brand");
                if (brand != null && !brand.trim().isEmpty()) {
                    brands.add(brand);
                }
            }

            // If no brands were found, add some defaults for testing
            if (brands.isEmpty()) {
                System.out.println("No brands found in database, adding defaults");
                brands.add("Nike");
                brands.add("Adidas");
                brands.add("Puma");
                brands.add("Reebok");
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving brands: " + e.getMessage());
            e.printStackTrace();

            // Add default brands in case of error
            brands.add("Nike");
            brands.add("Adidas");
            brands.add("Puma");
            brands.add("Reebok");
        }

        return brands;
    }

    /**
     * Gets filtered and sorted products with pagination
     * @param selectedBrands Array of selected brand names
     * @param selectedPrices Array of selected price ranges
     * @param sortBy Sorting option
     * @param searchTerm Search term for product name
     * @param page Current page number
     * @param productsPerPage Number of products per page
     * @return Map containing the filtered products and total count
     */
    public Map<String, Object> getFilteredProducts(String[] selectedBrands, String[] selectedPrices,
                                                   String sortBy, String searchTerm, int page, int productsPerPage) {
        Map<String, Object> result = new HashMap<>();
        List<Product> products = new ArrayList<>();
        int totalCount = 0;

        StringBuilder queryBuilder = new StringBuilder();
        StringBuilder countQueryBuilder = new StringBuilder();
        List<Object> params = new ArrayList<>();

        // Base query to join product and product_item tables
        queryBuilder.append("SELECT p.product_id, p.name, p.description, p.brand, pi.price, pi.product_image ");
        queryBuilder.append("FROM product p ");
        queryBuilder.append("JOIN product_item pi ON p.product_id = pi.product_id ");

        // Count query for pagination
        countQueryBuilder.append("SELECT COUNT(*) AS total ");
        countQueryBuilder.append("FROM product p ");
        countQueryBuilder.append("JOIN product_item pi ON p.product_id = pi.product_id ");

        // Building WHERE clause for filtering
        List<String> whereConditions = new ArrayList<>();

        // Brand filter - FIXED: Now correctly filters by brand field
        if (selectedBrands != null && selectedBrands.length > 0) {
            StringBuilder brandCondition = new StringBuilder("p.brand IN (");
            for (int i = 0; i < selectedBrands.length; i++) {
                if (i > 0) {
                    brandCondition.append(", ");
                }
                brandCondition.append("?");
                params.add(selectedBrands[i]);
            }
            brandCondition.append(")");
            whereConditions.add(brandCondition.toString());
        }

        // Price filter
        if (selectedPrices != null && selectedPrices.length > 0) {
            List<String> priceConditions = new ArrayList<>();

            for (String priceRange : selectedPrices) {
                switch (priceRange) {
                    case "0-50":
                        priceConditions.add("(pi.price >= 0 AND pi.price <= 50)");
                        break;
                    case "50-100":
                        priceConditions.add("(pi.price > 50 AND pi.price <= 100)");
                        break;
                    case "100-150":
                        priceConditions.add("(pi.price > 100 AND pi.price <= 150)");
                        break;
                    case "150+":
                        priceConditions.add("(pi.price > 150)");
                        break;
                }
            }

            if (!priceConditions.isEmpty()) {
                whereConditions.add("(" + String.join(" OR ", priceConditions) + ")");
            }
        }

        // Search term filter
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            whereConditions.add("(p.name LIKE ? OR p.description LIKE ? OR p.brand LIKE ?)");
            String searchPattern = "%" + searchTerm.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Append WHERE clause if there are conditions
        if (!whereConditions.isEmpty()) {
            queryBuilder.append(" WHERE ").append(String.join(" AND ", whereConditions));
            countQueryBuilder.append(" WHERE ").append(String.join(" AND ", whereConditions));
        }

        // Apply sorting
        switch (sortBy) {
            case "price_asc":
                queryBuilder.append(" ORDER BY pi.price ASC");
                break;
            case "price_desc":
                queryBuilder.append(" ORDER BY pi.price DESC");
                break;
            case "popularity":
            default:
                queryBuilder.append(" ORDER BY p.product_id DESC");
                break;
        }

        // Add pagination
        queryBuilder.append(" LIMIT ? OFFSET ?");
        int offset = (page - 1) * productsPerPage;

        // First get total count for pagination
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement countStmt = conn.prepareStatement(countQueryBuilder.toString())) {

            // Set parameters for count query
            for (int i = 0; i < params.size(); i++) {
                countStmt.setObject(i + 1, params.get(i));
            }

            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalCount = countRs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println("Error counting filtered products: " + e.getMessage());
            e.printStackTrace();
        }

        // Execute the main query with pagination
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(queryBuilder.toString())) {

            // Set parameters for main query
            int paramIndex = 1;
            for (Object param : params) {
                pstmt.setObject(paramIndex++, param);
            }

            // Add pagination parameters
            pstmt.setInt(paramIndex++, productsPerPage);
            pstmt.setInt(paramIndex, offset);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("product_image"));

                products.add(product);
            }


        } catch (SQLException e) {
            System.out.println("Error retrieving filtered products: " + e.getMessage());
            e.printStackTrace();

        }

        result.put("products", products);
        result.put("totalCount", totalCount);

        return result;
    }

    /**
     * Get product by its ID
     * @param productId The ID of the product to retrieve
     * @return Product object if found, null otherwise
     */
    public Product getProductById(int productId) {
        Product product = null;
        String query = "SELECT product_id, name, description, brand, sub_category_id, price, product_image, " +
                "promotion_id, discount_rate, start_date, end_date " +
                "FROM product_detailed_view WHERE product_id = ? LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("product_image"));

                // Verifica se tem promoção e cria o objeto com o construtor correto
                Double discountRate = rs.getObject("discount_rate") != null ? rs.getDouble("discount_rate") : null;
                if (discountRate != null) {
                    int promotion_id = rs.getInt("promotion_id");
                    LocalDate startDate = rs.getDate("start_date").toLocalDate();
                    LocalDate endDate = rs.getDate("end_date").toLocalDate();

                    Promotion promo = new Promotion(
                            promotion_id,
                            null,
                            null,
                            discountRate,
                            startDate,
                            endDate
                    );
                    product.setPromotion(promo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    // Método para buscar produtos similares
    public List<Product> getSimilarProducts(int productId, String brand) {
        List<Product> similarProducts = new ArrayList<>();
        String query = "SELECT product_id, name, description, brand, price, product_image " +
                "FROM product_detailed_view " +
                "WHERE brand = ? AND product_id != ? " +
                "GROUP BY product_id " +
                "LIMIT 4";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, brand);
            pstmt.setInt(2, productId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("product_image"));
                similarProducts.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving similar products: " + e.getMessage());
            e.printStackTrace();
        }

        return similarProducts;
    }

    // Método para buscar tamanhos disponíveis
    public List<String> getAvailableSizes(int productId) throws SQLException {
        List<String> sizes = new ArrayList<>();

        String query = "SELECT DISTINCT variation_value " +
                "FROM product_detailed_view " +
                "WHERE product_id = ? " +
                "AND variation_type = 'Size' " +
                "AND stock > 0 " +
                "ORDER BY variation_value";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String size = rs.getString("variation_value");
                if (size != null && !size.trim().isEmpty()) {
                    sizes.add(size);
                }
            }
        }

        return sizes;
    }
}