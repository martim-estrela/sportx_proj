package org.sportx.sportx.servlet;

import org.sportx.sportx.dao.ProductDAO;
import org.sportx.sportx.model.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet("/SearchBrowseServlet")
public class SearchBrowseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();

        // Get all available brands from the database
        List<String> allBrands = productDAO.getAllBrands();
        request.setAttribute("brands", allBrands);

        // Get filter parameters
        String[] selectedBrands = request.getParameterValues("brand");
        String[] selectedPrices = request.getParameterValues("price");
        String sortBy = request.getParameter("sort");
        String searchTerm = request.getParameter("search");

        // Set default values if parameters are null
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "popularity";
        }

        // Store selected filters for repopulating the form
        List<String> brandList = (selectedBrands != null) ? Arrays.asList(selectedBrands) : new ArrayList<>();
        List<String> priceList = (selectedPrices != null) ? Arrays.asList(selectedPrices) : new ArrayList<>();
        request.setAttribute("selectedBrands", brandList);
        request.setAttribute("selectedPrices", priceList);

        // Pagination parameters
        int page = 1;
        int productsPerPage = 9; // Adjust as needed

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        // Get filtered and sorted products with pagination
        Map<String, Object> result = productDAO.getFilteredProducts(
                selectedBrands, selectedPrices, sortBy, searchTerm, page, productsPerPage);

        // Extract results
        List<Product> products = (List<Product>) result.get("products");
        int totalProducts = (int) result.get("totalCount");
        int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);

        // Set up pagination variables
        int displayPageRange = 5; // Number of page links to display
        int startPage = Math.max(1, page - (displayPageRange / 2));
        int endPage = Math.min(totalPages, startPage + displayPageRange - 1);

        if (endPage - startPage + 1 < displayPageRange && startPage > 1) {
            // Adjust startPage to show more pages if we're near the end
            startPage = Math.max(1, endPage - displayPageRange + 1);
        }

        // Set attributes for the JSP
        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);

        // Forward to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/SearchBrowse.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}