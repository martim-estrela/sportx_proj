<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|Search/Browse</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_searchBrowse.css">
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
        <div class="path"><a href="">Hiking </a>> <a href="">Hiking Shoes</a></div>
        <div class="main-container">
            <section class="filters">
                <h2>Filters</h2>
                <div class="filter-group">
                    <h3>Product Brand</h3>
                    <label><input type="checkbox"> Merrel</label>
                    <label><input type="checkbox"> Solomon</label>
                    <label><input type="checkbox"> Danner</label>
                    <label><input type="checkbox"> Timberland</label>
                </div>
                <div class="filter-group">
                    <h3>Price</h3>
                    <label><input type="checkbox"> 0 - 50€</label>
                    <label><input type="checkbox"> 50 - 100€</label>
                    <label><input type="checkbox"> 100 - 150€</label>
                    <label><input type="checkbox"> >150€</label>
                </div>
                <div class="filter-group">
                    <h3>Color</h3>
                    <label><input type="checkbox"> Brown</label>
                    <label><input type="checkbox"> Black</label>
                    <label><input type="checkbox"> Grey</label>
                    <label><input type="checkbox"> Green</label>
                </div>
                <div class="filter-group">
                    <h3>Discount</h3>
                    <label><input type="checkbox"> No Discount</label>
                    <label><input type="checkbox"> 0 - 20%</label>
                    <label><input type="checkbox"> 21 - 40%</label>
                    <label><input type="checkbox"> 41 - 70%</label>
                </div>
            </section>
            <section class="products">
                <div class="sort">
                    <label for="sort">Sort by:</label>
                    <select id="sort">
                        <option>Popularity</option>
                        <option>Price: Low to High</option>
                        <option>Price: High to Low</option>
                    </select>
                </div>
                <div class="product-grid">
                    <div class="product-card">
                        <img src="../img/MerrelMoab3.jpg" alt="Merrel Moab 3">
                        <h3>MERREL MOAB 3</h3>
                        <p>149,00€</p>
                    </div>
                    <div class="product-card">
                        <img src="../img/SalomonXUltra4.jpg" alt="Salomon X Ultra 4">
                        <h3>SALOMON X ULTRA 4</h3>
                        <p>175,00€</p>
                    </div>
                    <div class="product-card">
                        <img src="../img/DannerTrail2650.jpg" alt="Danner Trail 2650">
                        <h3>DANNER TRAIL 2650</h3>
                        <p>169,00€</p>
                    </div>
                    <div class="product-card">
                        <img src="../img/MerrelMoab3.jpg" alt="Merrel Moab 3">
                        <h3>MERREL MOAB 3</h3>
                        <p>149,00€</p>
                    </div>
                    <div class="product-card">
                        <img src="../img/SalomonXUltra4.jpg" alt="Salomon X Ultra 4">
                        <h3>SALOMON X ULTRA 4</h3>
                        <p>175,00€</p>
                    </div>
                    <div class="product-card">
                        <img src="../img/DannerTrail2650.jpg" alt="Danner Trail 2650">
                        <h3>DANNER TRAIL 2650</h3>
                        <p>169,00€</p>
                    </div>
                    <div class="product-card">
                        <img src="../img/MerrelMoab3.jpg" alt="Merrel Moab 3">
                        <h3>MERREL MOAB 3</h3>
                        <p>149,00€</p>
                    </div>
                    <div class="product-card">
                        <img src="../img/SalomonXUltra4.jpg" alt="Salomon X Ultra 4">
                        <h3>SALOMON X ULTRA 4</h3>
                        <p>175,00€</p>
                    </div>
                    <div class="product-card">
                        <img src="../img/DannerTrail2650.jpg" alt="Danner Trail 2650">
                        <h3>DANNER TRAIL 2650</h3>
                        <p>169,00€</p>
                    </div>
                </div>
                <nav class="pagination">
                    <a href="#">&laquo; Previous</a>
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <span>...</span>
                    <a href="#">67</a>
                    <a href="#">68</a>
                    <a href="#">Next &raquo;</a>
                </nav>
            </section>
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
    <script src="/js/PopupSearch.js"></script>
    <script src="/js/PopupProfile.js"></script>
</body>