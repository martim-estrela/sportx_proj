package org.sportx.sportx.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.UserDAO;
import org.sportx.sportx.model.User;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {

    // Método para processar o sign up
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // Obtém os parâmetros do formulário
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phonenumber");
        String name = request.getParameter("username");
        String userType = "user";  // Por padrão, o tipo de utilizador é "user"
        LocalDate registerDate = LocalDate.now();  // Data atual de registo

        // Cria o objeto User
        User newUser = new User(email, password, phoneNumber, name, userType, registerDate);

        // Cria o DAO e salva o utilizador
        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);
            boolean isSaved = userDAO.saveUser(newUser);

            // Verifica se o utilizador foi guardado com sucesso
            if (isSaved) {
                response.sendRedirect("Loginpage.jsp");  // Redireciona para o login após cadastro bem-sucedido
            } else {
                response.sendRedirect("Sign_up_Page.jsp?error=true");  // Redireciona com erro caso o cadastro falhe
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
