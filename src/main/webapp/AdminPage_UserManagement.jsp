<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|UserManagement</title>
    <link rel="stylesheet" href="/assests/css/styles_AdminPage_User.css">
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
            <a href="ShoppingCart_Page.jsp"><img src="assets/img/shopping-cart.jpg"></a>
            <a href="#" id="profileButton"><img src="/assets/img/account_circle.jpg" alt="Profile"></a>
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
            <div>
                <h3 style="text-decoration: underline;">Role:</h3>
                <select name="category" id="category">
                    <option>Admin</option>
                    <option>Employee</option>
                    <option>User</option>
                    <option>Guest</option>
                </select>
            </div>
            <div>
                <h3 style="text-decoration: underline;">Sub-category:</h3>
                <select name="sub-category" id="sub-category">
                    <option>Sales</option>
                    <option>HR</option>
                    <option>Proj Manager</option>
                </select>
            </div>
            <div class="search-bar">
                <h3 style="text-decoration: underline;">User Name:</h3>
                <input type="text" placeholder="Search.." name="search">
            </div>
        </div>

        <div class="report-links">
            <a href="#"><strong style="color: black; text-decoration: underline;">Generate user
                    report...</strong></a><br>
            <a href="#"><strong style="color: black; text-decoration: underline;">Add user...</strong></a>
        </div>
        <div class=" table-container">
            <div class="row1">
                <div class="column-description">
                    <label>ID</label><br><br>
                    <label for="">21</label>
                </div>
                <div class="column-description1">
                    <label>Name</label><br><br>
                    <label for="">Mike Tyson</label>
                </div>
                <div class="column-description2">
                    <label>Role</label><br><br>
                    <label for="">Employee</label>
                </div>
                <div class="column-description3">
                    <label>Sub-Role</label><br><br>
                    <label for="">Sales</label>
                </div>
                <div class="column-description4">
                    <label>Email</label><br><br>
                    <label for="">mike.tyson@gmail.com</label>
                </div>
                <div class="column">
                    <select class="btn-update-status" style="font-size: 18px;">
                        <option value="">Update Status...</option>
                        <option value="">Active</option>
                        <option value="">Inactive</option>
                        <option value="">Suspended</option>
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

            <div class="row1">
                <div class="column-description">
                    <label>ID</label><br><br>
                    <label for="">21</label>
                </div>
                <div class="column-description1">
                    <label>Name</label><br><br>
                    <label for="">Mike Tyson</label>
                </div>
                <div class="column-description2">
                    <label>Role</label><br><br>
                    <label for="">Employee</label>
                </div>
                <div class="column-description3">
                    <label>Sub-Role</label><br><br>
                    <label for="">Sales</label>
                </div>
                <div class="column-description4">
                    <label>Email</label><br><br>
                    <label for="">mike.tyson@gmail.com</label>
                </div>
                <div class="column">
                    <select class="btn-update-status" style="font-size: 18px;">
                        <option value="">Update Status...</option>
                        <option value="">Active</option>
                        <option value="">Inactive</option>
                        <option value="">Suspended</option>
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

            <div class="row1">
                <div class="column-description">
                    <label>ID</label><br><br>
                    <label for="">21</label>
                </div>
                <div class="column-description1">
                    <label>Name</label><br><br>
                    <label for="">Mike Tyson</label>
                </div>
                <div class="column-description2">
                    <label>Role</label><br><br>
                    <label for="">Employee</label>
                </div>
                <div class="column-description3">
                    <label>Sub-Role</label><br><br>
                    <label for="">Sales</label>
                </div>
                <div class="column-description4">
                    <label>Email</label><br><br>
                    <label for="">mike.tyson@gmail.com</label>
                </div>
                <div class="column">
                    <select class="btn-update-status" style="font-size: 18px;">
                        <option value="">Update Status...</option>
                        <option value="">Active</option>
                        <option value="">Inactive</option>
                        <option value="">Suspended</option>
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

            <div class="row1">
                <div class="column-description">
                    <label>ID</label><br><br>
                    <label for="">21</label>
                </div>
                <div class="column-description1">
                    <label>Name</label><br><br>
                    <label for="">Mike Tyson</label>
                </div>
                <div class="column-description2">
                    <label>Role</label><br><br>
                    <label for="">Employee</label>
                </div>
                <div class="column-description3">
                    <label>Sub-Role</label><br><br>
                    <label for="">Sales</label>
                </div>
                <div class="column-description4">
                    <label>Email</label><br><br>
                    <label for="">mike.tyson@gmail.com</label>
                </div>
                <div class="column">
                    <select class="btn-update-status" style="font-size: 18px;">
                        <option value="">Update Status...</option>
                        <option value="">Active</option>
                        <option value="">Inactive</option>
                        <option value="">Suspended</option>
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

            <div class="row1">
                <div class="column-description">
                    <label>ID</label><br><br>
                    <label for="">21</label>
                </div>
                <div class="column-description1">
                    <label>Name</label><br><br>
                    <label for="">Mike Tyson</label>
                </div>
                <div class="column-description2">
                    <label>Role</label><br><br>
                    <label for="">Employee</label>
                </div>
                <div class="column-description3">
                    <label>Sub-Role</label><br><br>
                    <label for="">Sales</label>
                </div>
                <div class="column-description4">
                    <label>Email</label><br><br>
                    <label for="">mike.tyson@gmail.com</label>
                </div>
                <div class="column">
                    <select class="btn-update-status" style="font-size: 18px;">
                        <option value="">Update Status...</option>
                        <option value="">Active</option>
                        <option value="">Inactive</option>
                        <option value="">Suspended</option>
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
            <div class="row1">
                <div class="column-description">
                    <label>ID</label><br><br>
                    <label for="">21</label>
                </div>
                <div class="column-description1">
                    <label>Name</label><br><br>
                    <label for="">Mike Tyson</label>
                </div>
                <div class="column-description2">
                    <label>Role</label><br><br>
                    <label for="">Employee</label>
                </div>
                <div class="column-description3">
                    <label>Sub-Role</label><br><br>
                    <label for="">Sales</label>
                </div>
                <div class="column-description4">
                    <label>Email</label><br><br>
                    <label for="">mike.tyson@gmail.com</label>
                </div>
                <div class="column">
                    <select class="btn-update-status" id="" style="font-size: 18px;">
                        <option value="">Update Status...</option>
                        <option value="">Active</option>
                        <option value="">Inactive</option>
                        <option value="">Suspended</option>
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