package org.sportx.sportx.servlet;

import org.sportx.sportx.model.CartItem;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Iterator;

public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String productIdStr = request.getParameter("productId");

            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Product ID is required");
            }

            int productId = Integer.parseInt(productIdStr.trim());

            // Obter o carrinho da sessão
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null) {
                throw new IllegalStateException("Cart not found in session");
            }

            // Remover o item e recalcular totais
            boolean itemRemoved = false;
            double cartTotal = 0.0;

            Iterator<CartItem> iterator = cart.iterator();
            while (iterator.hasNext()) {
                CartItem item = iterator.next();
                if (item.getProductItemId() == productId) {
                    iterator.remove();
                    itemRemoved = true;
                } else {
                    cartTotal += item.getPrice() * item.getQuantity();
                }
            }

            if (!itemRemoved) {
                throw new IllegalArgumentException("Item not found in cart");
            }

            // Calcular total com frete (se o carrinho não estiver vazio)
            double totalWithShipping = cartTotal;
            if (!cart.isEmpty()) {
                double shippingCost = 6.00;
                totalWithShipping = cartTotal + shippingCost;
            }

            // Atualizar valores na sessão
            session.setAttribute("cart", cart);
            session.setAttribute("cartTotal", cartTotal);
            session.setAttribute("totalWithShipping", totalWithShipping);

            // Redirecionar de volta para a página do carrinho
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp?error=true");
        }
    }
}