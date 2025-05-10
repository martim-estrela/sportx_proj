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

        try {
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");

            // Validação dos parâmetros
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Product ID is required");
            }
            if (quantityStr == null || quantityStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Quantity is required");
            }

            // Conversão dos valores
            int productId = Integer.parseInt(productIdStr.trim());
            int quantity = Integer.parseInt(quantityStr.trim());

            if (quantity < 1) {
                throw new IllegalArgumentException("Quantity must be greater than 0");
            }

            // Obter o carrinho da sessão
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null) {
                throw new IllegalStateException("Cart not found in session");
            }

            // Atualizar quantidade e calcular totais
            boolean itemFound = false;
            double cartTotal = 0.0;

            for (CartItem item : cart) {
                if (item.getProductItemId() == productId) {
                    item.setQuantity(quantity);
                    itemFound = true;
                }
                cartTotal += item.getPrice() * item.getQuantity();
            }

            if (!itemFound) {
                throw new IllegalArgumentException("Item not found in cart");
            }

            // Calcular total com frete
            double shippingCost = 6.00;
            double totalWithShipping = cartTotal + shippingCost;

            // Atualizar valores na sessão
            session.setAttribute("cartTotal", cartTotal);
            session.setAttribute("totalWithShipping", totalWithShipping);
            session.setAttribute("cart", cart);

            // Redirecionar de volta para a página do carrinho
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp?error=true");
        }
    }
}