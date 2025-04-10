<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|Search/Browse</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/styles_Chat.css">
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

    <!-- Popup Search  -->
    <div id="searchModal" class="modal">
        <div class="modal-content">
            <input type="text" id="searchInput" placeholder="Search...">
        </div>
    </div>
    
    <main>
        <div class="chat">
            <div class="chat-header">
                <img src="../img/chat.png">
                <div class="chat-header-text">
                    <p>Chat with</p>
                    <h3>SportX Assistant</h3>
                </div>
                <div class="chat-header-buttons">
                    <button>_</button>
                    <button>X</button>
                </div>
            </div>
            <div class="messages">
                <div class="support-message">
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut placerat a mauris eget molestie. Morbi erat felis, dictum ut tincidunt at, efficitur vel neque.</p>
                </div>
                <div class="user-message">
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut placerat a mauris eget molestie. Morbi erat felis, dictum ut tincidunt at, efficitur vel neque.</p>
                </div>
            </div>
            <div class="messages-input">
                <button><img class="attach" src="../img/attach.png" alt=""></button>
                <input type="text" placeholder="Type your message..." >
                <button><img class="send" src="../img/send.png" alt=""></button>
            </div>
        </div>
        
        
    </main>



    <footer>
        <section class="support">
            <h2>Support</h2>
            <ul>
                <li><a href="ContactUs.jsp">Contact us</a></li>
                <li><a href="FAQ.jsp">FAQ</a></li>
                <li><a href="Chat_Page.jsp">Live Chat</a></li>
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
    <script src="/js/FAQVisibility.js"></script>
</body>