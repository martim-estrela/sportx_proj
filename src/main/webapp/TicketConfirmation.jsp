<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<style>
    /* styles_ContactUs.css */

    /* Reset some default styles */
    body, h1, p, a {
        margin: 0;
        padding: 0;
        font-family: 'Nunito Sans', sans-serif;
    }

    /* General body and page styling */
    body {
        background-color: #f4f4f9;
        font-family: 'Nunito Sans', sans-serif;
        color: #333;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /*--------------------------------------------------------------------HEADER-------------------------------------------------------------------------------*/
    header {
        justify-content: space-between;
        display: flex;
        align-items: center;
        padding: 15px 20px;
        width: auto;

    }

    header div {
        display: flex;
        gap: 40px;
        /* Espaçamento entre os elementos */
    }

    header div:last-child {
        justify-content: right;
        display: flex;
        align-items: right;
        gap: 20px;
        /* Espaçamento entre os elementos */
    }

    header strong {
        position: absolute;
        top: 10px;
        left: 10px;
        display: flex;
        color: #000;
        font-family: "Passion One";
        font-size: 30px;
        /* Tamanho do texto */
    }

    header a {
        display: inline-flex;
        /* Garante que os elementos estejam na mesma linha */
        align-items: center;
        /* Alinha verticalmente */
        text-decoration: none;
        /* Remove o sublinhado do texto */
        color: black;
        /* Cor do texto */
        font-size: 16px;
        /* Tamanho do texto */
        margin: 0 10px;
        /* Espaçamento entre os elementos */
    }

    header a:hover {
        color: #218A38;
        /* Destaque ao passar o rato */
    }

    /* Popup Styles */
    .popup {
        display: none;
        /* Inicialmente oculto */
        position: absolute;
        top: 50px;
        right: 20px;
        border: 2px solid #4CAF50;
        /* Aqui estamos adicionando uma borda verde */
        border-radius: 8px;
        /* Bordas arredondadas */
        padding: 15px;
        width: 200px;
        z-index: 1000;
    }

    .popup-content {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .popup-content a {
        text-decoration: none;
        color: black;
        font-size: 16px;
    }

    .popup-content a:hover {
        color: #218A38;
    }

    /* Popup Styles profile */
    .popup {
        display: none;
        /* Inicialmente oculto */
        position: absolute;
        top: 50px;
        right: 20px;
        border: 2px solid #4CAF50;
        /* Aqui estamos adicionando uma borda verde */
        border-radius: 8px;
        /* Bordas arredondadas */
        padding: 15px;
        width: 200px;
        z-index: 1000;
    }

    .popup-content {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .popup-content a {
        text-decoration: none;
        color: black;
        font-size: 16px;
    }

    .popup-content a:hover {
        color: #218A38;
    }

    /* Popup Styles search */
    /* Modal styles */
    .modal {
        display: none;
        /* Initially hidden */
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: transparent;
        padding-top: -200px;
    }

    .modal-content {
        background-color: transparent;
        margin: -1.5% 35%;
        padding: 20px;
        width: 80%;
        max-width: 400px;
    }

    .close:hover,
    .close:focus {
        text-decoration: none;
        cursor: pointer;
    }

    input[type="text"] {
        width: 80%;
        padding: 10px;
        margin: 20px 0;
    }


    /* Main section styling */
    main {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 50px 15px;
        background-color: #D1D1D1;
    }

    .confirmation-section {
        text-align: center;
        max-width: 600px;
        margin: 0 auto;
        padding: 30px;
        background-color: #ffffff;
    }

    .confirmation-section h1 {
        font-size: 28px;
        color: #333;
        margin-bottom: 20px;
    }

    .confirmation-section p {
        font-size: 18px;
        color: #555;
        margin-bottom: 20px;
    }

    .confirmation-section a {
        text-decoration: none;
        color: #4CAF50;
        font-size: 18px;
        font-weight: bold;
        transition: color 0.3s ease;
    }

    .confirmation-section a:hover {
        color: #45a049;
    }

    /* Footer section styling */
    footer {
        display: flex;
        /* Habilita Flexbox para organizar os elementos no rodapé */
        justify-content: space-between;
        /* Coloca os elementos nos cantos */
        align-items: flex-start;
        /* Alinha os itens no topo do rodapé */
        padding: 20px;
        /* Espaçamento interno */
        margin-top: auto;
        /* Garante que o rodapé fique no final da página */
    }

    /*Fonte e margem do titulo "Support"*/
    .support h2 {
        font-size: 17px;
        margin-bottom: 10px;
    }

    /*mudança na lista*/
    .support ul {
        list-style-type: none;
        padding-left: 0;
    }

    /*margem entre os elementos da lista*/
    .support ul li {
        margin: 10px 0;
    }

    /* Elementos da lista */
    .support ul li a {
        text-decoration: none;
        color: #000000;
        font-size: 14px;
    }

    /*Quando se passa rato por cima sublinhar*/
    .support ul li a:hover {
        text-decoration: underline;
    }

    /* Estilos da secção de inscrição */

    /*Fonte e margem do titulo "Subscribe"*/
    .subscribe h2 {
        font-size: 17px;
        margin-bottom: 10px;
    }

    /*Estilo do formulario*/
    .subscribe form {
        display: flex;
        flex-direction: column;
        align-items: left;
    }


    .subscribe input {
        background-color: #D1D1D1;
        margin-bottom: 30px;
        font-size: 15px;
        border: 0.1px solid #cccccc;
    }

    /* Retirar borda ao clicar para inserir */
    .subscribe input:focus {
        outline: none;
    }

    /*Botao subcrever*/
    .subscribe button {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        color: #D1D1D1;
        background: #222325;
        border: none;
        cursor: pointer;
    }
</style>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Submitted | SportX</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_ContactUs.css">
</head>

<header>
    <div>
        <a href="${pageContext.request.contextPath}/index.jsp"><strong>SPORTX</strong></a>
    </div>
    <div>
        <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Products</a>
        <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Sale</a>
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

<!-- Popup Search  -->
<div id="searchModal" class="modal">
    <div class="modal-content">
        <input type="text" id="searchInput" placeholder="Search...">
    </div>
</div>

<main>
    <section class="confirmation-section">
        <h1>Thank you for contacting us!</h1>
        <p>Your ticket has been successfully submitted. We will get back to you as soon as possible.</p>
        <p>If you have any further questions, feel free to reach out again.</p>
        <a href="${pageContext.request.contextPath}/index.jsp">Return to Home</a>
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
