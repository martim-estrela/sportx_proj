package org.sportx.sportx.servlet;

import org.sportx.sportx.DTO.ProductDTO;
import org.sportx.sportx.DTO.StockManagementDTO;
import org.sportx.sportx.model.*;
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
        try (Connection conn = DBConnection.getConnection()) {
            StockManagementDAO dao = new StockManagementDAO(conn);
            String action = request.getParameter("action");

            if (action == null) {
                request.setAttribute("error", "Invalid action.");
                request.getRequestDispatcher("/AdminPage_StockManagement.jsp").forward(request, response);
                return;
            }

            switch (action) {
                case "UpdateStock":
                    try {
                        int product_item_Id = Integer.parseInt(request.getParameter("product_item_id"));
                        int stock = Integer.parseInt(request.getParameter("stock"));
                        double price = Double.parseDouble(request.getParameter("price"));

                        ProductDTO DTO = new ProductDTO();
                        DTO.setProductId(product_item_Id);
                        DTO.setStock(stock);
                        DTO.setPrice(price);
                        dao.updateStock(DTO);
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Invalid parameters for updating stock.");
                    }
                    break;

                case "DeleteProduct":
                    try {
                        int product_item_Id = Integer.parseInt(request.getParameter("product_item_id"));
                        dao.deleteProduct(product_item_Id);
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Invalid product ID for deletion.");
                    }
                    break;

                case "AddProduct":
                    try {
                        // Check for required fields
                        String[] requiredParams = {"product_id", "img", "name", "brand", "description", "color", "size", "sub_category", "product_item_id", "stock", "price"};
                        for (String param : requiredParams) {
                            if (request.getParameter(param) == null || request.getParameter(param).trim().isEmpty()) {
                                request.setAttribute("error", "Missing required parameter: " + param);
                                request.getRequestDispatcher("/AdminPage_StockManagement.jsp").forward(request, response);
                                return;
                            }
                        }

                        int product_id = Integer.parseInt(request.getParameter("product_id"));
                        String product_img = request.getParameter("img");
                        String product_name = request.getParameter("name");
                        String product_brand = request.getParameter("brand");
                        String product_description = request.getParameter("description");
                        String color = request.getParameter("color");
                        String size = request.getParameter("size");
                        String sub_category = request.getParameter("sub_category");
                        int product_item_Id = Integer.parseInt(request.getParameter("product_item_id"));
                        int stock = Integer.parseInt(request.getParameter("stock"));
                        double price = Double.parseDouble(request.getParameter("price"));

                        Product product = new Product();
                        product.setId(product_id);
                        product.setBrand(product_brand);
                        product.setName(product_name);
                        product.setDescription(product_description);

                        ProductItem productItem = new ProductItem();
                        productItem.setProductItemId(product_item_Id);
                        productItem.setProductId(product_id);
                        productItem.setQtyInStock(stock);
                        productItem.setImageUrl(product_img);
                        productItem.setPrice(price);

                        dao.addProduct(product, productItem, sub_category);
                        dao.linkColorWithProduct(productItem, color);
                        dao.linkSizeWithProduct(productItem, size);
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Number conversion error while adding product.");
                    }
                    break;

                default:
                    request.setAttribute("error", "Unrecognized action.");
                    break;
            }

            request.getRequestDispatcher("/AdminPage_StockManagement.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        } catch (Exception e) {
            throw new ServletException("Unexpected error", e);
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








