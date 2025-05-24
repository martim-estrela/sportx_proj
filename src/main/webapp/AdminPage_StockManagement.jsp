
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Verificar se os dados dos produtos e variações foram carregados pelo servlet
    if (request.getAttribute("filteredProducts") == null || request.getAttribute("variationOptions") == null) {
        // Redirecionar para o servlet para carregar os produtos e variações
        response.sendRedirect(request.getContextPath() + "/manageStock");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|StockManagement</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_AdminPage_Stock.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
</head>

<body>
<header>
    <div>
        <a href="${pageContext.request.contextPath}/HomePageServlet"><strong>SPORTX</strong></a>
    </div>
    <div>
        <a href="#" id="profileButton"><img src="${pageContext.request.contextPath}/img/account_circle.jpg" alt="Profile"></a>
    </div>
</header>


<!-- Popup Menu -->
    <div id="profilePopup" class="popup">
        <div class="popup-content">
            <!-- Exibe Login e Register se o utilizador não estiver logado -->
            <c:if test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/Loginpage.jsp">Login</a>
                <a href="${pageContext.request.contextPath}/Sign_up_Page.jsp">Register</a>
            </c:if>

            <!-- Exibe Profile, Order History e opções de admin se o utilizador estiver logado -->
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/ProfilePage.jsp">Profile</a>
                <a href="${pageContext.request.contextPath}/Orderhistory.jsp">Order History</a>

                <!-- Exibe as opções de admin se o utilizador for admin -->
                <c:if test="${sessionScope.user.userType == 'admin'}">
                    <a href="${pageContext.request.contextPath}/AdminPage_StockManagement.jsp">Stock Management</a>
                    <a href="${pageContext.request.contextPath}/AdminPage_UserManagement.jsp">User Management</a>
                </c:if>

                <!-- Sempre aparece a opção de logout se estiver logado -->
                <a href="${pageContext.request.contextPath}/LogoutServlet">Log Out</a>
            </c:if>
        </div>
    </div>


    <main>
        <form method="get" action="manageStock">
            <div class="select-container">
                <div>
                    <h3 style="text-decoration: underline;">Category:</h3>
                    <select name="category" id="category" onchange="this.form.submit();">
                        <option value="">Select...</option>
                        <c:forEach var="category" items="${allCategories}">
                            <option value="${category.name} ${param.category == category.name ? 'selected' : ''}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <h3 style="text-decoration: underline;">Sub-Category:</h3>
                    <select name="sub-category" id="sub-category" onchange="this.form.submit();">
                        <option value="">Select...</option>
                        <c:forEach var="subcategory" items="${allSubcategories}">
                            <option value="${subcategory.name} ${param.subcategory == subcategory.name ? 'selected' : ''}">${subcategory.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <h3 style="text-decoration: underline;">Brand:</h3>
                    <select name="brand" id="brand" onchange="this.form.submit();">
                        <option value="">Select...</option>
                        <c:forEach var="brand" items="${allBrands}">
                            <option value="${brand} ${param.brand == brand ? 'selected' : ''}">${brand}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <h3 style="text-decoration: underline;">Color:</h3>
                    <select name="color" id="color" onchange="this.form.submit();">
                        <option value="">Select...</option>
                        <c:forEach var="colorOption" items="${variationOptions['Color']}">
                            <option value="${colorOption.value}" ${param.color == colorOption.value ? 'selected' : ''}>${colorOption.value}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <h3 style="text-decoration: underline;">Size:</h3>
                    <select name="size" id="size" onchange="this.form.submit();">
                        <option value="">Select...</option>
                        <c:forEach var="sizeOption" items="${variationOptions['Size']}">
                            <option value="${sizeOption.value}" ${param.size == sizeOption.value ? 'selected' : ''}>${sizeOption.value}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="search-bar">
                    <h3 style="text-decoration: underline;">Product Name:</h3>
                    <input type="text" placeholder="Search..." name="name" value="${param.name}" onkeydown="if(event.key === 'Enter'){ this.form.submit(); }">
                </div>

            </div>
        </form>

        <div style="display: flex; justify-content: flex-end; margin-right:10% ">
            <button id="generatePdfBtn" class="btn-generate-pdf">Generate Report</button>
            <button id="openAddProductModalBtn" class="btn-add-product">Add new product</button>
        </div>

        <!--  Tabela de Produtos -->
        <div class=" table-container">
            <div class="row1">
                <div class="column-img-top"><label>Image</label></div>
                <div class="column-description"><label>ID</label></div>
                <div class="column-description1"><label>ID Item</label></div>
                <div class="column-description2"><label>Name</label></div>
                <div class="column-description3"><label>Brand</label></div>
                <div class="column-description4"><label>Color</label></div>
                <div class="column-description5"><label>Size</label></div>
                <div class="column-description6"><label>Stock</label></div>
                <div class="column-description7"><label>Price</label></div>
                <div class="column-edit-icon-top"><label>Edit</label></div>
                <div class="column-delete-icon-top"><label>Delete</label></div>
            </div>

            <%-- lista de produtos --%>
            <c:forEach var="product" items="${filteredProducts}">
                <div class="row1">
                    <div class="column-img">
                        <img class="product-img" src="${pageContext.request.contextPath}${product.image}" style="width: 104px; height: 104px;" alt="">
                    </div>
                    <div class="column-description">
                        <label class="product-id">${product.productId}</label>
                    </div>
                    <div class="column-description1">
                        <label class="productItem-id">${product.productItemId}</label>
                    </div>
                    <div class="column-description2">
                        <label class="product-name">${product.name}</label>
                    </div>
                    <div class="column-description3">
                        <label class="product-brand">${product.brand}</label>
                    </div>
                    <div class="column-description4">
                        <label class="product-color">${product.color}</label>
                    </div>
                    <div class="column-description5">
                        <label class="product-size">${product.size}</label>
                    </div>
                    <div class="column-description6">
                        <label class="product-stock">${product.stock}</label>
                    </div>
                    <div class="column-description7">
                        <label class="product-price">${product.price}€</label>
                    </div>
                    <div class="column-edit-icon">
                        <button class="btn-edit edit-product" data-productid="${product.productItemId}"><i class="material-icons" style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                    </div>
                    <div class="column-delete-icon">
                        <button class="btn-edit delete-product" data-productid="${product.productItemId}">
                            <i class="material-icons" style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i>
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Navegação de paginação -->
        <div class="pagination-container">
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <!-- Botão para primeira página -->
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/manageStock?page=1&category=${param.category}&subcategory=${param.subcategory}&brand=${param.brand}&color=${param.color}&size=${param.size}&name=${param.name}">&laquo; First</a>
                    </c:if>

                    <!-- Botão para página anterior -->
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/manageStock?page=${currentPage - 1}&category=${param.category}&subcategory=${param.subcategory}&brand=${param.brand}&color=${param.color}&size=${param.size}&name=${param.name}">&lt; Previous</a>
                    </c:if>

                    <!-- Mostrar números de páginas (com limite para não ficar muito grande) -->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="current-page">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/manageStock?page=${i}&category=${param.category}&subcategory=${param.subcategory}&brand=${param.brand}&color=${param.color}&size=${param.size}&name=${param.name}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- Botão para próxima página -->
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/manageStock?page=${currentPage + 1}&category=${param.category}&subcategory=${param.subcategory}&brand=${param.brand}&color=${param.color}&size=${param.size}&name=${param.name}">Next &gt;</a>
                    </c:if>

                    <!-- Botão para última página -->
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/manageStock?page=${totalPages}&category=${param.category}&subcategory=${param.subcategory}&brand=${param.brand}&color=${param.color}&size=${param.size}&name=${param.name}">Last &raquo;</a>
                    </c:if>
                </div>

                <div class="pagination-info">
                    Page ${currentPage} of ${totalPages} (${totalProducts} products)
                </div>
            </c:if>
        </div>



    </main>


    <!-- Modal Editar Produto -->
    <div id="editProductModal" class="product-modal" style="display: none;">
        <div class="product-modal-content">
            <span class="product-modal-close edit-close">&times;</span>
            <h2 class="edit-product-title">Update Product</h2>
            <form id="editProductForm" method="post" action="${pageContext.request.contextPath}/manageStock">
                <input type="hidden" name="action" value="UpdateProduct">
                <input type="hidden" id="editProductId" name="product_item_id" value="">

                <div class="product-form-group">
                    <label for="editStock">Stock:</label>
                    <input type="number" id="editStock" name="stock">
                </div>

                <div class="product-form-group">
                    <label for="editPrice">Price:</label>
                    <input type="number" id="editPrice" name="price">
                </div>

                <div class="product-form-buttons">
                    <button type="submit" class="product-btn-submit">Update</button>
                    <button type="button" class="product-btn-cancel" id="cancelEditProduct">Cancel</button>
                </div>
            </form>
        </div>
    </div>


    <!-- Custom Popup para mensagens de erro -->
    <div id="errorPopup" class="custom-popup" style="display: none;">
        <div class="popup-content">
            <h3>Error</h3>
            <p id="errorMessage"></p>
            <div class="popup-buttons">
                <button id="errorCloseBtn" class="btn-cancel">Fechar</button>
            </div>
        </div>
    </div>

    <!-- Custom Popup para confirmação de eliminação -->
    <div id="confirmDeletePopup" class="custom-popup" style="display: none;">
        <div class="popup-content" style="background-color: rgb(209,209,209)">
            <h3>Confirmation</h3>
            <p>Are you sure you want to delete this product?</p>
            <div class="popup-buttons">
                <button id="confirmYesBtn" class="btn-confirm">Yes</button>
                <button id="confirmNoBtn" class="btn-cancel">No</button>
            </div>
        </div>
    </div>


    <!-- Popup para confirmação de geração do PDF -->
    <div id="confirmPdfPopup" class="custom-popup" style="display: none;">
        <div class="popup-content" style="background-color: rgb(209,209,209)">
            <h3>Confirmation</h3>
            <p>Are you sure you want to generate a PDF with filtered Products?</p>
            <div class="popup-buttons">
                <button id="confirmPdfYesBtn" class="btn-confirm">Yes</button>
                <button id="confirmPdfNoBtn" class="btn-cancel">No</button>
            </div>
        </div>
    </div>


    <!-- Modal Adicionar Produto -->
    <div id="addProductModal" class="product-modal" style="display: none;">
        <div class="product-modal-content">
            <span class="product-modal-close">&times;</span>
            <h2 class="add-product-title">Add new product</h2>
            <form id="addProductForm" method="post" action="${pageContext.request.contextPath}/manageStock">
                <input type="hidden" name="action" value="AddProduct">
                <div class="product-form-row">
                    <div class="product-form-group">
                        <label for="img">Image:</label>
                        <input type="text" id="img" name="img">
                    </div>

                    <div class="product-form-group">
                        <label for="name">Name:</label>
                        <input type="text" id="name" name="name">
                    </div>
                </div>

                <div class="product-form-row">
                    <div class="product-form-group">
                        <label for="brand">Brand:</label>
                        <input type="text" id="brand" name="brand">
                    </div>

                    <div class="product-form-group">
                        <label for="description">Description:</label>
                        <input type="text" id="description" name="description">
                    </div>
                </div>
                <div class="product-form-row">
                    <div class="product-form-group">
                        <label for="color">Color:</label>
                        <select name="color" id="color" >
                            <option value="">Select...</option>
                            <c:forEach var="colorOption" items="${variationOptions['Color']}">
                                <option value="${colorOption.value}" ${param.color == colorOption.value ? 'selected' : ''}>${colorOption.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="product-form-group">
                        <label for="size">Size:</label>
                        <select name="size" id="size" >
                            <option value="">Select...</option>
                            <c:forEach var="sizeOption" items="${variationOptions['Size']}">
                                <option value="${sizeOption.value}" ${param.size == sizeOption.value ? 'selected' : ''}>${sizeOption.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="product-form-row">
                    <div class="product-form-group">
                        <label for="SKU">SKU:</label>
                        <input type="text" id="SKU" name="SKU">
                    </div>

                    <div class="product-form-group">
                        <label for="price">Price:</label>
                        <input type="number" id="price" name="price">
                    </div>
                </div>

                <div class="product-form-row">
                    <div class="product-form-group">
                        <label for="stock">Stock:</label>
                        <input type="number" id="stock" name="stock">
                    </div>
                    <div class="product-form-group">
                        <label for="sub-category">Sub-category:</label>
                        <select name="sub-category" id="sub-category">
                            <option value="">Select...</option>
                            <c:forEach var="subcategory" items="${allSubcategories}">
                                <option value="${subcategory.name} ${param.subcategory == subcategory.name ? 'selected' : ''}">${subcategory.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="product-form-buttons">
                    <button type="submit" class="product-btn-submit">Save</button>
                    <button type="button" class="product-btn-cancel" id="cancelAddProduct">Cancel</button>
                </div>
            </form>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/UpdateProduct.js"></script>
    <script src="${pageContext.request.contextPath}/js/AddProduct.js"></script>
    <script src="${pageContext.request.contextPath}/js/DeleteProduct.js"></script>
    <script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
    <script src="${pageContext.request.contextPath}/js/GenerateProductPdf.js"></script>
    <script> var contextPath = "${pageContext.request.contextPath}"; </script>
</body>




</html>