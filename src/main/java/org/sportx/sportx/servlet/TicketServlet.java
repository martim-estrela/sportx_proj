package org.sportx.sportx.servlet;


import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.sportx.sportx.model.Ticket;
import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.TicketDAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/TicketServlet")
public class TicketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            TicketDAO dao = new TicketDAO(conn);

            String email = request.getParameter("email");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            Ticket ticket = new Ticket(
                    0, // ID será gerado pela BD
                    LocalDate.now(),
                    email,
                    "Aberto",
                    subject,
                    message
            );

            dao.inserir(ticket);
            response.sendRedirect("confirmacao.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            TicketDAO dao = new TicketDAO(conn);
            List<Ticket> tickets = dao.listarTodos();
            request.setAttribute("listaTickets", tickets);
            request.getRequestDispatcher("listarTickets.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
        }
    }
}
