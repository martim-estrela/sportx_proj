<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|ContactUs</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_ContactUs.css">
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

    <!-- Popup Search  -->
    <div id="searchModal" class="modal">
        <div class="modal-content">
            <input type="text" id="searchInput" placeholder="Search...">
        </div>
    </div>
    
    <main>
        <section class = "contact-us-titulo">
            <h1>Contact Us</h1>
            <h2>Any question or remarks? Just write us a message!</h2>
        </section>
        <section class="contact-us">
            <div class="contact-info">
                <h1>Contact Information</h1>
                <h2>Say something!</h2>
                <p><span class="icon phone"></span><strong>Phone: </strong> +351 919 191 919</p>
                <p><span class="icon email"></span><strong>Email: </strong> lusofona@xxxxxx.com</p>
                <p><span class="icon address"></span><strong>Address: </strong> Rua Lusofona da Lusofona 3000-100</p>
            </div>

            <div class="contact-form">
                <form action="${pageContext.request.contextPath}/submit-message" method="POST">
                    <div class="form-group inline">
                        <div class="inline-item1">
                            <label for="first-name">First Name</label>
                            <input type="text" id="first-name" name="first-name" required>
                        </div>
                        <div class="inline-item2">
                            <label for="last-name">Last Name</label>
                            <input type="text" id="last-name" name="last-name" required>
                        </div>
                    </div>
            
                    <div class="form-group inline">
                        <div class="inline-item1">
                            <label for="email">Email</label>
                            <input type="text" id="email" name="email" required>
                        </div>
                        <div class="inline-item2">
                            <label for="phone">Phone Number</label>
                            <input type="text" id="phone" name="phone" required>
                        </div>
                    </div>
            
                    <div class="form-group">
                        <label>Select Subject</label>
                        <div class="subject-options">
                            <label>
                                <input type="radio" name="subject" value="general" required> General Inquiry
                            </label>
                            <label>
                                <input type="radio" name="subject" value="support"> Support
                            </label>
                            <label>
                                <input type="radio" name="subject" value="feedback"> Feedback
                            </label>
                        </div>
                    </div>
            
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" required></textarea>
                    </div>
            
                    <button type="submit">Send Message</button>
                </form>
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
            <form action="${pageContext.request.contextPath}/subscribe">
                <input type="email" name="email" placeholder="Enter your email" required />
                <button type="submit">Subscribe</button>
            </form>
        </section>
    </footer>
    <script src="${pageContext.request.contextPath}/js/PopupSearch.js"></script>
    <script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
</body>