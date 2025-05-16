<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|Search/Browse</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_FAQ.css">
</head>

<body>
    <header>
        <div>
            <a href="${pageContext.request.contextPath}/HomePageServlet"><strong>SPORTX</strong></a>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Products</a>
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
        <div class="introduction">
            <h2>Quick Assists</h2>
            <p>Answers to our most frequently asked questions are just one click away</p>
        </div>
        
        <div class="questions-grid">
            <div>
                <h3>Test Question</h3>
                <div class="question">
                    <p>Can I Test out the product before buying?</p>
                    <p class="logo">+</p>
                </div>
                <p class="answer">Absolutely! We recommend it, but be warned: you will have a smile from ear to ear</p>
            </div>
            <div>
                <h3>Test Question</h3>
                <div class="question">
                    <p>Can I Test out the product before buying?</p>
                    <p class="logo">+</p>
                </div>
                <p class="answer">Absolutely! We recommend it, but be warned: you will have a smile from ear to ear</p>
            </div>
            <div>
                <h3>Test Question</h3>
                <div class="question">
                    <p>Can I Test out the product before buying?</p>
                    <p class="logo">+</p>
                </div>
                <p class="answer">Absolutely! We recommend it, but be warned: you will have a smile from ear to ear</p>
            </div>
            <div>
                <h3>Test Question</h3>
                <div class="question">
                    <p>Can I Test out the product before buying?</p>
                    <p class="logo">+</p>
                </div>
                <p class="answer">Absolutely! We recommend it, but be warned: you will have a smile from ear to ear</p>
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
    <script src="${pageContext.request.contextPath}/js/PopupSearch.js"></script>
    <script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
    <script src="${pageContext.request.contextPath}/js/FAQVisibility.js"></script>
</body>