<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportX | Shopping Cart</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Styles_ShoppingCart_Page.css">
</head>
<body>
<header>
    <div>
        <a href="${pageContext.request.contextPath}/HomePageServlet"><strong>SPORTX</strong></a>
    </div>
    <div>
        <a href="${pageContext.request.contextPath}/SearchBrowseServlet">Products</a>
    </div>
    <div>
        <a href="ShoppingCart_Page.jsp"><img src="${pageContext.request.contextPath}/img/shopping-cart.jpg" alt="Cart"></a>
        <a href="#" id="profileButton"><img src="${pageContext.request.contextPath}/img/account_circle.jpg" alt="Profile"></a>
    </div>
</header>

<!-- Popup Profile -->
<div id="profilePopup" class="popup">
    <div class="popup-content">
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/Loginpage.jsp">Login</a>
                <a href="${pageContext.request.contextPath}/Sign_up_Page.jsp">Register</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/ProfilePage.jsp">Profile</a>
                <a href="${pageContext.request.contextPath}/OrderHistoryServlet">Order History</a>
                <c:if test="${sessionScope.user.userType == 'admin'}">
                    <a href="${pageContext.request.contextPath}/AdminPage_StockManagement.jsp">Stock Management</a>
                    <a href="${pageContext.request.contextPath}/AdminPage_UserManagement.jsp">User Management</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/LogoutServlet">Log Out</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Popup Search -->
<div id="searchModal" class="modal">
    <div class="modal-content">
        <input type="text" id="searchInput" placeholder="Search...">
    </div>
</div>

<main>
    <h1>Shopping Cart</h1>
    <div class="table1">
        <c:choose>
            <c:when test="${empty sessionScope.cart}">
                <div class="empty-cart-message">
                    <p>Your shopping cart is empty</p>
                    <a href="${pageContext.request.contextPath}/SearchBrowseServlet" class="continue-shopping">
                        Continue Shopping
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                    <tr>
                        <th>Product</th>
                        <th></th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${sessionScope.cart}">
                        <tr>
                            <td>
                                <div class="imgStyle">
                                    <img src="${item.imageUrl}"
                                         alt="${item.productName}">
                                </div>
                            </td>
                            <td class="product_info">
                                    ${item.productName}
                                <div class="product-variations">
                                    <c:forEach items="${item.variations}" var="variation">
                                        <div>${variation.key}: ${variation.value}</div>
                                    </c:forEach>
                                </div>
                            </td>
                            <td>
                                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="€"/>
                            </td>
                            <td>
                                <div class="quantity-controls">
                                    <input type="hidden" id="stock_${item.productItemId}" value="${item.stock}">
                                    <button type="button" onclick="decrementQuantity('${item.productItemId}', ${item.price})">-</button>
                                    <input type="number"
                                           value="${item.quantity}"
                                           min="1"
                                           max="${item.stock}"
                                           id="quantity_${item.productItemId}"
                                           onchange="validateQuantity('${item.productItemId}', this, ${item.price})">
                                    <button type="button" onclick="incrementQuantity('${item.productItemId}', ${item.price})">+</button>
                                    <span id="warning_${item.productItemId}" class="stock-warning"></span>
                                </div>
                            </td>
                            <td id="subtotal_${item.productItemId}">
                                <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="€"/>
                            </td>
                            <td>
                                <button type="button" class="remove-btn" onclick="removeItem(${item.productItemId})">X</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="shipping-methods">
                    <h3>Shipping Method</h3>
                    <div class="shipping-options">
                        <c:forEach var="method" items="${shippingMethods}">
                            <div class="shipping-option">
                                <input type="radio"
                                       id="shipping_${method.shippingId}"
                                       name="shippingMethod"
                                       value="${method.shippingId}"
                                       onchange="updateShippingMethod(${method.shippingId})"
                                    ${method.shippingId == sessionScope.selectedShippingMethod.shippingId ? 'checked' : ''}>
                                <label for="shipping_${method.shippingId}">
                                    <span class="shipping-name">${method.name}</span>
                                    <span class="shipping-price">€<fmt:formatNumber value="${method.price}" minFractionDigits="2" maxFractionDigits="2"/></span>
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="cart-totals">
                    <h3 style="text-align: center; background-color: #D9D9D9;">Cart Totals</h3>
                    <div class="totals-item">
                        <span>Subtotal:</span>
                        <span id="cart-subtotal">
                                <fmt:formatNumber value="${sessionScope.cartTotal}" type="currency" currencySymbol="€"/>
                            </span>
                    </div>
                    <div class="line"></div>
                    <div class="totals-item">
                        <span>Shipping:</span>
                        <span id="shipping-cost">
                                <fmt:formatNumber value="${sessionScope.selectedShippingMethod.price}" type="currency" currencySymbol="€"/>
                            </span>
                    </div>
                    <div class="line"></div>
                    <div class="totals-item">
                        <span><strong style="background-color: #D9D9D9;">Total:</strong></span>
                        <span id="cart-total">
                                <strong style="background-color: #D9D9D9;">
                                    <fmt:formatNumber value="${sessionScope.cartTotal + sessionScope.selectedShippingMethod.price}" type="currency" currencySymbol="€"/>
                                </strong>
                            </span>
                    </div>
                    <a href="CheckoutPage.jsp">
                        <button class="checkout-btn">Checkout</button>
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<footer>
    <section class="support">
        <h2>Support</h2>
        <ul>
            <li><a href="${pageContext.request.contextPath}/ContactUs.jsp">Contact us</a></li>
            <li><a href="${pageContext.request.contextPath}/FAQ.jsp">FAQ</a></li>
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
<script>
    // Variável global para armazenar o ID do produto a ser removido
    let productIdToRemove = null;

    function validateQuantity(productId, input, price) {
        const quantity = parseInt(input.value) || 1;
        const stock = parseInt(document.getElementById('stock_' + productId).value);
        const warning = document.getElementById('warning_' + productId);

        if (quantity < 1) {
            input.value = 1;
            updateQuantity(productId, input, price);
            return;
        }

        if (quantity > stock) {
            warning.textContent = `(Max: ${stock})`;
            input.value = stock;
        } else {
            warning.textContent = '';
        }

        updateQuantity(productId, input, price);
    }

    function incrementQuantity(productId, price) {
        const input = document.getElementById('quantity_' + productId);
        const stock = parseInt(document.getElementById('stock_' + productId).value);
        const warning = document.getElementById('warning_' + productId);

        let quantity = parseInt(input.value) || 1;

        if (quantity < stock) {
            quantity++;
            input.value = quantity;
            warning.textContent = '';
            updateQuantity(productId, input, price);
        } else {
            warning.textContent = `(Max: ${stock})`;
        }
    }

    function decrementQuantity(productId, price) {
        const input = document.getElementById('quantity_' + productId);
        const warning = document.getElementById('warning_' + productId);

        let quantity = parseInt(input.value) || 1;

        if (quantity > 1) {
            quantity--;
            input.value = quantity;
            warning.textContent = '';
            updateQuantity(productId, input, price);
        }
    }

    function updateQuantity(productId, element, price) {
        const quantity = parseInt(element.value) || 1;
        const stock = parseInt(document.getElementById('stock_' + productId).value);
        const warning = document.getElementById('warning_' + productId);

        // Validação de stock
        if (quantity > stock) {
            warning.textContent = `(Stock máximo: ${stock})`;
            element.value = stock;
            return;
        } else {
            warning.textContent = '';
        }

        // Atualiza o subtotal imediatamente (feedback visual)
        const subtotalElement = document.getElementById('subtotal_' + productId);
        subtotalElement.textContent = (price * quantity).toFixed(2) + '€';

        // Envia a atualização para o servidor
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/UpdateCartServlet';

        const inputId = document.createElement('input');
        inputId.type = 'hidden';
        inputId.name = 'productItemId';
        inputId.value = productId;

        const inputQty = document.createElement('input');
        inputQty.type = 'hidden';
        inputQty.name = 'quantity';
        inputQty.value = quantity;

        form.appendChild(inputId);
        form.appendChild(inputQty);
        document.body.appendChild(form);
        form.submit();
    }

    function removeItem(productId) {
        productIdToRemove = productId;

        // Create confirmation dialog
        const confirmDialog = document.createElement('div');
        confirmDialog.className = 'confirm-dialog';
        confirmDialog.innerHTML = `
        <div class="confirm-dialog-content" style="background-color: #D1D1D1;">
            <h3>Remove Item</h3>
            <p>Are you sure you want to remove this item from your cart?</p>
            <div class="confirm-dialog-buttons">
                <button onclick="confirmRemove()">Yes</button>
                <button onclick="cancelRemove()">No</button>
            </div>
        </div>
    `;
        document.body.appendChild(confirmDialog);
    }

    function confirmRemove() {
        // Remove the dialog
        const dialog = document.querySelector('.confirm-dialog');
        if (dialog) dialog.remove();

        if (!productIdToRemove) return;

        // Create and submit form
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/RemoveFromCartServlet';

        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'productItemId';
        input.value = productIdToRemove;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();

        productIdToRemove = null;
    }

    function cancelRemove() {
        // Remove the dialog
        const dialog = document.querySelector('.confirm-dialog');
        if (dialog) dialog.remove();
        productIdToRemove = null;
    }

    function updateShippingMethod(shippingMethodId) {
        fetch('${pageContext.request.contextPath}/UpdateShippingMethodServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'shippingMethodId=' + encodeURIComponent(shippingMethodId)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.reload();
                } else {
                    console.error('Failed to update shipping method:', data.error);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
</script>
</body>
</html>