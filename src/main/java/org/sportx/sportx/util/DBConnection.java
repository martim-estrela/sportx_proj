package org.sportx.sportx.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException {
        // Definindo as credenciais de conexão
        String url = "jdbc:mysql://localhost:3306/sportx_db";
        String user = "sportx";
        String password = "sportx!123456789";

        // Tenta carregar o driver do MySQL
        try {
            // Certifique-se de que o driver JDBC do MySQL esteja carregado
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC MySQL não encontrado.", e);
        }

        // Retorna a conexão com o banco de dados
        return DriverManager.getConnection(url, user, password);
    }
}