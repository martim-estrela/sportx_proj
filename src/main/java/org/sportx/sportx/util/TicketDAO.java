package org.sportx.sportx.util;


import org.sportx.sportx.model.Ticket;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TicketDAO {
    private final Connection conn;

    public TicketDAO(Connection conn) {
        this.conn = conn;
    }

    public void inserir(Ticket ticket) throws SQLException {
        String sql = "INSERT INTO tickets (submission_date, email, ticket_status, subject, message) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, Date.valueOf(ticket.getSubmissionDate()));
            stmt.setString(2, ticket.getEmail());
            stmt.setString(3, ticket.getTicketStatus());
            stmt.setString(4, ticket.getSubject());
            stmt.setString(5, ticket.getMessage());
            stmt.executeUpdate();
        }
    }

    public List<Ticket> listarTodos() throws SQLException {
        List<Ticket> lista = new ArrayList<>();
        String sql = "SELECT * FROM tickets";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Ticket t = new Ticket(
                        rs.getInt("ticket_id"),
                        rs.getDate("submission_date").toLocalDate(),
                        rs.getString("email"),
                        rs.getString("ticket_status"),
                        rs.getString("subject"),
                        rs.getString("message")
                );
                lista.add(t);
            }
        }

        return lista;
    }

    // Outros métodos como buscarPorId, atualizar, eliminar podem ser adicionados se necessário
}
