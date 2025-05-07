<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.sportx.sportx.dao.ProductDAO" %>
<%@ page import="org.sportx.sportx.model.Product" %>

<%
    // Get the product ID from the request parameters
    String productIdParam = request.getParameter("productId");
    Product product = null;

    if (productIdParam != null && !productIdParam.isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdParam);

            // Create a ProductDAO instance and get the product by ID
            ProductDAO productDAO = new ProductDAO();
            product = productDAO.getProductById(productId);

            // If product is not found, redirect to the products page
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/SearchBrowseServlet");
                return;
            }

            // Set the product in request scope to use in JSP
            request.setAttribute("product", product);
        } catch (NumberFormatException e) {
            // If product ID is not a valid number, redirect to products page
            response.sendRedirect(request.getContextPath() + "/SearchBrowseServlet");
            return;
        }
    } else {
        // If no product ID is provided, redirect to products page
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
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
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
        <input type="text" id="searchInput" placeholder="Search...">
    </div>
</div>

<main>
    <div class="main-div">
        <div class="img-div">
            <img src="${not empty product.imageUrl ? pageContext.request.contextPath.concat(product.imageUrl) : pageContext.request.contextPath.concat('/img/default-product.jpg')}">
        </div>

        <div class="product-details">
            <h2>${product.name}</h2>
            <div class="prices">
                <h3>${product.price}€</h3>
            </div>
            <p>Ref: ${product.id}</p>
            <p>${product.description}</p>
            <p><span>Brand:</span> ${product.brand}</p>
            <div class="size">
                <label for="size">Size:</label>
                <select id="size">
                    <option>One Size</option>
                </select>
            </div>
            <button>Add to Cart</button>
        </div>
    </div>
    <section class="product-section">
        <h2>Similar products</h2>
        <a href="#" class="view-all">View all products</a>
        <div class="product-grid">
            <div class="product-card">
                <img src="${pageContext.request.contextPath}/img/MerrelMoab3.jpg" alt="Merrel MOAB 3">
                <p class="Top-Left-text">MERREL MOAB 3</p>
                <p class="Top-Left-text2">149,00€</p>
            </div>
            <div class="product-card">
                <img src="${pageContext.request.contextPath}/img/SalomonXUltra4.jpg" alt="Salomon X Ultra 4">
                <p class="Top-Left-text">SALOMON X ULTRA 4</p>
                <p class="Top-Left-text2">175,00€</p>
            </div>
            <div class="product-card">
                <img src="${pageContext.request.contextPath}/img/DannerTrail2650.jpg" alt="Danner Trail 2650">
                <p class="Top-Left-text">DANNER TRAIL 2650</p>
                <p class="Top-Left-text2">169,00€</p>
            </div>
            <div class="product-card">
                <img src="${pageContext.request.contextPath}/img/TimberlandMtMaddsen.jpg" alt="Timberland Mt. Maddsen">
                <p class="Top-Left-text">TIMBERLAND MT. MADDSEN</p>
                <p class="Top-Left-text2">120,00€</p>
            </div>
        </div>
    </section>
    <section class="specifications">
        <h2>Technical specifications</h2>
        <h3>MULTIPLE ACTIVITY MODES</h3>
        <p>Run, swim, cycle, strength training, and winter sports. The PACE 3 offers a wide range of activity modes, optimized to provide precise measurements.</p>
        <h3>NEXT-GENERATION GPS</h3>
        <p>The redesigned satellite chip with dual-frequency mode ensures GPS data accuracy, even in major cities like Paris or New York.</p>
        <h3>LIGHT AND DICREET</h3>
        <p class="more">More</p>
        <img src="${pageContext.request.contextPath}/img/arrow.png">
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