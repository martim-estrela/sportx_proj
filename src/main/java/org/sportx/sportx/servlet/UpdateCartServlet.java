package org.sportx.sportx.servlet;

import org.sportx.sportx.model.CartItem;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.*;

public class UpdateCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            int productItemId = Integer.parseInt(request.getParameter("productItemId"));
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));

            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            // Atualiza a quantidade
            for (CartItem item : cart) {
                if (item.getProductItemId() == productItemId) {
                    if (newQuantity <= item.getStock()) {  // Verifica o estoque
                        item.setQuantity(newQuantity);
                    } else {
                        throw new IllegalArgumentException("Quantidade excede o estoque disponível");
                    }
                    break;
                }
            }

            // Recalcula totais
            double subtotal = cart.stream()
                    .mapToDouble(i -> i.getPrice() * i.getQuantity())
                    .sum();

            session.setAttribute("cartTotal", subtotal);

            // Redireciona sem parâmetro de erro
            response.sendRedirect("ShoppingCart_Page.jsp");

        } catch (Exception e) {
            session.setAttribute("errorMessage", e.getMessage());
            response.sendRedirect("ShoppingCart_Page.jsp?error=true");
        }
    }
}