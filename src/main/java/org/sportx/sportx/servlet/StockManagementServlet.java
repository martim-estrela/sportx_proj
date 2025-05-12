package org.sportx.sportx.servlet;

import org.sportx.sportx.DTO.ProductDTO;
import org.sportx.sportx.DTO.StockManagementDTO;
import org.sportx.sportx.model.ProductCategoryChild;
import org.sportx.sportx.model.ProductCategoryParent;
import org.sportx.sportx.model.VariationOption;
import org.sportx.sportx.util.DBConnection;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.sportx.sportx.util.StockManagementDAO;

import java.io.IOException;
import java.sql.*;
import java.util.List;
import java.util.Map;


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
                //dao.updateStock(DTO);
            } else if ("DeleteProductServlet".equals(action)) {
                int product_item_Id = Integer.parseInt(request.getParameter("product_item_id"));
                dao.deleteProduct(product_item_Id);
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {

            StockManagementDAO stockDAO = new StockManagementDAO(conn);

            // Obter filtros dos parâmetros da request
            String category = request.getParameter("category");
            String subCategory = request.getParameter("sub-category");
            String brand = request.getParameter("brand");
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            String name = request.getParameter("name");

            // Parâmetros de paginação
            int page = 1;
            int productPerPage = 5; // Número de produtos por página

            // Verificar se foi solicitada uma página específica
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) {
                        page = 1;
                    }
                } catch (NumberFormatException _) {

                }
            }


            // Calcular o número total de produtos para gerar a navegação de páginas
            int totalProducts = stockDAO.getTotalProducts(category, subCategory, brand, color, size, name);
            int totalPages = (int) Math.ceil((double) totalProducts / productPerPage);

            // Garantir que a página atual não ultrapasse o total de páginas
            if (page > totalPages && totalPages > 0) {
                page = totalPages;
            }

            int startPage = Math.max(1, page - 2);
            int endPage = Math.min(totalPages, page + 2);

            List<ProductDTO> filteredProducts = stockDAO.getFilteredProducts(category, subCategory, brand, color, size, name, page, productPerPage);
            // Set atributos
            request.setAttribute("filteredProducts", filteredProducts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

            // Buscar dados para os selects
            List<ProductCategoryParent> allCategories = stockDAO.getAllCategories();
            request.setAttribute("allCategories", allCategories);
            List<ProductCategoryChild> allSubcategories = stockDAO.getAllSubcategories();
            request.setAttribute("allSubcategories", allSubcategories);
            List<String> allBrands = stockDAO.getAllBrands();
            request.setAttribute("allBrands", allBrands);
            Map<String, List<VariationOption>> groupedOptions = stockDAO.getGroupedVariationOptions();
            request.setAttribute("variationOptions", groupedOptions);

            request.getRequestDispatcher("/AdminPage_StockManagement.jsp").forward(request, response);



        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar a requisição: " + e.getMessage());
        }

    }


}








