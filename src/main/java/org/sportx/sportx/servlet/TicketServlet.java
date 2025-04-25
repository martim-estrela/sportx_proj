package org.sportx.sportx.servlet;

import org.sportx.sportx.model.Ticket;
import org.sportx.sportx.model.User;
import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.TicketDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/submit-message")
public class TicketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Obter os parâmetros do formulário
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Obter dados do usuário logado
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Se o usuário não estiver logado, redireciona para a página de login
        if (user == null) {
            response.sendRedirect("Loginpage.jsp");
            return;
        }

        // Cria o objeto Ticket
        Ticket newTicket = new Ticket(0, LocalDate.now(), email, "Open", subject, message);

        // Salvar o ticket no banco de dados
        try (Connection conn = DBConnection.getConnection()) {
            TicketDAO ticketDAO = new TicketDAO(conn);
            ticketDAO.inserir(newTicket, user);
            response.sendRedirect("TicketConfirmation.jsp");  // Redireciona para uma página de confirmação
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ContactUs.jsp?error=true");  // Redireciona com erro caso falhe
        }
    }
}
