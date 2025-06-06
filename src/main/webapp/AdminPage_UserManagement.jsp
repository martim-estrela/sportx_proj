<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Verificar se os dados já foram carregados pelo servlet
    if (request.getAttribute("filteredUsers") == null && request.getAttribute("allroles") == null) {
        // Redirecionar para o servlet de gerar utilizadores
        response.sendRedirect(request.getContextPath() + "/manageUser");
        return;
    }
%>
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
        <a href="${pageContext.request.contextPath}/HomePageServlet"><strong>SPORTX</strong></a>
    </div>
    <div>
        <a href="#" id="profileButton"><img src="${pageContext.request.contextPath}/img/account_circle.jpg" alt="Profile"></a>
    </div>
</header>

<!-- Popup Menu -->
<div id="profilePopup" class="popup">
    <div class="popup-content">
        <!-- Exibe Login e Register se o utilizador não estiver logado -->
        <c:if test="${empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/Loginpage.jsp">Login</a>
            <a href="${pageContext.request.contextPath}/Sign_up_Page.jsp">Register</a>
        </c:if>

        <!-- Exibe Profile, Order History e opções de admin se o utilizador estiver logado -->
        <c:if test="${not empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/ProfilePage.jsp">Profile</a>
            <a href="${pageContext.request.contextPath}/OrderHistoryServlet">Order History</a>

            <!-- Exibe as opções de admin se o utilizador for admin -->
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
    <div class="select-container">
        <form method="get" action="${pageContext.request.contextPath}/manageUser">
            <div>
                <h3 style="text-decoration: underline;">Role:</h3>
                <select name="role" id="role" onchange="this.form.submit();">
                    <option value="">All</option>
                    <c:forEach var="role" items="${allRoles}">
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

    <div style="display: flex; justify-content: flex-end; margin-right:10% ">
        <button id="generatePdfBtn" class="btn-generate-pdf">Generate Report</button>
        <button id="openAddUserModalBtn" class="btn-add-user">Add new user</button>
    </div>

    <div class="table-container">

        <div class="row1">
            <div class="column-description"><label>ID</label></div>
            <div class="column-description1"><label>Name</label></div>
            <div class="column-description2"><label>Role</label></div>
            <div class="column-description3"><label>Email</label></div>
            <div class="column-description4"><label>Status</label></div>
            <div class="column-description5"><label>Register Date</label></div>
            <div class="column-edit-icon"><label>Edit</label></div>
            <div class="column"><label>Delete</label></div>
        </div>

        <c:forEach var="user" items="${filteredUsers}">
            <div class="row1">
                <div class="column-description">
                    <label class="user-id">${user.userId}</label>
                </div>
                <div class="column-description1">
                    <label class="user-name">${user.name}</label>
                </div>
                <div class="column-description2">
                    <label class="user-type">${user.userType}</label>
                </div>
                <div class="column-description3">
                    <label class="user-email">${user.email}</label>
                </div>
                <div class="column-description4">
                    <label class="user-status">${user.status}</label>
                </div>
                <div class="column-description5">
                    <label class="user-status">${user.registerDate}</label>
                </div>
                <div class="column-edit-icon">
                    <button class="btn-edit edit-user" data-userid="${user.userId}"><i class="material-icons" style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                </div>
                <div class="column">
                    <button class="btn-edit delete-user" data-userid="${user.userId}"><i class="material-icons" style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i></button>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Navegação de paginação -->
    <div class="pagination-container">
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <!-- Botão para primeira página -->
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/manageUser?page=1&role=${param.role}&name=${param.name}">&laquo; First</a>
                </c:if>

                <!-- Botão para página anterior -->
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/manageUser?page=${currentPage - 1}&role=${param.role}&name=${param.name}">&lt; Previous</a>
                </c:if>

                <!-- Mostrar números de páginas (com limite para não ficar muito grande) -->
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="current-page">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/manageUser?page=${i}&role=${param.role}&name=${param.name}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- Botão para próxima página -->
                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/manageUser?page=${currentPage + 1}&role=${param.role}&name=${param.name}">Next &gt;</a>
                </c:if>

                <!-- Botão para última página -->
                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/manageUser?page=${totalPages}&role=${param.role}&name=${param.name}">Last &raquo;</a>
                </c:if>
            </div>

            <div class="pagination-info">
                Page ${currentPage} of ${totalPages} (${totalUsers} users)
            </div>
        </c:if>
    </div>

</main>

<!-- Modal para editar utilizador -->
<div id="editUserModal" class="user-modal" style="display: none;">
    <div class="user-modal-content">
        <span class="user-modal-close edit-close">&times;</span>
        <h2 class="edit-user-title">Update User</h2>
        <form id="editUserForm" method="post" action="${pageContext.request.contextPath}/manageUser">
            <input type="hidden" name="action" value="updateUser">
            <input type="hidden" id="editUserId" name="userId" value="">

            <div class="user-form-group">
                <label for="editName">Name:</label>
                <input type="text" id="editName" name="name" required>
            </div>

            <div class="user-form-group">
                <label for="editEmail">Email:</label>
                <input type="email" id="editEmail" name="email" required>
            </div>

            <div class="user-form-group">
                <label for="editPassword">Password:</label>
                <input type="password" id="editPassword" name="password" placeholder="Leave blank to keep current password">
            </div>

            <div class="user-form-group">
                <label for="editPhoneNumber">Phone Number:</label>
                <input type="text" id="editPhoneNumber" name="phoneNumber">
            </div>

            <div class="user-form-group">
                <label for="editUserType">User type:</label>
                <select id="editUserType" name="userType" required>
                    <option value="user">User</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <div class="user-form-group">
                <label for="editStatus">Status:</label>
                <select id="editStatus" name="status" required>
                    <option value="active">active</option>
                    <option value="inactive">inactive</option>
                </select>
            </div>

            <div class="user-form-buttons">
                <button type="submit" class="user-btn-submit">Update</button>
                <button type="button" class="user-btn-cancel" id="cancelEditUser">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Custom Popup para confirmação de eliminação -->
<div id="confirmDeletePopup" class="custom-popup" style="display: none;">
    <div class="popup-content" style="background-color: rgb(209,209,209)">
        <h3>Confirmation</h3>
        <p>Are you sure you want to delete this user?</p>
        <div class="popup-buttons">
            <button id="confirmYesBtn" class="btn-confirm">Yes</button>
            <button id="confirmNoBtn" class="btn-cancel">No</button>
        </div>
    </div>
</div>

<!-- Custom Popup para mensagens de erro -->
<div id="errorPopup" class="custom-popup" style="display: none;">
    <div class="popup-content" >
        <h3>Error</h3>
        <p id="errorMessage"></p>
        <div class="popup-buttons">
            <button id="errorCloseBtn" class="btn-cancel">Fechar</button>
        </div>
    </div>
</div>


<!-- Modal para adicionar utilizador -->
<div id="addUserModal" class="user-modal" style="display: none;">
    <div class="user-modal-content">
        <h2 class="add-user-title">Add new user</h2>
        <form id="addUserForm" method="post" action="${pageContext.request.contextPath}/manageUser">
            <input type="hidden" name="action" value="addUser">

            <div class="user-form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="user-form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="user-form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="user-form-group">
                <label for="phoneNumber">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phoneNumber">
            </div>

            <div class="user-form-group">
                <label for="userType">User Type:</label>
                <select id="userType" name="userType" required>
                    <option value="user">User</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <div class="user-form-group">
                <label for="status">Status:</label>
                <select id="status" name="status" required>
                    <option value="active">active</option>
                    <option value="inactive">inactive</option>
                </select>
            </div>

            <div class="user-form-buttons">
                <button type="submit" class="user-btn-submit">Save</button>
                <button type="button" class="user-btn-cancel" id="cancelAddUser">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Popup para confirmação de geração do PDF -->
<div id="confirmPdfPopup" class="custom-popup" style="display: none;">
    <div class="popup-content" style="background-color: rgb(209,209,209)">
        <h3>Confirmation</h3>
        <p>Are you sure you want to generate a PDF with filtered users?</p>
        <div class="popup-buttons">
            <button id="confirmPdfYesBtn" class="btn-confirm">Yes</button>
            <button id="confirmPdfNoBtn" class="btn-cancel">No</button>
        </div>
    </div>
</div>



<script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
<script src="${pageContext.request.contextPath}/js/DeleteUser.js"></script>
<script src="${pageContext.request.contextPath}/js/AddUser.js"></script>
<script src="${pageContext.request.contextPath}/js/UpdateUser.js"></script>
<script src="${pageContext.request.contextPath}/js/GenerateUserPdf.js"></script>
<script> var contextPath = "${pageContext.request.contextPath}"; </script>

</body>
</html>
