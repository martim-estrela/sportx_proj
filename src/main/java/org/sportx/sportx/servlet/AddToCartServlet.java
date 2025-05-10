package org.sportx.sportx.servlet;

import org.sportx.sportx.model.CartItem;
import org.sportx.sportx.model.ShippingMethod;
import org.sportx.sportx.dao.ShippingMethodDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }

            // Pegar parâmetros do form
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String imageUrl = request.getParameter("productImage");

            // Verificar se o item já existe no carrinho
            boolean itemExists = false;
            for (CartItem item : cart) {
                if (item.getProductItemId() == productId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    itemExists = true;
                    break;
                }
            }

            // Se o item não existe, adicionar ao carrinho
            if (!itemExists) {
                CartItem newItem = new CartItem(productId, productName, price, quantity, color, size, imageUrl);
                cart.add(newItem);
            }

            // Calcular o total do carrinho
            double cartTotal = 0.0;
            for (CartItem item : cart) {
                cartTotal += item.getPrice() * item.getQuantity();
            }
            session.setAttribute("cartTotal", cartTotal);

            // Verificar se já existe um método de envio selecionado
            ShippingMethod selectedShippingMethod = (ShippingMethod) session.getAttribute("selectedShippingMethod");

            // Se não existir método de envio selecionado, selecionar o padrão (primeiro da lista)
            if (selectedShippingMethod == null) {
                ShippingMethodDAO shippingMethodDAO = new ShippingMethodDAO();
                List<ShippingMethod> shippingMethods = shippingMethodDAO.getAllShippingMethods();

                if (!shippingMethods.isEmpty()) {
                    selectedShippingMethod = shippingMethods.get(0); // Seleciona o primeiro método como padrão
                    session.setAttribute("selectedShippingMethod", selectedShippingMethod);
                }
            }

            // Calcular o total com frete baseado no método de envio selecionado
            double shippingCost = selectedShippingMethod != null ? selectedShippingMethod.getPrice() : 0.0;
            double totalWithShipping = cartTotal + shippingCost;

            session.setAttribute("totalWithShipping", totalWithShipping);

            // Carregar todos os métodos de envio disponíveis
            ShippingMethodDAO shippingMethodDAO = new ShippingMethodDAO();
            List<ShippingMethod> shippingMethods = shippingMethodDAO.getAllShippingMethods();
            session.setAttribute("shippingMethods", shippingMethods);

            response.sendRedirect("ShoppingCart_Page.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}