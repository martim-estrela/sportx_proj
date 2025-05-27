<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Complete | SportX</title>
  <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_OrderComplete.css">
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

<main>
  <div class="success-container">
    <h1>Order Completed Successfully!</h1>
    <p>Thank you for your purchase. Your order has been received and is being processed.</p>

    <div class="order-details">
      <p><strong>Order Number:</strong> #${sessionScope.orderId}</p>
      <p><strong>Date:</strong> <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %></p>
      <p><strong>Shipping Method:</strong> ${sessionScope.selectedShippingMethod.name}</p>
      <p><strong>Status:</strong> Processing</p>
    </div>

    <p>You will receive a confirmation email shortly with your order details.</p>

    <div class="buttons">
      <a href="${pageContext.request.contextPath}/OrderHistoryServlet" class="button secondary">View Your Orders</a>
      <a href="${pageContext.request.contextPath}/HomePageServlet" class="button">Continue Shopping</a>
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