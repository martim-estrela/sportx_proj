<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="org.sportx.sportx.util.ProductDAO" %>
<%@ page import="org.sportx.sportx.model.Product" %>
<%@ page import="java.util.List" %>

<%
    String productIdParam = request.getParameter("productId");
    Product product = null;
    List<Product> similarProducts = null;

    if (productIdParam != null && !productIdParam.isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdParam);
            ProductDAO productDAO = new ProductDAO();

            // Busca o produto principal (você pode criar um método que use a view também)
            product = productDAO.getProductById(productId);

            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/SearchBrowseServlet");
                return;
            }

            // Busca produtos similares pelo mesmo brand, excluindo o próprio produto
            similarProducts = productDAO.getSimilarProducts(productId, product.getBrand());

            request.setAttribute("product", product);
            request.setAttribute("similarProducts", similarProducts);

        } catch (NumberFormatException e) {
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
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="€"/>
                    </h3>
                </c:otherwise>
            </c:choose>

            <p>Ref: ${product.id}</p>
            <p>${product.description}</p>
            <p><span>Brand:</span> ${product.brand}</p>
            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post">
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