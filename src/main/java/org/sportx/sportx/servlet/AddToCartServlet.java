package org.sportx.sportx.servlet;

import org.sportx.sportx.DTO.ProductItemDTO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int productItemId = Integer.parseInt(request.getParameter("productItemId"));

        // Simples: o carrinho é uma lista de IDs na sessão
        HttpSession session = request.getSession();
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        cart.add(productItemId);
        session.setAttribute("cart", cart);

        // Redireciona de volta para a página do produto ou carrinho
        response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp");
    }
}