<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            <a href="${pageContext.request.contextPath}/index.jsp"><strong>SPORTX</strong></a>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/SearchBrowse.jsp">Products</a>
            <a href="${pageContext.request.contextPath}/SearchBrowse.jsp">Sale</a>
            <a href="#" id="searchButton">Search</a>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/ShoppingCart_Page.jsp"><img src="${pageContext.request.contextPath}/img/shopping-cart.jpg"></a>
            <a href="#" id="profileButton"><img src="${pageContext.request.contextPath}/img/account_circle.jpg" alt="Profile"></a>
        </div>
    </header>

    <!-- Popup Menu -->
    <div id="profilePopup" class="popup">
        <div class="popup-content">
            <!-- Exibe Login e Register se o usuário não estiver logado -->
            <c:if test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/Loginpage.jsp">Login</a>
                <a href="${pageContext.request.contextPath}/Registerpage.jsp">Register</a>
            </c:if>

            <!-- Exibe Profile, Order History e opções de admin se o usuário estiver logado -->
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/ProfilePage.jsp">Profile</a>
                <a href="${pageContext.request.contextPath}/Orderhistory.jsp">Order History</a>

                <!-- Exibe as opções de admin se o usuário for admin -->
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
        <form method="get" action="filterStock">
            <div class="select-container">
                <div>
                    <h3 style="text-decoration: underline;">Category:</h3>
                    <select name="category" id="category">
                        <option value="">Selecione...</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <h3 style="text-decoration: underline;">Sub-Category:</h3>
                    <select name="sub-category" id="sub-category">
                        <option value="">Selecione...</option>
                        <c:forEach var="subcategory" items="${subcategories}">
                            <option value="${subcategory.id}">${subcategory.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="search-bar">
                    <h3 style="text-decoration: underline;">Product Name:</h3>
                    <input type="text" placeholder="Search.." name="search">
                </div>
                <div>
                    <button type="submit">Filtrar</button>
                </div>
            </div>
        </form>

        <div class="report-links">
            <a href="#"><strong style="color: black; text-decoration: underline;">Generate stock
                    report...</strong></a><br>
            <a href="#"><strong style="color: black; text-decoration: underline;">Add product...</strong></a>
        </div>


        <!--  Tabela de Produtos -->
        <form method="get" action="manageStock">
            <div class=" table-container">
                <%-- lista de produtos --%>
                <c:forEach var="product" items="${products}" varStatus="status">
                    <c:if test="${status.index % 8 == 0}">
                        <div class="page" style="${status.index == 0 ? '' : 'display:none;'}">
                    </c:if>

                    <div class="row1">
                        <div class="column-img">
                            <img src="${product.product_image}" style="width: 104px; height: 104px;" alt="">
                        </div>
                        <div class="column-description">
                            <label><strong>${product.name}</strong></label><br><br>
                            <c:forEach var="item" items="${product.items}">
                                <label>Color: ${item.color}, Size: ${item.size}, Stock: ${item.qtyInStock}</label><br>
                            </c:forEach>
                        </div>
                        <div class="column">
                            <button
                                    class="btn-update-stock"
                                    type="button"
                                    onclick="openStockModal('${product.id}', ${product.items})">
                                Update
                            </button>
                        </div>
                        <div class="column-edit-icon">
                            <button class="btn-edit"><i class="material-icons" style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                        </div>
                        <div class="column-delete-icon">
                            <form method="post" action="manageStock">
                                <input type="hidden" name="action" value="DeleteProductServlet" />
                                <input type="hidden" name="productId" value="${product.id}" />
                                <button class="btn-edit" type="submit">
                                    <i class="material-icons" style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i>
                                </button>
                            </form>
                        </div>
                    </div>

                    <c:if test="${(status.index + 1) % 8 == 0 || status.last}">
                        </div> <!-- fecha .page -->
                    </c:if>
                </c:forEach>
            </div>
        </form>


            <!--Modal-->
        <div class="modal" id="stockModal">
            <di class="modal-content">
                <h3>Update Stock</h3>
                <form method="post" action="manageStock">
                    <input type="hidden" name="action" value="UpdateStockServlet">
                    <div id="stockInputs" class="input-grid">
                        <!-- Inputs dinâmicos inseridos via JavaScript -->
                    </div>
                    <br>
                    <button class="add-modal-btn" type="submit">Save</button>
                    <a href="#" class="close-modal-btn" onclick="closeModal()">Cancel</a>
                </form>
            </di>
        </div>


            <script src="${pageContext.request.contextPath}/js/PopupStock.js">
            </script>
            <!-- Paginação -->
            <div class="pagination">
                <a href="#">&#8592; Previous</a>
                <span>
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <span>...</span>
                    <a href="#">67</a>
                    <a href="#">68</a>
                </span>
                <a href="#">Next &#8594;</a>
            </div>
        </div>
    </main>

    <footer>
        <section class="support">
            <h2>Support</h2>
            <ul>
                <li><a href="ContactUs.jsp">Contact us</a></li>
                <li><a href="FAQ.jsp">FAQ</a></li>
            </ul>
        </section>

        <section class="subscribe">
            <h2>Subscribe for latest updates</h2>
            <form action="/subscribe">
                <input type="email" name="email" placeholder="Enter your email" required />
                <button type="submit">Subscribe</button>
            </form>
        </section>
    </footer>
    <script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
</body>

</html>