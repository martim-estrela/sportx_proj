package org.sportx.sportx.util;

import org.sportx.sportx.model.Product;
import org.sportx.sportx.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object para os produtos
 */
public class ProductDAO {

    /**
     * Obtém todos os produtos da base de dados
     * @return Lista de produtos
     */
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            // Query corrigida para selecionar produtos com os seus preços e imagens
            // A relação entre product e product_item é de 1 para 1
            String sql = "SELECT p.product_id, p.name, p.description, pi.price, pi.product_image " +
                    "FROM product p " +
                    "LEFT JOIN product_item pi ON p.product_id = pi.product_id " +
                    "WHERE pi.product_item_id IS NOT NULL";

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("product_image"));

                products.add(product);
            }

            // Se não houver produtos, criar alguns produtos de exemplo para testes
            if (products.isEmpty()) {
                // Produtos de exemplo para demonstração
                Product product1 = new Product(1, "MERREL MOAB 3", "Hiking shoes for all terrains", 149.00, "/img/MerrelMoab3.jpg");
                Product product2 = new Product(2, "SALOMON X ULTRA 4", "Premium hiking shoes", 175.00, "/img/SalomonXUltra4.jpg");
                Product product3 = new Product(3, "DANNER TRAIL 2650", "Durable trail shoes", 169.00, "/img/DannerTrail2650.jpg");
                Product product4 = new Product(4, "TIMBERLAND MT. MADDSEN", "Classic outdoor boots", 120.00, "/img/TimberlandMtMaddsen.jpg");

                products.add(product1);
                products.add(product2);
                products.add(product3);
                products.add(product4);

                System.out.println("Atenção: A retornar produtos de exemplo pois não foram encontrados dados na base de dados.");
            }

        } catch (SQLException e) {
            // Em produção, utilizar um logger em vez de printStackTrace
            e.printStackTrace();

            // Adicionar produtos de exemplo em caso de erro de conexão
            Product product1 = new Product(1, "MERREL MOAB 3", "Hiking shoes for all terrains", 149.00, "/img/MerrelMoab3.jpg");
            Product product2 = new Product(2, "SALOMON X ULTRA 4", "Premium hiking shoes", 175.00, "/img/SalomonXUltra4.jpg");
            products.add(product1);
            products.add(product2);

            System.out.println("Erro de conexão: A retornar produtos de exemplo. Erro: " + e.getMessage());
        }

        return products;
    }

    /**
     * Filtra produtos por categoria
     * @param categoryId ID da categoria
     * @return Lista de produtos filtrados
     */
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            // Query corrigida para usar LEFT JOIN e checar a existência de product_item
            String sql = "SELECT p.product_id, p.name, p.description, pi.price, pi.product_image " +
                    "FROM product p " +
                    "LEFT JOIN product_item pi ON p.product_id = pi.product_id " +
                    "JOIN product_category_child pcc ON p.sub_category_id = pcc.sub_category_id " +
                    "WHERE pcc.category_id = ? AND pi.product_item_id IS NOT NULL";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("product_image"));

                products.add(product);
            }

            // Se não forem encontrados produtos, retorna produtos de exemplo com a categoria correspondente
            if (products.isEmpty()) {
                // Aqui poderíamos retornar produtos específicos por categoria
                return getAllProducts(); // Retorna todos os produtos como fallback
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return getAllProducts(); // Em caso de erro, retorna todos os produtos
        }

        return products;
    }

    /**
     * Pesquisa produtos por nome
     * @param searchTerm Termo de pesquisa
     * @return Lista de produtos que correspondem à pesquisa
     */
    public List<Product> searchProducts(String searchTerm) {
        List<Product> products = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            // Query corrigida para usar LEFT JOIN e checar a existência de product_item
            String sql = "SELECT p.product_id, p.name, p.description, pi.price, pi.product_image " +
                    "FROM product p " +
                    "LEFT JOIN product_item pi ON p.product_id = pi.product_id " +
                    "WHERE (p.name LIKE ? OR p.description LIKE ?) AND pi.product_item_id IS NOT NULL";

            PreparedStatement stmt = conn.prepareStatement(sql);
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("product_image"));

                products.add(product);
            }

            // Se não forem encontrados produtos na pesquisa, retorna produtos que contêm o termo apenas no nome
            if (products.isEmpty()) {
                List<Product> allProducts = getAllProducts();
                for (Product p : allProducts) {
                    if (p.getName().toLowerCase().contains(searchTerm.toLowerCase())) {
                        products.add(p);
                    }
                }

                if (!products.isEmpty()) {
                    System.out.println("Foram encontrados " + products.size() + " produtos nos dados de exemplo.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();

            // Em caso de erro, tenta encontrar nos produtos de exemplo
            List<Product> allProducts = getAllProducts();
            for (Product p : allProducts) {
                if (p.getName().toLowerCase().contains(searchTerm.toLowerCase())) {
                    products.add(p);
                }
            }
        }

        return products;
    }
}