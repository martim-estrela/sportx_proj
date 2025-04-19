package org.sportx.sportx.util;

import org.sportx.sportx.model.User;
import org.sportx.sportx.util.DBConnection;

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
    public boolean saveUser(User user)
    {
        String query = "INSERT INTO user (email, password, phone_number, name, user_type, register_date) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {

            // Definindo os parâmetros da consulta
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getPhoneNumber());
            ps.setString(4, user.getName());
            ps.setString(5, user.getUserType());
            ps.setDate(6, java.sql.Date.valueOf(user.getRegisterDate()));

            // Executando a inserção e verificando se as linhas foram afetadas
            int rowsAffected = ps.executeUpdate();

            // Se a inserção foi bem-sucedida, obter o user_id gerado
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        // Recuperando o user_id gerado
                        int generatedUserId = generatedKeys.getInt(1);
                        user.setUserId(generatedUserId); // Atualizando o userId no objeto user
                    }
                }
                return true; // Inserção bem-sucedida
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Se a inserção falhou
    }

    // Método para buscar o usuário pelo email e senha
    public User getUserByEmailAndPassword(String email, String password) {
        String query = "SELECT * FROM user WHERE email = ? AND password = ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {


            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Se o usuário for encontrado, cria e retorna um objeto User
                User user = new User(
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone_number"),
                        rs.getString("name"),
                        rs.getString("user_type"),
                        rs.getDate("register_date").toLocalDate()
                );
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;  // Se o usuário não for encontrado, retorna null
    }

    public List<User> getUsers(String roleFilter, String subRoleFilter, String nameFilter) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE 1=1";

        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql += " AND user_type = ?";
        }
        if (subRoleFilter != null && !subRoleFilter.isEmpty()) {
            sql += " AND sub_role = ?";
        }
        if (nameFilter != null && !nameFilter.isEmpty()) {
            sql += " AND name LIKE ?";
        }

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {


            int index = 1;
            if (roleFilter != null && !roleFilter.isEmpty()) {
                stmt.setString(index++, roleFilter);
            }
            if (subRoleFilter != null && !subRoleFilter.isEmpty()) {
                stmt.setString(index++, subRoleFilter);
            }
            if (nameFilter != null && !nameFilter.isEmpty()) {
                stmt.setString(index++, "%" + nameFilter + "%");
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone_number"),
                        rs.getString("name"),
                        rs.getString("role"), // ou userType
                        rs.getDate("register_date").toLocalDate()
                );
                user.setUserId(rs.getInt("user_id"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

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

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM user WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<String> getAllRoles() throws SQLException {
        List<String> roles = new ArrayList<>();
        String sql = "SELECT DISTINCT user_type FROM user";
        try (PreparedStatement stmt = conn.prepareStatement(sql);

             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                roles.add(rs.getString("user_type")); // corresponde ao SELECT
            }
        }
        return roles;
    }


    public List<String> getAllSubRoles() throws SQLException {
        List<String> subRoles = new ArrayList<>();
        String sql = "SELECT DISTINCT sub_role FROM user";
        try (PreparedStatement stmt = conn.prepareStatement(sql);

             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                subRoles.add(rs.getString("sub_role"));
            }
        }
        return subRoles;
    }
}
