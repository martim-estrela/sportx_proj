package org.sportx.sportx.util;

import org.sportx.sportx.model.User;
import org.sportx.sportx.model.AddressInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class UserDAO {

    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // Método para guardar o utilizador na base de dados
    public boolean saveUser(User user) {
        // Primeira query para inserir o usuário na tabela 'user'
        String query = "INSERT INTO user (email, password, phone_number, name, status, user_type, register_date) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {

            // Definindo os parâmetros da consulta
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getPhoneNumber());
            ps.setString(4, user.getName());
            ps.setString(5, "Active");
            ps.setString(6, user.getUserType());
            ps.setDate(7, java.sql.Date.valueOf(user.getRegisterDate()));

            // Executando a inserção e verificando se as linhas foram afetadas
            int rowsAffected = ps.executeUpdate();

            // Se a inserção foi bem-sucedida, obter o user_id gerado
            if (rowsAffected > 0) {
                // Obter o ID gerado para o utilizador
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        // Recuperando o user_id gerado
                        int generatedUserId = generatedKeys.getInt(1);
                        user.setUserId(generatedUserId); // Atualizando o userId no objeto user
                    }
                }

                // Agora, inserindo na tabela address_info, associando o novo user_id
                String insertAddressQuery = "INSERT INTO address_info (street, country, city, postal_code, user_id) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement psAddress = conn.prepareStatement(insertAddressQuery)) {
                    // Inserindo o endereço associado ao novo utilizador
                    psAddress.setString(1, null);  // Defina como null ou qualquer valor desejado
                    psAddress.setString(2, null);  // Defina como null ou qualquer valor desejado
                    psAddress.setString(3, null);  // Defina como null ou qualquer valor desejado
                    psAddress.setString(4, null);  // Defina como null ou qualquer valor desejado
                    psAddress.setInt(5, user.getUserId());  // Associando o user_id

                    // Executa a inserção do endereço
                    int addressRowsAffected = psAddress.executeUpdate();
                    return addressRowsAffected > 0;  // Se o endereço foi inserido com sucesso
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // Se a inserção do usuário ou do endereço falhou
    }

    // Método para atualizar utilizador
    public void updateUser(User user) throws SQLException {
        // Se a senha foi alterada
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            String sql = "UPDATE user SET name = ?, email = ?, password = ?, phone_number = ?, user_type = ?, status = ?,register_date = ?  WHERE user_id = ?";

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, user.getName());
                stmt.setString(2, user.getEmail());
                stmt.setString(3, user.getPassword()); // Em produção, usar senha criptografada
                stmt.setString(4, user.getPhoneNumber());
                stmt.setString(5, user.getUserType());
                stmt.setString(6, user.getStatus());
                stmt.setDate(7, java.sql.Date.valueOf(user.getRegisterDate()));
                stmt.setInt(8, user.getUserId());

                stmt.executeUpdate();
            }
        }
        // Se a senha não foi alterada
        else {
            String sql = "UPDATE user SET name = ?, email = ?, phone_number = ?, user_type = ?, status = ?, register_date = ? WHERE user_id = ?";

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, user.getName());
                stmt.setString(2, user.getEmail());
                stmt.setString(3, user.getPhoneNumber());
                stmt.setString(4, user.getUserType());
                stmt.setString(5, user.getStatus());
                stmt.setDate(6, java.sql.Date.valueOf(user.getRegisterDate()));
                stmt.setInt(7, user.getUserId());

                stmt.executeUpdate();
            }
        }
    }


    // Método para encontrar o utilizador pelo email e senha
    public User getUserByEmailAndPassword(String email, String password) {
        String query = "SELECT * FROM user WHERE email = ? AND password = ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {


            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Se o utilizador for encontrado, cria e retorna um objeto User
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone_number"),
                        rs.getString("name"),
                        rs.getString("user_type"),
                        rs.getString("Status"),
                        rs.getDate("register_date").toLocalDate()
                );
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;  // Se o utilizador não for encontrado, retorna null
    }

    // Método para encontrar o utilizador pelo email e senha
    public User getUserById(int userId) {
        String query = "SELECT * FROM user WHERE user_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {


            ps.setInt(1, userId);


            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Se o utilizador for encontrado, cria e retorna um objeto User
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone_number"),
                        rs.getString("name"),
                        rs.getString("user_type"),
                        rs.getString("Status"),
                        rs.getDate("register_date").toLocalDate()
                );
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;  // Se o utilizador não for encontrado, retorna null
    }

    //Metodo para encontrar endereço
    public AddressInfo getUserAddress(int userId) {
        String query = "SELECT * FROM address_info WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Se o endereço existir, cria e retorna o objeto AddressInfo
                return new AddressInfo(
                        rs.getInt("address_id"),
                        rs.getString("street"),
                        rs.getString("country"),
                        rs.getString("city"),
                        rs.getString("postal_code")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Caso não haja endereço, retorna null
    }

    // Método para atualizar os dados do usuário e o endereço
    public boolean updateUserAndAddress(User user, AddressInfo addressInfo) {
        boolean isUserUpdated = false;
        boolean isAddressUpdated = false;

        // Atualiza os dados do usuário
        String updateUserQuery = "UPDATE user SET name = ?, email = ?, phone_number = ? WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(updateUserQuery)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhoneNumber());
            ps.setInt(4, user.getUserId());  // Garantir que o user_id está sendo passado corretamente

            int rowsAffected = ps.executeUpdate();
            isUserUpdated = rowsAffected > 0;  // Verifica se a atualização do usuário foi bem-sucedida
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Atualiza o endereço
        String updateAddressQuery = "UPDATE address_info\n" +
                                    "SET street = ?, country = ?, city = ?, postal_code = ?\n" +
                                    "WHERE user_id = ?;";
        try (PreparedStatement ps = conn.prepareStatement(updateAddressQuery)) {
            ps.setString(1, addressInfo.getStreet());
            ps.setString(2, addressInfo.getCountry());
            ps.setString(3, addressInfo.getCity());
            ps.setString(4, addressInfo.getPostalCode());
            ps.setInt(5, user.getUserId());  // Garantir que o user_id está sendo passado corretamente

            int rowsAffected = ps.executeUpdate();
            isAddressUpdated = rowsAffected > 0;  // Verifica se a atualização do endereço foi bem-sucedida
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Retorna true se ambos foram atualizados com sucesso
        return isUserUpdated && isAddressUpdated;
    }

    //Metodo para mostrar todos os utilizadores
    public List<User> getUsers(String roleFilter, String nameFilter , int page, int usersPerPage) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE 1=1"; // Começa com WHERE 1=1 para facilitar adição de filtros

        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql += " AND user_type = ?";
        }
        if (nameFilter != null && !nameFilter.isEmpty()) {
            sql += " AND name LIKE ?";
        }

        // Adicionar ordem e paginação
        sql += " ORDER BY user_id LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            int index = 1;
            if (roleFilter != null && !roleFilter.isEmpty()) {
                stmt.setString(index++, roleFilter); // roleFilter é "user" ou "admin"
            }
            if (nameFilter != null && !nameFilter.isEmpty()) {
                stmt.setString(index++, "%" + nameFilter + "%");
            }

            // Parâmetros de paginação
            stmt.setInt(index++, usersPerPage);
            stmt.setInt(index++, (page - 1) * usersPerPage);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone_number"),
                        rs.getString("name"),
                        rs.getString("user_type"), // Aqui você terá "user" ou "admin"
                        rs.getString("Status"),
                        rs.getDate("register_date").toLocalDate()
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    //Método para obter o numero total de paginas
    public int getTotalPages(String roleFilter, String nameFilter) {
        int totalPages = 0;
        String sql = "SELECT COUNT(*) FROM user WHERE 1=1";

        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql += " AND user_type = ?";
        }
        if (nameFilter != null && !nameFilter.isEmpty()) {
            sql += " AND name LIKE ?";
        }

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            int index = 1;
            if (roleFilter != null && !roleFilter.isEmpty()) {
                stmt.setString(index++, roleFilter);
            }
            if (nameFilter != null && !nameFilter.isEmpty()) {
                stmt.setString(index++, "%" + nameFilter + "%");
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int totalItems = rs.getInt(1);
                totalPages = (int) Math.ceil((double) totalItems / 10);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalPages;
    }

    //Alterar status de um utilizador
    public boolean updateUserStatus(int userId, String newStatus) {
        String sql = "UPDATE user SET status = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //eliminar utilizador
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM user WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }


    /* Metodo para obter todos os usuários para o relatório PDF, aplicando os filtros mas sem paginação */
    public List<User> getAllUsersForReport(String roleFilter, String nameFilter) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE 1=1";

        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql += " AND user_type = ?";
        }
        if (nameFilter != null && !nameFilter.isEmpty()) {
            sql += " AND name LIKE ?";
        }

        // Ordenar por ID
        sql += " ORDER BY user_id";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            int index = 1;
            if (roleFilter != null && !roleFilter.isEmpty()) {
                stmt.setString(index++, roleFilter);
            }
            if (nameFilter != null && !nameFilter.isEmpty()) {
                stmt.setString(index++, "%" + nameFilter + "%");
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone_number"),
                        rs.getString("name"),
                        rs.getString("user_type"),
                        rs.getString("Status"),
                        rs.getDate("register_date").toLocalDate()
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

}

