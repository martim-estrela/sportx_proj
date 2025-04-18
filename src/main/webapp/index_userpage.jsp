<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|HomePage</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/Styles_HomePage.css">
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
            <a href="Loginpage.jsp">Log Out</a>
        </div>
    </div>

    <!-- Popup Search  -->
    <div id="searchModal" class="modal">
        <div class="modal-content">
            <input type="text" id="searchInput" placeholder="Search...">
        </div>
    </div>
    
    <div class="hero-section">
        <h1>Hiking Gear:</h1>
        <p>Explore our brand new selection!</p>
        <button>Explore</button>
    </div>

    <main>
        <section class="product-section">
            <h2>Hiking shoes</h2>
            <a href="/html/SearchBrowse.html" class="view-all">View all products</a>
            <div class="product-grid">
                <div class="product-card">
                    <img src="/img/MerrelMoab3.jpg" alt="Merrel MOAB 3">
                    <p class="Top-Left-text">MERREL MOAB 3</p>
                    <p class="Top-Left-text2">149,00€</p>
                </div>
                <div class="product-card">
                    <img src="/img/SalomonXUltra4.jpg" alt="Salomon X Ultra 4">
                    <p class="Top-Left-text">SALOMON X ULTRA 4</p>
                    <p class="Top-Left-text2">175,00€</p>
                </div>
                <div class="product-card">
                    <img src="/img/DannerTrail2650.jpg" alt="Danner Trail 2650">
                    <p class="Top-Left-text">DANNER TRAIL 2650</p>
                    <p class="Top-Left-text2">169,00€</p>
                </div>
                <div class="product-card">
                    <img src="/img/TimberlandMtMaddsen.jpg" alt="Timberland Mt. Maddsen">
                    <p class="Top-Left-text">TIMBERLAND MT. MADDSEN</p>
                    <p class="Top-Left-text2">120,00€</p>
                </div>
            </div>
        </section>

        <section class="product-section">
            <h2>Best-sellers</h2>
            <a href="/html/SearchBrowse.html" class="view-all">View all</a>
            <div class="product-grid">
                <div class="product-card">
                    <img src="/img/SalomonXUltra4.jpg" alt="Salomon X Ultra 4">
                    <p class="Top-Left-text">SALOMON X ULTRA 4</p>
                    <p class="Top-Left-text2">175,00€</p>
                </div>
                <div class="product-card">
                    <a href = "ProductPage.jsp"><img src="/img/GarminForerunner55.jpg" alt="Garmin Forerunner 55"></a>
                    <p class="Top-Left-text">GARMIN FORERUNNER 55</p>
                    <p class="Top-Left-text2">139,00€</p>
                </div>
                <div class="product-card">
                    <img src="/img/VitufitSetPump.jpg" alt="Viturit Set Pump">
                    <p class="Top-Left-text">VITUFIT SET PUMP</p>
                    <p class="Top-Left-text2">45,00€</p>
                </div>
                <div class="product-card">
                    <img src="/img/Padlle.jpg" alt="PrecisionMax Paddle">
                    <p class="Top-Left-text">PRECISIONMAX PADDLE</p>
                    <p class="Top-Left-text2">248,00€</p>
                </div>
            </div>
        </section>

        <section class="product-section">
            <h2>On Sale</h2>
            <a href="/html/SearchBrowse.html" class="view-all">View all</a>
            <div class="product-grid">
                <div class="product-card">
                    <img src="/img/QuechuaNH50.jpg" alt="Quechua NH50">
                    <p class="Top-Left-text">QUECHUA NH50</p>
                    <p class="Top-Left-text2"><del>18,00€</del> 9,00€</p>
                </div>
                <div class="product-card">
                    <img src="/img/KipstaTraximEdge.jpg" alt="Kipsta Traxum Edge">
                    <p class="Top-Left-text">KIPSTA TRAXUM EDGE</p>
                    <p class="Top-Left-text2"><del>69,00€</del> 39,00€</p>
                </div>
                <div class="product-card">
                    <img src="/img/Riverside500.jpg" alt="Riverside 500">
                    <p class="Top-Left-text">RIVERSIDE 500</p>
                    <p class="Top-Left-text2"><del>329,00€</del> 229,00€</p>
                </div>
                <div class="product-card">
                    <img src="/img/Judo.jpg" alt="Adidas Judo">
                    <p class="Top-Left-text">ADIDAS JUDO</p>
                    <p class="Top-Left-text2"><del>154,00€</del> 154,00€</p>
                </div>
            </div>
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
    <script src="/js/PopupSearch.js"></script>
    <script src="/js/PopupProfile.js"></script>
</body>

</html>