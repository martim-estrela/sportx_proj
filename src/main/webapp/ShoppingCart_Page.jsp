<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX|ShoppingCart</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Styles_ShoppingCart_Page.css">
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
        <h1>Shopping Cart</h1>
        <div class="table1">
            <table>
                <thead>
                    <tr>
                        <th>Product</th>
                        <th></th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="imgStyle">
                                <img src="${pageContext.request.contextPath}/img/GarminForerunner55.jpg" alt="Product Image" class="product-img">
                            </div>

                        </td>
                        <td class="product_info">
                            GARMIN<br>
                            FORERUNNER<br><br>
                            Color: Black<br><br>
                            Size: One size
                        </td>
                        <td>109,00 €</td>
                        <td>
                            <div class="quantity-controls">
                                <button>-</button>
                                <input type="number" value="1" min="0">
                                <button>+</button>
                            </div>
                        </td>
                        <td>109,00 €</td>
                    </tr>

                    <tr>
                        <td>
                            <div class="imgStyle">
                                <img src="${pageContext.request.contextPath}/img/GarminForerunner55.jpg" alt="Product Image" class="product-img">
                            </div>

                        </td>
                        <td class="product_info">
                            GARMIN<br>
                            FORERUNNER<br><br>
                            Color: Black<br><br>
                            Size: One size
                        </td>
                        <td>109,00 €</td>
                        <td>
                            <div class="quantity-controls">
                                <button>-</button>
                                <input type="number" value="1" min="0">
                                <button>+</button>
                            </div>
                        </td>
                        <td>109,00 €</td>
                    </tr>

                    <tr>
                        <td>
                            <div class="imgStyle">
                                <img src="${pageContext.request.contextPath}/img/GarminForerunner55.jpg" alt="Product Image" class="product-img">
                            </div>

                        </td>
                        <td class="product_info">
                            GARMIN<br>
                            FORERUNNER<br><br>
                            Color: Black<br><br>
                            Size: One size
                        </td>
                        <td>109,00 €</td>
                        <td>
                            <div class="quantity-controls">
                                <button>-</button>
                                <input type="number" value="1" min="0">
                                <button>+</button>
                            </div>
                        </td>
                        <td>109,00 €</td>
                    </tr>

                    <tr>
                        <td>
                            <div class="imgStyle">
                                <img src="${pageContext.request.contextPath}/img/GarminForerunner55.jpg" alt="Product Image" class="product-img">
                            </div>

                        </td>
                        <td class="product_info">
                            GARMIN<br>
                            FORERUNNER<br><br>
                            Color: Black<br><br>
                            Size: One size
                        </td>
                        <td>109,00 €</td>
                        <td>
                            <div class="quantity-controls">
                                <button>-</button>
                                <input type="number" value="1" min="0">
                                <button>+</button>
                            </div>
                        </td>
                        <td>109,00 €</td>
                    </tr>

                    <tr>
                        <td>
                            <div class="imgStyle">
                                <img src="${pageContext.request.contextPath}/img/GarminForerunner55.jpg" alt="Product Image" class="product-img">
                            </div>

                        </td>
                        <td class="product_info">
                            GARMIN<br>
                            FORERUNNER<br><br>
                            Color: Black<br><br>
                            Size: One size
                        </td>
                        <td>109,00 €</td>
                        <td>
                            <div class="quantity-controls">
                                <button>-</button>
                                <input type="number" value="1" min="0">
                                <button>+</button>
                            </div>
                        </td>
                        <td>109,00 €</td>
                    </tr>

                </tbody>
            </table>

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
                <a href="CheckoutPage.jsp">
                    <button class="checkout-btn">Checkout</button>
                  </a>
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