<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|Checkout</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_CheckouPage.css">
</head>

<body>
    <header>
        <div>
            <a href="${pageContext.request.contextPath}/index.jsp"><strong>SPORTX</strong></a>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/SearchBrowse.jsp">Products</a>
        </div>
        <div>
            <a href="ShoppingCart_Page.jsp"><img src="${pageContext.request.contextPath}/img/shopping-cart.jpg"></a>
            <a href="#" id="profileButton"><img src="${pageContext.request.contextPath}/img/account_circle.jpg" alt="Profile"></a>
        </div>
    </header>

    <!-- Popup Menu -->
    <div id="profilePopup" class="popup">
        <div class="popup-content">
            <!-- Exibe Login e Register se o usuário não estiver logado -->
            <c:if test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/Loginpage.jsp">Login</a>
                <a href="${pageContext.request.contextPath}/Sign_up_Page.jsp">Register</a>
            </c:if>

            <!-- Exibe Profile, Order History e opções de admin se o usuário estiver logado -->
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/ProfilePage.jsp">Profile</a>
                <a href="${pageContext.request.contextPath}/Orderhistory.jsp">Order History</a>

                <!-- Exibe as opções de admin se o usuário for admin -->
                <c:if test="${sessionScope.user.userType == 'admin'}">
                    <a href="${pageContext.request.contextPath}/AdminPage_StockManagement.jsp">Stock Management</a>
                    <a href="${pageContext.request.contextPath}/AdminPage_UserManagement.jsp">User Management</a>
                </c:if>

                <!-- Sempre aparece a opção de logout se estiver logado -->
                <a href="${pageContext.request.contextPath}/LogoutServlet">Log Out</a>
            </c:if>
        </div>
    </div>

    <!-- Popup Search  -->
    <div id="searchModal" class="modal">
        <div class="modal-content">
            <input type="text" id="searchInput" placeholder="Search...">
        </div>
    </div>
    
    <main>
        <div class="container">
            <div class="left-column">
                <div class="personal-info1">
                    <h3 style="text-align: left; background-color: #D9D9D9;">Personal Information</h3>
                    <div class="line"></div>
                    <div class="Pinfo-item">
                        <label for="your-name">Your Name</label><br>
                        <input type="text" name="your-name" id="">
                    </div>
                    <div class="row">
                        <div class="Pinfo-item">
                            <label for="email">Email</label><br>
                            <input type="text" name="email" id="">
                        </div>
                        <div class="Pinfo-item">
                            <label for="phone-number">Phone Number</label><br>
                            <input type="text" name="phone-number" id="">
                        </div>
                    </div>
                </div>

                <div class="personal-info">
                    <h3 style="text-align: left; background-color: #D9D9D9;">Shipping Address</h3>
                    <div class="line"></div>
                    <!-- Linha 1: Address e Postal Code -->
                    <div class="row">
                        <div class="Pinfo-item">
                            <label for="address">Address</label>
                            <input type="text" name="address" id="address">
                        </div>
                        <div class="Pinfo-item">
                            <label for="postal-code">Postal Code</label>
                            <input type="text" name="postal-code" id="postal-code">
                        </div>
                    </div>

                    <!-- Linha 2: City e Country -->
                    <div class="row">
                        <div class="Pinfo-item">
                            <label for="city">City</label>
                            <input type="text" name="city" id="city">
                        </div>
                        <div class="Pinfo-item">
                            <label for="country">Country</label>
                            <input type="text" name="country" id="country">
                        </div>
                    </div>
                </div>


                <div class="personal-info">
                    <h3 style="text-align: left; background-color: #D9D9D9;">Personal Information</h3>
                    <div class="line"></div>
                    <div class="radio-input">
                        <input type="radio" name="cash-on-delivery" id="">
                        <label for="cash-on-delivery">Cash On Delivery</label>
                        <input type="radio" name="credit-or-debit" id="">
                        <label for="credit-or-debit">Credit Or Debit</label>
                    </div>
                    <div class="Pinfo-item">
                        <label for="cardeHolder-name">CardHolder Name</label><br>
                        <input type="text" name="cardeHolder-name" id="">
                    </div>
                    <div class="Pinfo-item">
                        <label for="card-number">Card Number</label><br>
                        <input type="text" name="card-number" id="">
                    </div>
                    <div class="row1">
                        <div class="Pinfo-item">
                            <label for="exp-date">EXP Date</label><br>
                            <input type="text" name="exp-date" id="">

                        </div>
                        <div class="Pinfo-item">
                            <label for="cvc">CVC</label><br>
                            <input type="text" name="cvc" id="">
                        </div>

                    </div>
                </div>
            </div>
            <div class="cart-totals">
                <h3 style="text-align: center; background-color: #D9D9D9;">Cart Totals</h3>
                <div class="totals-item">
                    <span>Subtotal:</span>
                    <span>100,00 €</span>
                </div>
                <div class="line"></div>
                <div class="totals-item">
                    <span>Shipping:</span>
                    <span>6,00 €</span>
                </div>
                <div class="line"></div>
                <div class="totals-item">
                    <span><strong style="background-color: #D9D9D9;">Total:</strong></span>
                    <span><strong style="background-color: #D9D9D9;">106,00 €</strong></span>
                </div>
                <button class="checkout-btn">Checkout</button>
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
    <script src="${pageContext.request.contextPath}/js/PopupSearch.js"></script>
    <script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
</body>

</html>