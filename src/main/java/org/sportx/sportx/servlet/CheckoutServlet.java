package org.sportx.sportx.servlet;

import org.sportx.sportx.model.CartItem;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Check if user is logged in
        if (session.getAttribute("user") == null) {
            // Redirect to login page if not logged in
            session.setAttribute("redirectAfterLogin", "CheckoutPage.jsp");
            response.sendRedirect(request.getContextPath() + "/Loginpage.jsp");
            return;
        }

        // Check if the cart is empty
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ShoppingCart_Page.jsp");
            return;
        }

        // Ensure cart totals are up to date
        double cartTotal = (Double) session.getAttribute("cartTotal");
        double shippingCost = 0.0;
        if (session.getAttribute("selectedShippingMethod") != null) {
            org.sportx.sportx.model.ShippingMethod method =
                    (org.sportx.sportx.model.ShippingMethod) session.getAttribute("selectedShippingMethod");
            shippingCost = method.getPrice();
        }

        double totalWithShipping = cartTotal + shippingCost;

        // Store updated totals in the session
        session.setAttribute("cartTotal", cartTotal);
        session.setAttribute("shippingCost", shippingCost);
        session.setAttribute("totalWithShipping", totalWithShipping);

        // Redirect to checkout page
        response.sendRedirect(request.getContextPath() + "/CheckoutPage.jsp");
    }
}