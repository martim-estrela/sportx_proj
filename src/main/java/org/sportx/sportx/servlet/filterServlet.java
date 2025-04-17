package org.sportx.sportx.servlet;

import jakarta.servlet.RequestDispatcher;
import org.sportx.sportx.DTO.CategoryDTO;
import org.sportx.sportx.DTO.ProductDTO;
import org.sportx.sportx.DTO.SubcategoryDTO;
import org.sportx.sportx.util.DBConnection;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.sportx.sportx.util.StockManagementDAO;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/filterStock")
public class filterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            StockManagementDAO dao = new StockManagementDAO(conn);

            String category = request.getParameter("category");
            String subcategory = request.getParameter("subcategory");
            String productName = request.getParameter("productName");

            List<ProductDTO> products = dao.filterProducts(category, subcategory, productName);
            List<CategoryDTO> categories = dao.getAllCategories();
            List<SubcategoryDTO> subcategories = dao.getAllSubcategories();

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("subcategories", subcategories);

            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminPage_StockManagement.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao carregar produtos.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
