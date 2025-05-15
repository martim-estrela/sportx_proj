<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|HomePage</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Styles_HomePage.css">

</head>

<body>
<header>
    <div>
        <a href="${pageContext.request.contextPath}/HomePageServlet"><strong>SPORTX</strong></a>
    </div>
    <div>
        <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Products</a>
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
        <form action="${pageContext.request.contextPath}/SearchBrowseServlet" method="get">
            <input type="text" id="searchInput" name="search" placeholder="Search...">
            <button type="submit" style="display: none;">Search</button>
        </form>
    </div>
</div>

<div class="hero-section">
    <h1>Hiking Gear:</h1>
    <p>Explore our brand new selection!</p>
    <a href="${pageContext.request.contextPath}/SearchBrowseServlet?category=Footwear&sub-category=Hiking%20Shoes">
        <button>Explore</button>
    </a>
</div>

<main>
    <section class="product-section">
        <h2>Hiking shoes</h2>
        <a href="${pageContext.request.contextPath}/SearchBrowseServlet?category=Footwear&sub-category=Hiking%20Shoes" class="view-all">View all products</a>
        <div class="product-grid">
            <!-- Dynamic display of hiking shoes from database -->
            <c:choose>
                <c:when test="${not empty hikingShoes}">
                    <c:forEach var="product" items="${hikingShoes}">
                        <a href="${pageContext.request.contextPath}/ProductPage.jsp?productId=${product.id}" class="product-card">
                            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.name}">
                            <p class="Top-Left-text">${product.name}</p>
                            <p class="Top-Left-text2">
                                <c:choose>
                                    <c:when test="${product.hasActivePromotion()}">
                                        <del><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="€" maxFractionDigits="2" /></del>
                                        <fmt:formatNumber value="${product.getDiscountedPrice()}" type="currency" currencySymbol="€" maxFractionDigits="2" />
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="€" maxFractionDigits="2" />
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Fallback static content if no hiking shoes are found -->
                    <a href="${pageContext.request.contextPath}/ProductPage.jsp?productId=1" class="product-card">
                        <img src="${pageContext.request.contextPath}/img/MerrelMoab3.jpg" alt="Merrel MOAB 3">
                        <p class="Top-Left-text">MERREL MOAB 3</p>
                        <p class="Top-Left-text2">149,00€</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/ProductPage.jsp?productId=5" class="product-card">
                        <img src="${pageContext.request.contextPath}/img/SalomonXUltra4.jpg" alt="Salomon X Ultra 4">
                        <p class="Top-Left-text">SALOMON X ULTRA 4</p>
                        <p class="Top-Left-text2">175,00€</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/ProductPage.jsp?productId=1" class="product-card">
                        <img src="${pageContext.request.contextPath}/img/DannerTrail2650.jpg" alt="Danner Trail 2650">
                        <p class="Top-Left-text">DANNER TRAIL 2650</p>
                        <p class="Top-Left-text2">169,00€</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/ProductPage.jsp?productId=6" class="product-card">
                        <img src="${pageContext.request.contextPath}/img/TimberlandMtMaddsen.jpg" alt="Timberland Mt. Maddsen">
                        <p class="Top-Left-text">TIMBERLAND MT. MADDSEN</p>
                        <p class="Top-Left-text2">120,00€</p>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <section class="product-section">
        <h2>On Sale</h2>
        <a href="${pageContext.request.contextPath}/SearchBrowseServlet" class="view-all">View all</a>
        <div class="product-grid">
            <!-- Dynamic display of products with active promotions -->
            <c:choose>
                <c:when test="${not empty promotionProducts}">
                    <c:forEach var="product" items="${promotionProducts}">
                        <a href="${pageContext.request.contextPath}/ProductPage.jsp?productId=${product.id}" class="product-card">
                            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.name}">
                            <p class="Top-Left-text">${product.name}</p>
                            <p class="Top-Left-text2">
                                <del><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="€" maxFractionDigits="2" /></del>
                                <fmt:formatNumber value="${product.getDiscountedPrice()}" type="currency" currencySymbol="€" maxFractionDigits="2" />
                            </p>
                        </a>
                    </c:forEach>
                </c:when>
            </c:choose>
        </div>
    </section>
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
<script src="${pageContext.request.contextPath}/js/PopupSearch.js"></script>
<script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
</body>

</html>