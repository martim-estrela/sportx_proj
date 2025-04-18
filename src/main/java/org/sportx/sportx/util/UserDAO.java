package org.sportx.sportx.util;

import org.sportx.sportx.model.User;
import org.sportx.sportx.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

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

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

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
}
