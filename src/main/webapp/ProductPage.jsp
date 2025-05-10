<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.sportx.sportx.util.ProductDAO" %>
<%@ page import="org.sportx.sportx.model.Product" %>
<%@ page import="java.util.List" %>

<%
    String productIdParam = request.getParameter("productId");
    Product product = null;
    String colorParam = request.getParameter("color");
    List<Product> similarProducts = null;
    List<String> availableSizes = null;
    List<String> availableColors = null;

    ProductDAO productDAO = new ProductDAO();

    // Verifica se temos um ID válido
    if (productIdParam != null && !productIdParam.isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdParam);

            // Busca o produto principal
            product = productDAO.getProductById(productId);

            // Se produto não existe, redireciona
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/SearchBrowseServlet");
                return;
            }

            // Busca tamanhos e cores disponíveis
            availableSizes = productDAO.getAvailableSizes(productId);
            availableColors = productDAO.getAvailableColors(productId);

            // Busca produtos similares da mesma marca
            similarProducts = productDAO.getSimilarProducts(productId, product.getBrand());

            // Define os atributos para o JSP
            request.setAttribute("product", product);
            request.setAttribute("availableSizes", availableSizes);
            request.setAttribute("similarProducts", similarProducts);
            request.setAttribute("availableColors", availableColors);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/SearchBrowseServlet");
            return;
        }
    } else {
        response.sendRedirect(request.getContextPath() + "/SearchBrowseServlet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX | ${product.name}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_ProductPage.css">
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
        <a href="ShoppingCart_Page.jsp">
            <img src="${pageContext.request.contextPath}/img/shopping-cart.jpg" alt="Cart">
        </a>
        <a href="#" id="profileButton">
            <img src="${pageContext.request.contextPath}/img/account_circle.jpg" alt="Profile">
        </a>
    </div>
</header>

<!-- Profile Popup -->
<div id="profilePopup" class="popup">
    <div class="popup-content">
        <c:if test="${empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/Loginpage.jsp">Login</a>
            <a href="${pageContext.request.contextPath}/Sign_up_Page.jsp">Register</a>
        </c:if>
        <c:if test="${not empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/ProfilePage.jsp">Profile</a>
            <a href="${pageContext.request.contextPath}/Orderhistory.jsp">Order History</a>
            <c:if test="${sessionScope.user.userType == 'admin'}">
                <a href="${pageContext.request.contextPath}/AdminPage_StockManagement.jsp">Stock Management</a>
                <a href="${pageContext.request.contextPath}/AdminPage_UserManagement.jsp">User Management</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/LogoutServlet">Log Out</a>
        </c:if>
    </div>
</div>

<!-- Search Modal -->
<div id="searchModal" class="modal">
    <div class="modal-content">
        <input type="text" id="searchInput" placeholder="Search...">
    </div>
</div>

<main>
    <div class="main-div">
        <!-- Product Image -->
        <div class="img-div">
            <img src="${not empty product.imageUrl ?
                          pageContext.request.contextPath.concat(product.imageUrl) :
                          pageContext.request.contextPath.concat('/img/default-product.jpg')}"
                 alt="${product.name}">
        </div>

        <!-- Product Details -->
        <div class="product-details">
            <h2>${product.name}</h2>

            <c:choose>
                <c:when test="${not empty product.promotion and product.hasActivePromotion()}">
                    <h3 class="price" style="color: black; font-weight: bold; text-decoration: line-through" >
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="€"/>
                    </h3>
                    <span class="discount-tag" style="background: #218A38; color: #fff; padding: 4px 10px; border-radius: 4px; font-weight: bold;">
                    -<fmt:formatNumber value="${product.promotion.discountRate}" type="number" maxFractionDigits="0"/>%
                    </span>
                    <h3 class="price-final" style="color: black;">
                        <fmt:formatNumber  value="${product.price * (1 - (product.promotion.discountRate / 100))}" type="currency" currencySymbol="€"/>
                    </h3>
                </c:when>
                <c:otherwise>
                    <h3 class="price-regular" style="color: black; font-weight: bold;">
                        <c:if test="${not empty product}">
                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="€"/>
                        </c:if>
                    </h3>
                </c:otherwise>
            </c:choose>

            <p>Ref: ${product.id}</p>
            <p>${product.description}</p>
            <p><span>Brand:</span> ${product.brand}</p>
            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <input type="hidden" name="productName" value="${product.name}">
                <input type="hidden" name="productImage" value="${product.imageUrl}">
                <c:if test="${not empty availableSizes}">
                    <div class="variation">
                        <label for="size">Size:</label>
                        <select name="size" id="size" required>
                            <c:forEach var="size" items="${availableSizes}">
                                <option value="${size}">${size}</option>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>
                <c:if test="${not empty availableColors}">
                <div class="variation">
                    <label for="colorSelect">Color:</label>
                    <select id="colorSelect" name="color" required>
                        <option value="">Select color</option>
                        <c:forEach var="color" items="${availableColors}">
                            <option value="${color}">${color}</option>
                        </c:forEach>
                    </select>
                </div>
                </c:if>
                <div class="quantity">
                    <label for="quantity">Quantity:</label>
                    <select name="quantity" id="quantity">
                        <c:forEach begin="1" end="10" var="i">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </div>
                <input type="hidden" name="productId" value="${product.id}">
                <input type="hidden" name="price"
                       value="${product.hasActivePromotion() ? product.discountedPrice : product.price}">
                <button type="submit">Add to Cart</button>
            </form>
        </div>
    </div>
    <div class="extra-div">
    <!-- Similar Products -->
    <section class="product-section">
        <h2>More from this brand</h2>
        <div class="product-grid">
            <c:choose>
                <c:when test="${not empty similarProducts}">
                    <c:forEach var="similar" items="${similarProducts}">
                        <a href="${pageContext.request.contextPath}/ProductPage.jsp?productId=${similar.id}"
                           class="product-card">
                            <img src="${not empty similar.imageUrl ?
                                          pageContext.request.contextPath.concat(similar.imageUrl) :
                                          pageContext.request.contextPath.concat('/img/default-product.jpg')}"
                                 alt="${similar.name}">
                            <p class="Top-Left-text">${similar.name}</p>
                            <p class="Top-Left-text2">
                                <fmt:formatNumber value="${similar.price}" type="currency" currencySymbol="€"/>
                            </p>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <p>No more products from this brand</p>
                    </div>
                </c:otherwise>
            </c:choose>
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
        <form action="/subscribe" method="post">
            <input type="email" name="email" placeholder="Enter your email" required>
            <button type="submit">Subscribe</button>
        </form>
    </section>
</footer>
<script src="${pageContext.request.contextPath}/js/PopupSearch.js"></script>
<script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
</body>
</html>