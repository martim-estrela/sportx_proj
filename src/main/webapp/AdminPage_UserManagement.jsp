<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX | User Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_AdminPage_User.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
</head>

<body>
<header>
    <div>
        <a href="${pageContext.request.contextPath}/index.jsp"><strong>SPORTX</strong></a>
    </div>
    <div>
        <a href="#" id="profileButton"><img src="${pageContext.request.contextPath}/img/account_circle.jpg" alt="Profile"></a>
    </div>
</header>

<!-- Popup Menu -->
<div id="profilePopup" class="popup">
    <div class="popup-content">
        <a href="ProfilePage.jsp"> Profile</a>
        <a href="Orderhistory.jsp">Order History</a>
        <a href="AdminPage_StockManagement.jsp">Stock Management</a>
        <a href="AdminPage_UserManagement.jsp">User Management</a>
        <a href="Loginpage.jsp">Log Out</a>
    </div>
</div>

<main>
    <div class="select-container">
        <form method="get" action="${pageContext.request.contextPath}/manageUser">
            <div>
                <h3 style="text-decoration: underline;">Role:</h3>
                <select name="role" id="role" onchange="this.form.submit();">
                    <option value="">Todos</option>
                    <c:forEach var="role" items="${allroles}">
                        <option value="${role}" ${param.role == role ? 'selected' : ''}>${role}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-bar">
                <h3 style="text-decoration: underline;">User Name:</h3>
                <input type="text" placeholder="Search.." name="name" value="${param.name}" onkeydown="if(event.key === 'Enter'){ this.form.submit(); }">
            </div>

        </form>
    </div>

    <div class="table-container">
        <div class="row1">
            <div class="column-description"><label>ID</label></div>
            <div class="column-description1"><label>Name</label></div>
            <div class="column-description2"><label>Role</label></div>
            <div class="column-description3"><label>Email</label></div>
            <div class="column"><label>Status</label></div>
            <div class="column-edit-icon"><label>Actions</label></div>
            <div class="column"><label>Delete</label></div>
        </div>

        <c:forEach var="user" items="${filteredUsers}">
            <div class="row1">
                <div class="column-description">
                    <label>${user.userId}</label>
                </div>
                <div class="column-description1">
                    <label>${user.name}</label>
                </div>
                <div class="column-description2">
                    <label>${user.userType}</label>
                </div>
                <div class="column-description3">
                    <label>${user.email}</label>
                </div>
                <div class="column">
                    <label>${user.status}</label>
                </div>
                <div class="column-edit-icon">
                    <button class="btn-edit"><i class="material-icons" style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                </div>
                <div class="column">
                    <button class="btn-edit delete-user" data-userid="${user.userId}"><i class="material-icons" style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i></button>
                </div>
            </div>
        </c:forEach>
    </div>



</main>
<script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
<script src="${pageContext.request.contextPath}/js/DeleteUser.js"></script>
<script> var contextPath = "${pageContext.request.contextPath}"; </script>


</body>
</html>
