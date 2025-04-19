<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|UserManagement</title>
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
            <a href="ProfilePage.jsp"> Profile</a>
            <a href="Orderhistory.jsp">Order History</a>
            <a href="AdminPage_StockManagement.jsp">Stock Management</a>
            <a href="AdminPage_UserManagement.jsp">User Management</a>
            <a href="Loginpage.jsp">Log Out</a>
        </div>
    </div>

    <main>
        <div class="select-container">
            <form method="get" action="manageUser">
                <div>
                    <h3 style="text-decoration: underline;">Role:</h3>
                    <select name="role" id="role">
                        <option value="">Todos</option>
                        <c:forEach var="role" items="${allRoles}">
                            <option value="${role}">${role}</option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <h3 style="text-decoration: underline;">Sub-category:</h3>
                    <select name="subRole" id="subRole">
                        <option value="">Todos</option>
                        <c:forEach var="subRole" items="${allSubRoles}">
                            <option value="${subRole}">${subRole}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="search-bar">
                    <h3 style="text-decoration: underline;">User Name:</h3>
                    <input type="text" placeholder="Search.." name="name">
                </div>

                <div>
                    <button type="submit">Filtrar</button>
                </div>
            </form>
        </div>


        <div class="report-links">
            <a href="#"><strong style="color: black; text-decoration: underline;">Generate user
                    report...</strong></a><br>
            <a href="#"><strong style="color: black; text-decoration: underline;">Add user...</strong></a>
        </div>
        <!-- Supondo que 'users' seja uma lista de objetos User que já foi passada pelo Servlet -->
        <div class="table-container">
            <div class="row1">
                <!-- Cabeçalhos da tabela -->
                <div class="column-description"><label>ID</label></div>
                <div class="column-description1"><label>Name</label></div>
                <div class="column-description2"><label>Role</label></div>
                <div class="column-description3"><label>Sub-Role</label></div>
                <div class="column-description4"><label>Email</label></div>
                <div class="column"><label>Status</label></div>
                <div class="column-edit-icon"><label>Actions</label></div>
                <div class="column"><label>Delete</label></div>
            </div>

            <!-- Iterando sobre os usuários e exibindo as informações em cada linha -->
            <c:forEach var="user" items="${users}">
                <div class="row1">
                    <!-- Exibindo os dados do usuário -->
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
                        <label>${user.subRole}</label>
                    </div>
                    <div class="column-description4">
                        <label>${user.email}</label>
                    </div>
                    <div class="column">
                        <!-- Se necessário, você pode adicionar a lógica para atualizar o status -->
                        <select class="btn-update-status" style="font-size: 18px;">
                            <option value="${user.status}">${user.status}</option>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                            <option value="Suspended">Suspended</option>
                        </select>
                    </div>
                    <div class="column-edit-icon">
                        <button class="btn-edit"><i class="material-icons"
                                                    style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                    </div>
                    <div class="column">
                        <button class="btn-edit"><i class="material-icons"
                                                    style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i></button>
                    </div>
                </div>
            </c:forEach>



        <!-- Paginação -->
            <div class="pagination">
                <a href="?page=${currentPage - 1}" class="${currentPage == 1 ? 'disabled' : ''}">&#8592; Previous</a>
                <span>
                    <!-- Exibir os números das páginas -->
                    <c:forEach begin="1" end="${totalPages}" var="page">
                        <a href="?page=${page}" class="${page == currentPage ? 'active' : ''}">${page}</a>
                    </c:forEach>
                </span>
                <a href="?page=${currentPage + 1}" class="${currentPage == totalPages ? 'disabled' : ''}">Next &#8594;</a>
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
    <script src="/js/PopupProfile.js"></script>
</body>

</html>