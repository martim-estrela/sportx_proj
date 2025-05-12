package org.sportx.sportx.util;

import org.sportx.sportx.DTO.ProductItemDTO;
import org.sportx.sportx.model.Product;
import org.sportx.sportx.model.ProductItem;
import org.sportx.sportx.model.Promotion;

import java.sql.*;
import java.time.LocalDate;
import java.util.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

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
        List<Object> countParams = new ArrayList<>();

        // Query principal: produto + product_item de menor preço (único)
        queryBuilder.append("SELECT p.product_id, p.name, p.description, p.brand, pi.price, pi.product_image ");
        queryBuilder.append("FROM product p ");
        queryBuilder.append("JOIN product_item pi ON pi.product_item_id = ( ");
        queryBuilder.append("    SELECT pi2.product_item_id ");
        queryBuilder.append("    FROM product_item pi2 ");
        queryBuilder.append("    WHERE pi2.product_id = p.product_id ");

        // Filtros de preço na subquery para garantir que o product_item escolhido respeita o filtro
        if (selectedPrices != null && selectedPrices.length > 0) {
            queryBuilder.append(" AND (");
            List<String> priceConditions = new ArrayList<>();
            for (String priceRange : selectedPrices) {
                switch (priceRange) {
                    case "0-50":
                        priceConditions.add("pi2.price >= 0 AND pi2.price <= 50");
                        break;
                    case "50-100":
                        priceConditions.add("pi2.price > 50 AND pi2.price <= 100");
                        break;
                    case "100-150":
                        priceConditions.add("pi2.price > 100 AND pi2.price <= 150");
                        break;
                    case "150+":
                        priceConditions.add("pi2.price > 150");
                        break;
                }
            }
            queryBuilder.append(String.join(" OR ", priceConditions));
            queryBuilder.append(") ");
        }

        queryBuilder.append("    ORDER BY pi2.price ASC, pi2.product_item_id ASC ");
        queryBuilder.append("    LIMIT 1 ");
        queryBuilder.append(") ");

        // Construção da cláusula WHERE para filtros que não são de product_item (marca, pesquisa)
        List<String> whereConditions = new ArrayList<>();

        // Filtro por marcas
        if (selectedBrands != null && selectedBrands.length > 0) {
            StringBuilder brandCondition = new StringBuilder("p.brand IN (");
            for (int i = 0; i < selectedBrands.length; i++) {
                if (i > 0) brandCondition.append(", ");
                brandCondition.append("?");
                params.add(selectedBrands[i]);
            }
            brandCondition.append(")");
            whereConditions.add(brandCondition.toString());
        }

        // Filtro por termo de pesquisa
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            whereConditions.add("(p.name LIKE ? OR p.description LIKE ? OR p.brand LIKE ?)");
            String searchPattern = "%" + searchTerm.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Adiciona cláusula WHERE se existirem condições
        if (!whereConditions.isEmpty()) {
            queryBuilder.append(" WHERE ").append(String.join(" AND ", whereConditions));
        }

        // Ordenação
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

        // Paginação
        queryBuilder.append(" LIMIT ? OFFSET ?");
        int offset = (page - 1) * productsPerPage;

        // --- Query de contagem ---
        countQueryBuilder.append("SELECT COUNT(*) AS total FROM product p ");

        // Filtros na contagem: marca e pesquisa (mesmos que na query principal)
        List<String> countWhereConditions = new ArrayList<>();

        if (selectedBrands != null && selectedBrands.length > 0) {
            StringBuilder brandCondition = new StringBuilder("p.brand IN (");
            for (int i = 0; i < selectedBrands.length; i++) {
                if (i > 0) brandCondition.append(", ");
                brandCondition.append("?");
                countParams.add(selectedBrands[i]);
            }
            brandCondition.append(")");
            countWhereConditions.add(brandCondition.toString());
        }

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            countWhereConditions.add("(p.name LIKE ? OR p.description LIKE ? OR p.brand LIKE ?)");
            String searchPattern = "%" + searchTerm.trim() + "%";
            countParams.add(searchPattern);
            countParams.add(searchPattern);
            countParams.add(searchPattern);
        }

        // Filtro de preço na contagem: produtos que tenham pelo menos um product_item dentro do filtro
        if (selectedPrices != null && selectedPrices.length > 0) {
            List<String> priceConditions = new ArrayList<>();
            for (String priceRange : selectedPrices) {
                switch (priceRange) {
                    case "0-50":
                        priceConditions.add("pi.price >= 0 AND pi.price <= 50");
                        break;
                    case "50-100":
                        priceConditions.add("pi.price > 50 AND pi.price <= 100");
                        break;
                    case "100-150":
                        priceConditions.add("pi.price > 100 AND pi.price <= 150");
                        break;
                    case "150+":
                        priceConditions.add("pi.price > 150");
                        break;
                }
            }
            if (!priceConditions.isEmpty()) {
                String existsCondition = "EXISTS (SELECT 1 FROM product_item pi WHERE pi.product_id = p.product_id AND ("
                        + String.join(" OR ", priceConditions) + "))";
                countWhereConditions.add(existsCondition);
            }
        }

        if (!countWhereConditions.isEmpty()) {
            countQueryBuilder.append(" WHERE ").append(String.join(" AND ", countWhereConditions));
        }

        // --- Executa query de contagem ---
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement countStmt = conn.prepareStatement(countQueryBuilder.toString())) {

            for (int i = 0; i < countParams.size(); i++) {
                countStmt.setObject(i + 1, countParams.get(i));
            }

            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalCount = countRs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println("Error counting filtered products: " + e.getMessage());
            e.printStackTrace();
        }

        // --- Executa query principal ---
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(queryBuilder.toString())) {

            int paramIndex = 1;
            for (Object param : params) {
                pstmt.setObject(paramIndex++, param);
            }
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

    public List<Product> getSimilarProducts(int productId, String brand) {
        List<Product> similarProducts = new ArrayList<>();
        String query =
                "SELECT p.product_id, p.name, p.description, p.brand, pi.price, pi.product_image " +
                        "FROM product p " +
                        "JOIN product_item pi ON p.product_id = pi.product_id " +
                        "WHERE p.brand = ? AND p.product_id != ? " +
                        "AND pi.product_item_id = ( " +
                        "    SELECT pi2.product_item_id " +
                        "    FROM product_item pi2 " +
                        "    WHERE pi2.product_id = p.product_id " +
                        "    ORDER BY pi2.price ASC " +
                        "    LIMIT 1 " +
                        ") " +
                        "GROUP BY p.product_id, p.name, p.description, p.brand, pi.price, pi.product_image " +
                        "ORDER BY pi.price ASC " +
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

    public List<ProductItemDTO> getProductItemsByProductId(int productId) {
        List<ProductItemDTO> productItems = new ArrayList<>();
        String sql = "SELECT p.*, promo.promotion_id, promo.name as promo_name, promo.description as promo_desc, " +
                "promo.discount_rate, promo.start_date, promo.end_date " +
                "FROM product_detailed_view_agg p " +
                "LEFT JOIN promotion promo ON p.product_item_id = promo.product_item_id " +
                "WHERE p.product_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductItemDTO item = new ProductItemDTO();
                item.setProductItemId(rs.getInt("product_item_id"));
                item.setPrice(rs.getDouble("price"));
                item.setQtyInStock(rs.getInt("stock"));
                item.setImageUrl(rs.getString("product_image"));
                item.setVariationPairs(rs.getString("variation_pairs"));

                int promoId = rs.getInt("promotion_id");
                if (!rs.wasNull()) {
                    String promoName = rs.getString("promo_name");
                    String promoDesc = rs.getString("promo_desc");
                    Double discountRate = rs.getObject("discount_rate") != null ? rs.getDouble("discount_rate") : null;

                    Date sqlStartDate = rs.getDate("start_date");
                    Date sqlEndDate = rs.getDate("end_date");

                    LocalDate startDate = (sqlStartDate != null) ? sqlStartDate.toLocalDate() : null;
                    LocalDate endDate = (sqlEndDate != null) ? sqlEndDate.toLocalDate() : null;

                    if (discountRate != null && startDate != null && endDate != null) {
                        Promotion promo = new Promotion(
                                promoId,
                                promoName,
                                promoDesc,
                                discountRate,
                                startDate,
                                endDate
                        );

                        if (promo.isActive()) {
                            double discountedPrice = item.getPrice() * (1 - (discountRate / 100));
                            item.setDiscountRate(discountRate);
                            item.setDiscountedPrice(Math.round(discountedPrice * 100.0) / 100.0); // Arredonda para 2 casas decimais
                        } else {
                            item.setDiscountRate(0.0);
                            item.setDiscountedPrice(item.getPrice());
                        }
                    } else {
                        item.setDiscountRate(0.0);
                        item.setDiscountedPrice(item.getPrice());
                    }
                } else {
                    item.setDiscountRate(0.0);
                    item.setDiscountedPrice(item.getPrice());
                }

                productItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productItems;
    }


}