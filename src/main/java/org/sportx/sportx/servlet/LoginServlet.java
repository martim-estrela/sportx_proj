package org.sportx.sportx.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import org.sportx.sportx.util.UserDAO;
import org.sportx.sportx.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Criando uma instância de UserDAO para verificar as credenciais
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmailAndPassword(email, password);

        if (user != null) {
            // Se o utilizador for encontrado, inicia a sessão
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // Armazena o usuário na sessão

            // Redireciona para o painel principal (dashboard)
            response.sendRedirect("index.jsp");  // O utilizador vai para a home page
        } else {
            // Se as credenciais forem inválidas, redireciona de volta para o login com erro
            response.sendRedirect("Loginpage.jsp?error=true");  // Parâmetro error=true para indicar falha de login
        }
    }
}
