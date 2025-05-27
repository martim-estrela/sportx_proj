<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX | Order History</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_orderhistory.css">
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
            <a href="${pageContext.request.contextPath}/OrderHistoryServlet">Order History</a>

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

        <c:if test="${not empty error}">
            <div class="error-message">
                <p>${error}</p>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="empty-orders">
                    <h3>No Orders Found</h3>
                    <p>You haven't placed any orders yet.</p>
                    <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Start Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Orders Table -->
                <div class="orders-table-container">
                    <table class="orders-table">
                        <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Total</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td class="order-id">#${order.orderId}</td>
                                <td class="order-date">
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" />
                                </td>
                                <td class="order-status">
                                    <span class="status-badge status-${order.orderStatus.toLowerCase()}">${order.orderStatus}</span>
                                </td>
                                <td class="order-total">
                                    <fmt:formatNumber value="${order.orderTotal}" type="currency" currencySymbol="€"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <!-- Previous Page Link -->
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/OrderHistoryServlet?page=${currentPage - 1}">&#8592; Previous</a>
                        </c:if>

                        <span>
                                <!-- First page if not in range -->
                                <c:if test="${startPage > 1}">
                                    <a href="${pageContext.request.contextPath}/OrderHistoryServlet?page=1">1</a>
                                    <c:if test="${startPage > 2}">
                                        <span>...</span>
                                    </c:if>
                                </c:if>

                            <!-- Page numbers in range -->
                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <a href="#" class="active">${i}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/OrderHistoryServlet?page=${i}">${i}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                            <!-- Last page if not in range -->
                                <c:if test="${endPage < totalPages}">
                                    <c:if test="${endPage < totalPages - 1}">
                                        <span>...</span>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/OrderHistoryServlet?page=${totalPages}">${totalPages}</a>
                                </c:if>
                            </span>

                        <!-- Next Page Link -->
                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/OrderHistoryServlet?page=${currentPage + 1}">Next &#8594;</a>
                        </c:if>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
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