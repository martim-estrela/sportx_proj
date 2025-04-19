<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX | Perfil de Utilizador</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Styles_ProfilePage.css
</head>

<body>
    <header>
        <div>
            <a href="/html/index.html"><strong>SPORTX</strong></a>
        </div>
        <div>
            <a href="/html/SearchBrowse.html">Products</a>
            <a href="/html/SearchBrowse.html">Sale</a>
            <a href="#" id="searchButton">Search</a>
        </div>
        <div>
            <a href="ShoppingCart_Page.jsp"><img src="/img/shopping-cart.jpg"></a>
            <a href="#" id="profileButton"><img src="/img/account_circle.jpg" alt="Profile"></a>
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

    <div class="profile-container">
        <h1>Welcome To Your Profile</h1>
        <div class="profile-info">
            <p><strong>Name:</strong> Bill Gates</p>
            <p><strong>Email:</strong> BillGates@example.com</p>
            <p><strong>Address:</strong> Rua dos Anjos 59 , 2300-222</p>
            <p><strong>Phone-number:</strong> +351 911 911 911</p>
            <button id="btn_edit_profile">Editar</button>
        </div>
    </div>

    <!-- Modal -->
    <div id="profileModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h1>Editar Perfil</h1>
            <div class="modal-info">
                <label for="name">Nome:</label>
                <input type="text" id="name" placeholder="Insira seu nome">

                <label for="email">Email:</label>
                <input type="email" id="email" placeholder="Insira seu email">

                <label for="address">Endereço:</label>
                <input type="text" id="address" placeholder="Insira seu endereço">

                <label for="phone">Telefone:</label>
                <input type="text" id="phone" placeholder="Insira seu telefone">

                <button id="btn_save_profile">Salvar</button>
            </div>
        </div>
    </div>
    <script src="/js/ProfileModal.js">
    </script>

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
    <script src="/js/PopupSearch.js"></script>
    <script src="/js/PopupProfile.js"></script>
</body>

</html>