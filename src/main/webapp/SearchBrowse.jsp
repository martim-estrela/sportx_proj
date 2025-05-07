<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|Search/Browse</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_searchBrowse.css">
</head>

<body>
<header>
    <div>
        <a href="${pageContext.request.contextPath}/index.jsp"><strong>SPORTX</strong></a>
    </div>
    <div>
        <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Products</a>
        <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Sale</a>
        <a href="#" id="searchButton">Search</a>
    </div>
    <div>
        <a href="ShoppingCart_Page.jsp"><img src="${pageContext.request.contextPath}/img/shopping-cart.jpg"></a>
        <a href="#" id="profileButton"><img src="${pageContext.request.contextPath}/img/account_circle.jpg" alt="Profile"></a>
    </div>
</header>

<!-- Popup Menu -->
<div id="profilePopup" class="popup">
    <div class="popup-content">
        <!-- Exibe Login e Register se o usuário não estiver logado -->
        <c:if test="${empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/Loginpage.jsp">Login</a>
            <a href="${pageContext.request.contextPath}/Sign_up_Page.jsp">Register</a>
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

<!-- Popup Search  -->
<div id="searchModal" class="modal">
    <div class="modal-content">
        <!-- Form de pesquisa que redireciona para a servlet -->
        <form action="${pageContext.request.contextPath}/SearchBrowseServlet" method="get">
            <input type="text" id="searchInput" name="search" placeholder="Search...">
            <button type="submit" style="display: none;">Search</button>
        </form>
    </div>
</div>

<main>
    <div class="path"><a href="">Hiking </a>> <a href="">Hiking Shoes</a></div>
    <div class="main-container">
        <section class="filters">
            <h2>Filters</h2>
            <form id="filterForm" action="${pageContext.request.contextPath}/SearchBrowseServlet" method="get">
                <div class="filter-group">
                    <h3>Product Brand</h3>
                    <c:choose>
                        <c:when test="${not empty brands}">
                            <c:forEach var="brand" items="${brands}">
                                <label>
                                    <input type="checkbox" name="brand" value="${brand}"
                                           <c:if test="${selectedBrands.contains(brand)}">checked</c:if>>
                                        ${brand}
                                </label>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Fallback if no brands are available -->
                            <label><input type="checkbox" name="brand" value="Nike"> Nike</label>
                            <label><input type="checkbox" name="brand" value="Adidas"> Adidas</label>
                            <label><input type="checkbox" name="brand" value="Puma"> Puma</label>
                            <label><input type="checkbox" name="brand" value="Reebok"> Reebok</label>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="filter-group">
                    <h3>Price</h3>
                    <label><input type="checkbox" name="price" value="0-50"
                                  <c:if test="${selectedPrices.contains('0-50')}">checked</c:if>> 0 - 50€</label>
                    <label><input type="checkbox" name="price" value="50-100"
                                  <c:if test="${selectedPrices.contains('50-100')}">checked</c:if>> 50 - 100€</label>
                    <label><input type="checkbox" name="price" value="100-150"
                                  <c:if test="${selectedPrices.contains('100-150')}">checked</c:if>> 100 - 150€</label>
                    <label><input type="checkbox" name="price" value="150+"
                                  <c:if test="${selectedPrices.contains('150+')}">checked</c:if>> >150€</label>
                </div>
                <!-- Hidden input for the current sort option and page -->
                <input type="hidden" name="sort" id="currentSort" value="${param.sort != null ? param.sort : 'popularity'}">
                <input type="hidden" name="page" id="currentPage" value="${currentPage != null ? currentPage : 1}">
                <button type="submit" class="filter-submit">Apply Filters</button>
            </form>
        </section>
        <section class="products">
            <div class="sort">
                <label for="sort">Sort by:</label>
                <select id="sort" onchange="updateSort(this.value)">
                    <option value="popularity" ${param.sort == 'popularity' || param.sort == null ? 'selected' : ''}>Popularity</option>
                    <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                    <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                </select>
            </div>
            <div class="product-grid">
                <!-- Substituir os produtos estáticos por um loop que renderiza dinamicamente os produtos da base de dados -->
                <c:forEach var="product" items="${products}">
                    <a href="${pageContext.request.contextPath}/ProductPage.jsp?productId=${product.id}" class="product-link">
                        <div class="product-card">
                            <!-- Usa o caminho da imagem do produto da base de dados, ou uma imagem padrão se não existir -->
                            <img src="${not empty product.imageUrl ? pageContext.request.contextPath.concat(product.imageUrl) : pageContext.request.contextPath.concat('/img/default-product.jpg')}"
                                 alt="${product.name}">
                            <h3>${product.name}</h3>
                            <p>${product.price}€</p>
                        </div>
                    </a>
                </c:forEach>

                <!-- Código de fallback: se não houver produtos, mostra uma mensagem -->
                <c:if test="${empty products}">
                    <div style="grid-column: span 3; text-align: center; padding: 20px;">
                        <p>Não foram encontrados produtos.</p>
                    </div>
                </c:if>
            </div>

            <!-- Paginação similar ao AdminPage_UserManagement.jsp -->
            <div class="pagination-container">
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <!-- Botão para primeira página -->
                        <c:if test="${currentPage > 1}">
                            <a href="javascript:void(0)" onclick="navigateToPage(1)">&laquo; First</a>
                        </c:if>

                        <!-- Botão para página anterior -->
                        <c:if test="${currentPage > 1}">
                            <a href="javascript:void(0)" onclick="navigateToPage(${currentPage - 1})">&lt; Previous</a>
                        </c:if>

                        <!-- Mostrar números de páginas -->
                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="current-page">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="javascript:void(0)" onclick="navigateToPage(${i})">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- Botão para próxima página -->
                        <c:if test="${currentPage < totalPages}">
                            <a href="javascript:void(0)" onclick="navigateToPage(${currentPage + 1})">Next &gt;</a>
                        </c:if>

                        <!-- Botão para última página -->
                        <c:if test="${currentPage < totalPages}">
                            <a href="javascript:void(0)" onclick="navigateToPage(${totalPages})">Last &raquo;</a>
                        </c:if>
                    </div>

                    <div class="pagination-info">
                        Page ${currentPage} of ${totalPages} (${totalProducts} products)
                    </div>
                </c:if>
            </div>
        </section>
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

<script>
    function updateSort(sortValue) {
        document.getElementById('currentSort').value = sortValue;
        document.getElementById('filterForm').submit();
    }

    function navigateToPage(pageNumber) {
        document.getElementById('currentPage').value = pageNumber;
        document.getElementById('filterForm').submit();
    }
</script>

<script src="${pageContext.request.contextPath}/js/PopupSearch.js"></script>
<script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
</body>
</html>