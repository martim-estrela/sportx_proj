<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Verificar se os dados já foram carregados pelo servlet
    if (request.getAttribute("filteredUsers") == null && request.getAttribute("allroles") == null) {
        // Redirecionar para o servlet de gerenciamento de usuários
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

    <div class="add-user-container" style="margin-bottom: 20px;">
        <button id="openAddUserModalBtn" class="btn-add-user">Adicionar Novo Usuário</button>
    </div>

    <div class="table-container">
        <div class="row1">
            <div class="column-description"><label>ID</label></div>
            <div class="column-description1"><label>Name</label></div>
            <div class="column-description2"><label>Role</label></div>
            <div class="column-description3"><label>Email</label></div>
            <div class="column-description4"><label>Status</label></div>
            <div class="column-edit-icon"><label>Actions</label></div>
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
                    <a href="${pageContext.request.contextPath}/manageUser?page=1&role=${param.role}&name=${param.name}">&laquo; Primeira</a>
                </c:if>

                <!-- Botão para página anterior -->
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/manageUser?page=${currentPage - 1}&role=${param.role}&name=${param.name}">&lt; Anterior</a>
                </c:if>

                <!-- Mostrar números de páginas (com limite para não ficar muito grande) -->
                <c:forEach var="i" begin="${Math.max(1, currentPage - 2)}" end="${Math.min(totalPages, currentPage + 2)}">
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
                    <a href="${pageContext.request.contextPath}/manageUser?page=${currentPage + 1}&role=${param.role}&name=${param.name}">Próxima &gt;</a>
                </c:if>

                <!-- Botão para última página -->
                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/manageUser?page=${totalPages}&role=${param.role}&name=${param.name}">Última &raquo;</a>
                </c:if>
            </div>

            <div class="pagination-info">
                Mostrando página ${currentPage} de ${totalPages} (Total de ${totalUsers} usuários)
            </div>
        </c:if>
    </div>

    <!-- Modal para editar utilizador -->
    <div id="editUserModal" class="user-modal" style="display: none;">
        <div class="user-modal-content">
            <span class="user-modal-close edit-close">&times;</span>
            <h2 class="edit-user-title">Editar Utilizador</h2>
            <form id="editUserForm" method="post" action="${pageContext.request.contextPath}/manageUser">
                <input type="hidden" name="action" value="updateUser">
                <input type="hidden" id="editUserId" name="userId" value="">

                <div class="user-form-group">
                    <label for="editName">Nome:</label>
                    <input type="text" id="editName" name="name" required>
                </div>

                <div class="user-form-group">
                    <label for="editEmail">Email:</label>
                    <input type="email" id="editEmail" name="email" required>
                </div>

                <div class="user-form-group">
                    <label for="editPassword">Senha:</label>
                    <input type="password" id="editPassword" name="password" placeholder="Deixe em branco para manter a senha atual">
                </div>

                <div class="user-form-group">
                    <label for="editPhoneNumber">Número de Telefone:</label>
                    <input type="text" id="editPhoneNumber" name="phoneNumber">
                </div>

                <div class="user-form-group">
                    <label for="editUserType">Tipo de Utilizador:</label>
                    <select id="editUserType" name="userType" required>
                        <option value="user">Usuário</option>
                        <option value="admin">Administrador</option>
                    </select>
                </div>

                <div class="user-form-group">
                    <label for="editStatus">Status:</label>
                    <select id="editStatus" name="status" required>
                        <option value="active">Ativo</option>
                        <option value="inactive">Inativo</option>
                    </select>
                </div>

                <div class="user-form-buttons">
                    <button type="submit" class="user-btn-submit">Atualizar</button>
                    <button type="button" class="user-btn-cancel" id="cancelEditUser">Cancelar</button>
                </div>
            </form>
        </div>
    </div>



</main>

<!-- Custom Popup para confirmação de eliminação -->
<div id="confirmDeletePopup" class="custom-popup" style="display: none;">
    <div class="popup-content">
        <h3>Confirmação</h3>
        <p>Tens a certeza que queres eliminar este utilizador?</p>
        <div class="popup-buttons">
            <button id="confirmYesBtn" class="btn-confirm">Sim</button>
            <button id="confirmNoBtn" class="btn-cancel">Não</button>
        </div>
    </div>
</div>

<!-- Custom Popup para mensagens de erro -->
<div id="errorPopup" class="custom-popup" style="display: none;">
    <div class="popup-content">
        <h3>Erro</h3>
        <p id="errorMessage"></p>
        <div class="popup-buttons">
            <button id="errorCloseBtn" class="btn-cancel">Fechar</button>
        </div>
    </div>
</div>


<!-- Modal para adicionar usuário -->
<div id="addUserModal" class="user-modal" style="display: none;">
    <div class="user-modal-content">
        <span class="user-modal-close">&times;</span>
        <h2 class="add-user-title">Adicionar Novo Utilizador</h2>
        <form id="addUserForm" method="post" action="${pageContext.request.contextPath}/manageUser">
            <input type="hidden" name="action" value="addUser">

            <div class="user-form-group">
                <label for="name">Nome:</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="user-form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="user-form-group">
                <label for="password">Senha:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="user-form-group">
                <label for="phoneNumber">Número de Telefone:</label>
                <input type="text" id="phoneNumber" name="phoneNumber">
            </div>

            <div class="user-form-group">
                <label for="userType">Tipo de Utilizador:</label>
                <select id="userType" name="userType" required>
                    <option value="user">Usuário</option>
                    <option value="admin">Administrador</option>
                </select>
            </div>

            <div class="user-form-group">
                <label for="status">Status:</label>
                <select id="status" name="status" required>
                    <option value="active">Ativo</option>
                    <option value="inactive">Inativo</option>
                </select>
            </div>

            <div class="user-form-buttons">
                <button type="submit" class="user-btn-submit">Salvar</button>
                <button type="button" class="user-btn-cancel" id="cancelAddUser">Cancelar</button>
            </div>
        </form>
    </div>
</div>



<script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
<script src="${pageContext.request.contextPath}/js/DeleteUser.js"></script>
<script src="${pageContext.request.contextPath}/js/AddUser.js"></script>
<script src="${pageContext.request.contextPath}/js/UpdateUser.js"></script>
<script> var contextPath = "${pageContext.request.contextPath}"; </script>
</body>
</html>
