package org.sportx.sportx.servlet;

import org.sportx.sportx.model.Product;
import org.sportx.sportx.model.ProductCategoryParent;
import org.sportx.sportx.util.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/HomePageServlet")
public class HomePageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();

        try {
            // Get featured hiking shoes (subcategory_id = 1)
            List<Product> hikingShoes = productDAO.getProductsBySubcategory(1, 4); // Limit to 4 products
            request.setAttribute("hikingShoes", hikingShoes);

            // Get products with active promotions
            List<Product> promotionProducts = productDAO.getProductsWithActivePromotions(4); // Limit to 4 products
            request.setAttribute("promotionProducts", promotionProducts);

            // Forward to the index.jsp page
            request.getRequestDispatcher("/index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp"); // Fallback to direct page in case of error
        }
    }
}