package org.sportx.sportx.dao;

import org.sportx.sportx.model.Product;
import org.sportx.sportx.util.DBConnection;

import java.sql.*;
import java.util.*;

public class ProductDAO {

    /**
     * Retrieves all unique brands from the product table
     * @return List of all unique brands
     */
    public List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        // Debug output to see the SQL
        System.out.println("Executing query: SELECT DISTINCT brand FROM product WHERE brand IS NOT NULL ORDER BY brand");

        String query = "SELECT DISTINCT brand FROM product WHERE brand IS NOT NULL ORDER BY brand";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            System.out.println("Brand results:");
            while (rs.next()) {
                String brand = rs.getString("brand");
                // Debug output for each brand
                System.out.println("Found brand: " + brand);
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

        // Brand filter
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

        // Debug complete SQL
        System.out.println("Final SQL: " + queryBuilder.toString());
        System.out.println("With params: " + params);

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
                // Assuming we have a view or logic for product popularity
                // For now, we'll sort by product_id as a placeholder
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

            // If no products are found, add some defaults for testing
            if (products.isEmpty()) {
                System.out.println("No products found, adding sample data");
                Product sample1 = new Product(1, "Sample Running Shoes", "Running shoes for all terrains", "Nike", 99.99, "/img/MerrelMoab3.jpg");
                Product sample2 = new Product(2, "Trail Hiking Boots", "Waterproof hiking boots", "Adidas", 149.99, "/img/SalomonXUltra4.jpg");
                Product sample3 = new Product(3, "Fitness Tracker", "Activity monitor", "Garmin", 199.99, "/img/GarminForerunner55.jpg");

                products.add(sample1);
                products.add(sample2);
                products.add(sample3);

                totalCount = 3;
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving filtered products: " + e.getMessage());
            e.printStackTrace();

            // Add sample products in case of error
            Product sample1 = new Product(1, "Sample Running Shoes", "Running shoes for all terrains", "Nike", 99.99, "/img/MerrelMoab3.jpg");
            Product sample2 = new Product(2, "Trail Hiking Boots", "Waterproof hiking boots", "Adidas", 149.99, "/img/SalomonXUltra4.jpg");
            Product sample3 = new Product(3, "Fitness Tracker", "Activity monitor", "Garmin", 199.99, "/img/GarminForerunner55.jpg");

            products.add(sample1);
            products.add(sample2);
            products.add(sample3);

            totalCount = 3;
        }

        result.put("products", products);
        result.put("totalCount", totalCount);

        return result;
    }
}