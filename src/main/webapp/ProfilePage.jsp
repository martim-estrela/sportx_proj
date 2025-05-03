<%@ page import="org.sportx.sportx.model.User" %>
<%@ page import="org.sportx.sportx.model.AddressInfo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX | Perfil de Utilizador</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Styles_ProfilePage.css">
</head>

<body>
<header>
    <div>
        <a href="${pageContext.request.contextPath}/index.jsp"><strong>SPORTX</strong></a>
    </div>
    <div>
        <a href="${pageContext.request.contextPath}/SearchBrowse.jsp">Products</a>
        <a href="${pageContext.request.contextPath}/SearchBrowse.jsp">Sale</a>
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

<!-- Popup Search -->
<div id="searchModal" class="modal">
    <div class="modal-content">
        <input type="text" id="searchInput" placeholder="Search...">
    </div>
</div>

<div class="profile-container">
    <h1>Welcome To Your Profile</h1>
    <div class="profile-info">
        <%
            session = request.getSession();
            User user = (User) session.getAttribute("user");
            AddressInfo address = (AddressInfo) session.getAttribute("userAddress");

            String addressText = null;

            if (user != null)
            {
                if (address != null)
                {
                    addressText = address.getStreet() + ", " + address.getCity() + ", " + address.getCountry() + ", " + address.getPostalCode();
                }
        %>
        <p><strong>Name:</strong> <%= user.getName() %></p>
        <p><strong>Email:</strong> <%= user.getEmail() %></p>
        <p><strong>Phone-number:</strong> <%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "Not provided" %></p>
        <p><strong>Address:</strong> <%= addressText %></p>
        <button id="btn_edit_profile">Edit</button>
        <%
        } else {
        %>
        <p>You need to log in to view and edit your profile.</p>
        <a href="${pageContext.request.contextPath}/Loginpage.jsp">Go to Login</a>
        <% } %>
    </div>
</div>

<!-- Modal para Editar Perfil -->
<div id="profileModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h1>Edit Profile</h1>
        <div class="modal-info">
            <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="POST">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= user != null ? user.getName() : "" %>" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= user != null ? user.getEmail() : "" %>" required>

                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="<%= user != null && user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>" required>

                <label for="street">Street:</label>
                <input type="text" id="street" name="street" value="<%= (address != null && address.getStreet() != null) ? address.getStreet() : "" %>" placeholder="Enter your street">

                <label for="country">Country:</label>
                <input type="text" id="country" name="country" value="<%= (address != null && address.getCountry() != null) ? address.getCountry() : "" %>" placeholder="Enter your country">

                <label for="city">City:</label>
                <input type="text" id="city" name="city" value="<%= (address != null && address.getCity() != null) ? address.getCity() : "" %>" placeholder="Enter your city">

                <label for="postalCode">Postal Code:</label>
                <input type="text" id="postalCode" name="postalCode" value="<%= (address != null && address.getPostalCode() != null) ? address.getPostalCode() : "" %>" placeholder="Enter your postal code">

                <button type="submit" id="btn_save_profile">Save</button>
            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/PopupSearch.js"></script>
<script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
<script src="${pageContext.request.contextPath}/js/ProfileModal.js"></script>

</body>

</html>