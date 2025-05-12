<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|Orderhistory</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_orderhistory.css">
    
</head>

<body>
    <header>
        <div>
            <a href="${pageContext.request.contextPath}/index.jsp"><strong>SPORTX</strong></a>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/SearchBrowse.jsp">Products</a>
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
    
    <!-- principal -->
    <main>
        <section class="order-history">
            <h1>Order History</h1>
            <h2>Track your orders and see more information</h2>

         <!-- Order Card 1 -->
         <div class="order-card">
            <div class="order-header">
                <p><strong>Order ID: #24242</strong></p>
                <p>Sat, Dec 21, 2024</p>
            </div>
            <div class="order-details">
                <div class="order-info">
                    <img src="${pageContext.request.contextPath}/img/GarminForerunner55.jpg" alt="Garmin Forerunner 55">
                    <div class="product-info">
                        <p>Name: GARMIN FORERUNNER 55</p>
                        <p>Color: Black</p>
                        <p>Size: One size</p>
                    </div>
                </div>
                <div class="order-summary">
                    <div class="order-summary-item">
                        <p><strong>Quantity</strong></p>
                        <p>1</p>
                    </div>
                    <div class="order-summary-item">
                        <p><strong>TrackLink</strong></p>
                        <p><a href="https://www.ctt.pt" target="_blank">www.ctt.pt</a></p>
                    </div>
                    <div class="order-summary-item">
                        <p><strong>Total</strong></p>
                        <p>109,00€</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Card 2 -->
        <div class="order-card">
            <div class="order-header">
                <p><strong>Order ID: #24243</strong></p>
                <p>Sat, Dec 22, 2024</p>
            </div>
            <div class="order-details">
                <div class="order-info">
                    <img src="${pageContext.request.contextPath}/img/GarminForerunner55.jpg" alt="Garmin Forerunner 55">
                    <div class="product-info">
                        <p>Name: GARMIN FORERUNNER 55</p>
                        <p>Color: Black</p>
                        <p>Size: One size</p>
                    </div>
                </div>
                <div class="order-summary">
                    <div class="order-summary-item">
                        <p><strong>Quantity</strong></p>
                        <p>1</p>
                    </div>
                    <div class="order-summary-item">
                        <p><strong>TrackLink</strong></p>
                        <p><a href="https://www.ctt.pt" target="_blank">www.ctt.pt</a></p>
                    </div>
                    <div class="order-summary-item">
                        <p><strong>Total</strong></p>
                        <p>109,00€</p>
                    </div>
                </div>
            </div>
        </div>

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