<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|StockManagemtent</title>
    <link rel="stylesheet" href="../assets/css/styles_AdminPage_Stock.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
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
            <a href="ShoppingCart_Page.jsp"><img src="../assets/img/shopping-cart.jpg"></a>
            <a href="#" id="profileButton"><img src="../assets/img/account_circle.jpg" alt="Profile"></a>
        </div>
    </header>

    <!-- Popup Menu -->
    <div id="profilePopup" class="popup">
        <div class="popup-content">
            <a href="ProfilePage.jsp"> Profile</a>
            <a href="Orderhistory.jsp">Order History</a>
            <a href="AdminPage_StockManagement.html">Stock Management</a>
            <a href="AdminPage_UserManagement.jsp">User Management</a>
            <a href="Loginpage.jsp">Log Out</a>
        </div>
    </div>

    <main>
        <div class="select-container">
            <div>
                <h3 style="text-decoration: underline;">Category:</h3>
                <select name="category" id="category">
                    <option value="shoes">Shoes</option>
                    <option value="pants">Pants</option>
                    <option value="hoodies">Hoodies & Sweatshirts</option>
                    <option value="tops">Tops & T-Shirts</option>
                </select>
            </div>
            <div>
                <h3 style="text-decoration: underline;">Sub-category:</h3>
                <select name="sub-category" id="sub-category">
                    <option value="basketball">Basketball</option>
                    <option value="tennis">Tennis</option>
                    <option value="football">Football</option>
                    <option value="rugby">Rugby</option>
                </select>
            </div>
            <div class="search-bar">
                <h3 style="text-decoration: underline;">Product Name:</h3>
                <input type="text" placeholder="Search.." name="search">
            </div>
        </div>

        <div class="report-links">
            <a href="#"><strong style="color: black; text-decoration: underline;">Generate stock
                    report...</strong></a><br>
            <a href="#"><strong style="color: black; text-decoration: underline;">Add product...</strong></a>
        </div>
        <div class=" table-container">
            <div class="row1">
                <div class="column-img"><img src="../assets/img/jordan.jpg" style="width: 104px; height: 104px;" alt="">
                </div>
                <div class="column-description">
                    <label>Nike Air Jordan 1 Mid</label><br><br>
                    <label>Color: Taxi</label>
                </div>
                <div class="column">
                    <button class="btn-update-stock" onclick="openModal()" style="font-size: 18px;">Update
                        Stock...</button>
                </div>
                <div class="column-edit-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                </div>
                <div class="column-delete-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i></button>
                </div>
            </div>

            <div class="row1">
                <div class="column-img"><img src="/img/jordan.jpg" style="width: 104px; height: 104px;" alt="">
                </div>
                <div class="column-description">
                    <label>Nike Air Jordan 1 Mid</label><br><br>
                    <label >Color: Taxi</label>
                </div>
                <div class="column">
                    <button class="btn-update-stock" onclick="openModal()" style="font-size: 18px;">Update
                        Stock...</button>
                </div>
                <div class="column-edit-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                </div>
                <div class="column-delete-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i></button>
                </div>
            </div>

            <div class="row1">
                <div class="column-img"><img src="/img/jordan.jpg" style="width: 104px; height: 104px;" alt="">
                </div>
                <div class="column-description">
                    <label>Nike Air Jordan 1 Mid</label><br><br>
                    <label>Color: Taxi</label>
                </div>
                <div class="column">
                    <button class="btn-update-stock" onclick="openModal()" style="font-size: 18px;">Update
                        Stock...</button>
                </div>
                <div class="column-edit-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                </div>
                <div class="column-delete-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i></button>
                </div>
            </div>

            <div class="row1">
                <div class="column-img"><img src="/img/jordan.jpg" style="width: 104px; height: 104px;" alt="">
                </div>
                <div class="column-description">
                    <label>Nike Air Jordan 1 Mid</label><br><br>
                    <label>Color: Taxi</label>
                </div>
                <div class="column">
                    <button class="btn-update-stock" onclick="openModal()" style="font-size: 18px;">Update
                        Stock...</button>
                </div>
                <div class="column-edit-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                </div>
                <div class="column-delete-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i></button>
                </div>
            </div>

            <div class="row1">
                <div class="column-img"><img src="/img/jordan.jpg" style="width: 104px; height: 104px;" alt="">
                </div>
                <div class="column-description">
                    <label>Nike Air Jordan 1 Mid</label><br><br>
                    <label>Color: Taxi</label>
                </div>
                <div class="column">
                    <button class="btn-update-stock" onclick="openModal()" style="font-size: 18px;">Update
                        Stock...</button>
                </div>
                <div class="column-edit-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                </div>
                <div class="column-delete-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i></button>
                </div>
            </div>

            <div class="row1">
                <div class="column-img"><img src="/img/jordan.jpg" style="width: 104px; height: 104px;" alt="">
                </div>
                <div class="column-description">
                    <label>Nike Air Jordan 1 Mid</label><br><br>
                    <label>Color: Taxi</label>
                </div>
                <div class="column">
                    <button class="btn-update-stock" onclick="openModal()" style="font-size: 18px;">Update
                        Stock...</button>
                </div>
                <div class="column-edit-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="background-color: #d9d9d9d9; font-size:40px">edit_square</i></button>
                </div>
                <div class="column-delete-icon">
                    <button class="btn-edit"><i class="material-icons"
                            style="color: red; background-color: #d9d9d9d9; font-size:40px">close</i></button>
                </div>
            </div>

            <!--Modal-->
            <div class="modal" id="stockModal">
                <div class="modal-content">
                    <h3>Update Stock</h3>
                    <div class="input-grid">
                        <div class="input-container">
                            <label class="input-label">Size 36:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 38">
                        </div>
                        <div class="input-container">
                            <label class="input-label">Size 37:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 38">
                        </div>
                        <div class="input-container">
                            <label class="input-label">Size 38:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 38">
                        </div>
                        <div class="input-container">
                            <label class="input-label">Size 39:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 39">
                        </div>
                        <div class="input-container">
                            <label class="input-label">Size 40:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 40">
                        </div>
                        <div class="input-container">
                            <label class="input-label">Size 41:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 41">
                        </div>
                        <div class="input-container">
                            <label class="input-label">Size 42:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 42">
                        </div>
                        <div class="input-container">
                            <label class="input-label">Size 43:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 43">
                        </div>
                        <div class="input-container">
                            <label class="input-label">Size 44:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 44">
                        </div>
                        <div class="input-container">
                            <label class="input-label">Size 45:</label>
                            <input type="number" class="input-field" placeholder="Enter stock for size 45">
                        </div>
                    </div>
                    <br>
                    <a href="#" class="add-modal-btn" onclick="closeModal()">Add Stock</a>
                    <a href="#" class="close-modal-btn" onclick="closeModal()">Cancel</a>
                </div>
            </div>


            <script src="/js/PopupStock.js">
            </script>
            <!-- Paginação -->
            <div class="pagination">
                <a href="#">&#8592; Previous</a>
                <span>
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <span>...</span>
                    <a href="#">67</a>
                    <a href="#">68</a>
                </span>
                <a href="#">Next &#8594;</a>
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