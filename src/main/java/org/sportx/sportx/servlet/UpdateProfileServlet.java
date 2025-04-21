package org.sportx.sportx.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import org.sportx.sportx.util.DBConnection;
import org.sportx.sportx.util.UserDAO;
import org.sportx.sportx.model.User;
import org.sportx.sportx.model.AddressInfo;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            // Obtém os dados do formulário
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String street = request.getParameter("street");
            String country = request.getParameter("country");
            String city = request.getParameter("city");
            String postalCode = request.getParameter("postalCode");

            // Atualiza os dados do usuário
            user.setName(name);
            user.setEmail(email);
            user.setPhoneNumber(phone);

            // Cria ou atualiza o endereço do usuário
            AddressInfo addressInfo = new AddressInfo(0, street, country, city, postalCode); // 0 para novo endereço

            try (Connection conn = DBConnection.getConnection()) {
                UserDAO userDAO = new UserDAO(conn);
                boolean isUpdated = userDAO.updateUserAndAddress(user, addressInfo);

                // Atualiza o endereço na sessão
                if (isUpdated) {
                    session.setAttribute("userAddress", addressInfo); // Garanta que o endereço seja armazenado na sessão corretamente
                    response.sendRedirect("ProfilePage.jsp");
                } else {
                    response.sendRedirect("ProfilePage.jsp?error=true");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("ProfilePage.jsp?error=true");
            }
        } else {
            response.sendRedirect("Loginpage.jsp");
        }
    }
}

