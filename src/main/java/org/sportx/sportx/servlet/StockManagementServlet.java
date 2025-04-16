package org.sportx.sportx.servlet;

import jakarta.servlet.RequestDispatcher;
import org.sportx.sportx.DTO.ProductDTO;
import org.sportx.sportx.DTO.StockManagementDTO;
import org.sportx.sportx.model.Product;
import org.sportx.sportx.model.ProductItem;
import org.sportx.sportx.model.Variation;
import org.sportx.sportx.model.VariationOption;
import org.sportx.sportx.util.DBConnection;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.sportx.sportx.util.StockManagementDAO;

import java.io.IOException;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/manageStock")
public class StockManagementServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(Connection conn = DBConnection.getConnection()){
            StockManagementDAO dao = new StockManagementDAO(conn);
            String action = request.getParameter("action");

            if ("UpdateStockServlet".equals(action)) {
                int product_item_Id = Integer.parseInt(request.getParameter("product_item_id"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                String variation = request.getParameter("variation");
                String variationOption = request.getParameter("variationOption");

                StockManagementDTO DTO = new StockManagementDTO(product_item_Id, stock, variation, variationOption);
                dao.updateStock(DTO);
            } else if ("DeleteProductServlet".equals(action)) {
                int product_item_Id = Integer.parseInt(request.getParameter("product_item_id"));
                dao.deleteProduct(product_item_Id);
            } else {

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }



    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            StockManagementDAO dao = new StockManagementDAO(conn);

            List<ProductDTO> products = dao.listAllProductsWithItems();

            request.setAttribute("products", products);
            RequestDispatcher dispatcher = request.getRequestDispatcher("../webapp/WEB-INF/AdminPage_StockManagement.jsp");
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








