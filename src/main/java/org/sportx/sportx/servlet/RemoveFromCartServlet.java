package org.sportx.sportx.servlet;

import org.sportx.sportx.model.CartItem;
import org.sportx.sportx.model.ShippingMethod;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Iterator;

public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            // 1. Obter e validar o parâmetro
            String productItemIdStr = request.getParameter("productItemId");
            if (productItemIdStr == null || productItemIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Product Item ID is required");
            }

            int productItemId = Integer.parseInt(productItemIdStr.trim());

            // 2. Obter o carrinho da sessão
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                throw new IllegalStateException("Your cart is empty");
            }

            // 3. Remover o item e calcular novos totais
            boolean itemRemoved = false;
            double cartTotal = 0.0;

            Iterator<CartItem> iterator = cart.iterator();
            while (iterator.hasNext()) {
                CartItem item = iterator.next();
                if (item.getProductItemId() == productItemId) {
                    iterator.remove();
                    itemRemoved = true;
                } else {
                    cartTotal += item.getPrice() * item.getQuantity();
                }
            }

            if (!itemRemoved) {
                throw new IllegalArgumentException("Item not found in your cart");
            }

            // 4. Calcular frete (se houver itens restantes)
            double shippingCost = 0.0;
            ShippingMethod shippingMethod = (ShippingMethod) session.getAttribute("selectedShippingMethod");

            if (!cart.isEmpty()) {
                shippingCost = (shippingMethod != null) ? shippingMethod.getPrice() : 6.00; // Valor padrão
            }

            // 5. Atualizar a sessão
            session.setAttribute("cart", cart);
            session.setAttribute("cartTotal", cartTotal);
            session.setAttribute("totalWithShipping", cartTotal + shippingCost);

            // 6. Redirecionar com mensagem de sucesso
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp?removed=true");

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid product ID format");
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp?error=true");
        } catch (IllegalArgumentException | IllegalStateException e) {
            session.setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp?error=true");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "An unexpected error occurred");
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp?error=true");
        }
    }
}