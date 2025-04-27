<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <a href="${pageContext.request.contextPath}/index.jsp"><strong>SPORTX</strong></a>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Products</a>
            <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Sale</a>
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

    <!-- Popup Search  -->
    <div id="searchModal" class="modal">
        <div class="modal-content">
            <input type="text" id="searchInput" placeholder="Search...">
        </div>
    </div>
    
    <div class="hero-section">
        <h1>Hiking Gear:</h1>
        <p>Explore our brand new selection!</p>
        <button>Explore</button>
    </div>

    <main>
        <section class="product-section">
            <h2>Hiking shoes</h2>
            <a href="${pageContext.request.contextPath}/SearchBrowse.jsp" class="view-all">View all products</a>
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

        <section class="product-section">
            <h2>Best-sellers</h2>
            <a href="${pageContext.request.contextPath}/SearchBrowse.jsp" class="view-all">View all</a>
            <div class="product-grid">
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/img/SalomonXUltra4.jpg" alt="Salomon X Ultra 4">
                    <p class="Top-Left-text">SALOMON X ULTRA 4</p>
                    <p class="Top-Left-text2">175,00€</p>
                </div>
                <div class="product-card">
                    <a href = "ProductPage.jsp"><img src="${pageContext.request.contextPath}/img/GarminForerunner55.jpg" alt="Garmin Forerunner 55"></a>
                    <p class="Top-Left-text">GARMIN FORERUNNER 55</p>
                    <p class="Top-Left-text2">139,00€</p>
                </div>
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/img/VitufitSetPump.jpg" alt="Viturit Set Pump">
                    <p class="Top-Left-text">VITUFIT SET PUMP</p>
                    <p class="Top-Left-text2">45,00€</p>
                </div>
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/img/Padlle.jpg" alt="PrecisionMax Paddle">
                    <p class="Top-Left-text">PRECISIONMAX PADDLE</p>
                    <p class="Top-Left-text2">248,00€</p>
                </div>
            </div>
        </section>

        <section class="product-section">
            <h2>On Sale</h2>
            <a href="${pageContext.request.contextPath}/SearchBrowse.jsp" class="view-all">View all</a>
            <div class="product-grid">
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/img/QuechuaNH50.jpg" alt="Quechua NH50">
                    <p class="Top-Left-text">QUECHUA NH50</p>
                    <p class="Top-Left-text2"><del>18,00€</del> 9,00€</p>
                </div>
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/img/KipstaTraximEdge.jpg" alt="Kipsta Traxum Edge">
                    <p class="Top-Left-text">KIPSTA TRAXUM EDGE</p>
                    <p class="Top-Left-text2"><del>69,00€</del> 39,00€</p>
                </div>
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/img/Riverside500.jpg" alt="Riverside 500">
                    <p class="Top-Left-text">RIVERSIDE 500</p>
                    <p class="Top-Left-text2"><del>329,00€</del> 229,00€</p>
                </div>
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/img/Judo.jpg" alt="Adidas Judo">
                    <p class="Top-Left-text">ADIDAS JUDO</p>
                    <p class="Top-Left-text2"><del>154,00€</del> 154,00€</p>
                </div>
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