package org.sportx.sportx.servlet;

import org.sportx.sportx.model.CartItem;
import org.sportx.sportx.model.ShippingMethod;
import org.sportx.sportx.dao.ShippingMethodDAO;
import org.sportx.sportx.util.ProductDAO;
import org.sportx.sportx.DTO.ProductItemDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            // 1. Get or initialize cart
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }

            // 2. Retrieve form parameters
            int productItemId = Integer.parseInt(request.getParameter("productItemId"));
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String imageUrl = request.getParameter("productImage");

            // 3. Get current product item from database - Stream version
            ProductDAO productDAO = new ProductDAO();
            List<ProductItemDTO> productItems = productDAO.getProductItemsByProductId(productId);

            ProductItemDTO productItem = productItems.stream()
                    .filter(item -> item.getProductItemId() == productItemId)
                    .findFirst()
                    .orElse(null);

            if (productItem == null) {
                session.setAttribute("errorMessage", "Product item not found");
                response.sendRedirect("ProductPage.jsp?productId=" + productId);
                return;
            }

            // 4. Determine price to use
            double price = productItem.getDiscountedPrice() > 0 ?
                    productItem.getDiscountedPrice() : productItem.getPrice();
            int availableStock = productItem.getQtyInStock();

            // 5. Process product variations
            Map<String, String> variations = new HashMap<>();
            Enumeration<String> paramNames = request.getParameterNames();

            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                if (!paramName.equals("productId") &&
                        !paramName.equals("productItemId") &&
                        !paramName.equals("productName") &&
                        !paramName.equals("quantity") &&
                        !paramName.equals("productImage")) {
                    variations.put(paramName, request.getParameter(paramName));
                }
            }

            // 6. Check if item exists in cart
            boolean itemExists = false;
            for (CartItem item : cart) {
                if (item.getProductItemId() == productItemId &&
                        item.getVariations().equals(variations)) {

                    int newQuantity = item.getQuantity() + quantity;
                    if (newQuantity > availableStock) {
                        session.setAttribute("errorMessage", "Only " + availableStock + " items available in stock");
                        response.sendRedirect("ProductPage.jsp?productId=" + productId);
                        return;
                    }

                    item.setQuantity(newQuantity);
                    itemExists = true;
                    break;
                }
            }

            // 7. Add new item if not exists
            if (!itemExists) {
                if (quantity > availableStock) {
                    session.setAttribute("errorMessage", "Only " + availableStock + " items available in stock");
                    response.sendRedirect("ProductPage.jsp?productId=" + productId);
                    return;
                }

                CartItem newItem = new CartItem(
                        productId,
                        productItemId,
                        productName,
                        price,
                        quantity,
                        variations,
                        imageUrl,
                        availableStock
                );
                cart.add(newItem);
            }

            // 8. Update cart totals
            updateCartTotals(session, cart);

            // 9. Redirect to cart page
            response.sendRedirect("ShoppingCart_Page.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("ProductPage.jsp?productId=" + request.getParameter("productId"));
        }
    }

    private void updateCartTotals(HttpSession session, List<CartItem> cart) {
        // Calculate subtotal
        double subtotal = cart.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();

        session.setAttribute("cartTotal", subtotal);

        // Initialize shipping if needed
        ShippingMethod selectedMethod = (ShippingMethod) session.getAttribute("selectedShippingMethod");
        if (selectedMethod == null) {
            ShippingMethodDAO shippingDAO = new ShippingMethodDAO();
            List<ShippingMethod> methods = shippingDAO.getAllShippingMethods();
            if (!methods.isEmpty()) {
                selectedMethod = methods.get(0);
                session.setAttribute("selectedShippingMethod", selectedMethod);
            }
        }

        // Calculate total with shipping
        double shippingCost = selectedMethod != null ? selectedMethod.getPrice() : 0;
        session.setAttribute("totalWithShipping", subtotal + shippingCost);
        session.setAttribute("shippingMethods", new ShippingMethodDAO().getAllShippingMethods());
    }
}