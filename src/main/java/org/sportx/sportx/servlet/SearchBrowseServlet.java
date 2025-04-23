package org.sportx.sportx.servlet;

import org.sportx.sportx.util.ProductDAO;
import org.sportx.sportx.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet que processa solicitações para a página de pesquisa e navegação de produtos
 */
@WebServlet("/SearchBrowseServlet")
public class SearchBrowseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Método doGet para lidar com solicitações HTTP GET
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Instanciar o DAO para aceder aos produtos
        ProductDAO productDAO = new ProductDAO();
        List<Product> products;

        // Verificar se existe um parâmetro de pesquisa
        String searchTerm = request.getParameter("search");
        String categoryIdStr = request.getParameter("category");

        // Processo de acordo com os parâmetros fornecidos
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Pesquisar produtos com base no termo de pesquisa
            products = productDAO.searchProducts(searchTerm);
            request.setAttribute("searchTerm", searchTerm);
        } else if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                // Filtrar produtos por categoria
                int categoryId = Integer.parseInt(categoryIdStr);
                products = productDAO.getProductsByCategory(categoryId);
                request.setAttribute("categoryId", categoryId);
            } catch (NumberFormatException e) {
                // Se o ID da categoria não for um número válido, obter todos os produtos
                products = productDAO.getAllProducts();
            }
        } else {
            // Se não houver parâmetros de filtragem, obter todos os produtos
            products = productDAO.getAllProducts();
        }

        if (products == null) {
            System.out.println("SearchBrowseServlet: productList is NULL.");
            // Consider setting an empty list to avoid NullPointerExceptions in JSP
            // productList = new ArrayList<>();
        } else {
            System.out.println("SearchBrowseServlet: Retrieved " + products.size() + " products.");
            // Optionally log details of the first product if the list isn't empty
            if (!products.isEmpty()) {
                // Assuming Product has a getName() method
                // System.out.println("SearchBrowseServlet: First product name: " + productList.get(0).getName());
            }
        }


        // Adicionar a lista de produtos ao request
        request.setAttribute("products", products);

        // Encaminhar para a página JSP
        request.getRequestDispatcher("/SearchBrowse.jsp").forward(request, response);
    }
}