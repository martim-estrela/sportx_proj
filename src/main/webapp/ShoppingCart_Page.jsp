<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <tr>
                                <td>
                                    <div class="imgStyle">
                                        <img src="${not empty item.imageUrl ?
                                              pageContext.request.contextPath.concat(item.imageUrl) :
                                              pageContext.request.contextPath.concat('/img/default-product.jpg')}"
                                             alt="${item.productName}">
                                    </div>
                                </td>
                                <td class="product_info">
                                        ${item.productName}<br>
                                        ${item.color}<br>
                                        ${item.size}
                                </td>
                                <td>
                                    <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="€"/>
                                </td>
                                <td>
                                    <div class="quantity-controls">
                                        <button type="button" onclick="decrementQuantity('${item.productItemId}', '${item.price}')">-</button>
                                        <input type="number"
                                               value="${item.quantity}"
                                               min="1"
                                               id="quantity_${item.productItemId}"
                                               onchange="updateQuantity('${item.productItemId}', this, '${item.price}')">
                                        <button type="button" onclick="incrementQuantity('${item.productItemId}', '${item.price}')">+</button>
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
                                           onchange="updateShippingCost(${method.price})"
                                        ${method.shippingId == sessionScope.selectedShippingMethod.shippingId ? 'checked' : ''}>
                                    <label for="shipping_${method.shippingId}">
                                        <span class="shipping-name">${method.name}</span>
                                        <span class="shipping-price">€${method.price}</span>
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
    <script>
        // Variável global para armazenar o ID do produto a ser removido
        let productIdToRemove = null;

        function updateQuantity(productId, element, price) {
            const quantity = parseInt(element.value) || 1;
            if (quantity < 1) {
                element.value = 1;
                return;
            }

            // Cria e submete um formulário "invisível"
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/UpdateCartServlet';

            const inputId = document.createElement('input');
            inputId.type = 'hidden';
            inputId.name = 'productId';
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

        function incrementQuantity(productId, price) {
            const input = document.getElementById('quantity_' + productId);
            if (!input) return;

            const currentValue = parseInt(input.value) || 0;
            input.value = currentValue + 1;
            updateQuantity(productId, input, price);
        }

        function decrementQuantity(productId, price) {
            const input = document.getElementById('quantity_' + productId);
            if (!input) return;

            const currentValue = parseInt(input.value) || 2;
            if (currentValue > 1) {
                input.value = currentValue - 1;
                updateQuantity(productId, input, price);
            }
        }

        function removeItem(productId) {
            // Armazena o ID do produto para uso posterior
            productIdToRemove = productId;

            // Cria o diálogo de confirmação
            const confirmDialog = document.createElement('div');
            confirmDialog.className = 'confirm-dialog';
            confirmDialog.innerHTML = `
                <div class="confirm-dialog-content">
                    <h3>Remove Item</h3>
                    <p>Are you sure you want to remove this item?</p>
                    <div class="confirm-dialog-buttons">
                        <button onclick="confirmRemove()">Yes</button>
                        <button onclick="cancelRemove()">No</button>
                    </div>
                </div>
            `;
            document.body.appendChild(confirmDialog);
        }

        function confirmRemove() {
            // Remove o diálogo de confirmação
            const dialog = document.querySelector('.confirm-dialog');
            if (dialog) {
                dialog.remove();
            }

            // Verifica se temos um ID válido
            if (productIdToRemove === null) {
                console.error('No product ID to remove');
                return;
            }

            console.log('Removing product:', productIdToRemove);

            // Cria e submete o formulário
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/RemoveFromCartServlet';

            const inputId = document.createElement('input');
            inputId.type = 'hidden';
            inputId.name = 'productId';
            inputId.value = productIdToRemove;

            form.appendChild(inputId);
            document.body.appendChild(form);
            form.submit();

            // Limpa o ID armazenado
            productIdToRemove = null;
        }

        function cancelRemove() {
            // Remove o diálogo de confirmação
            const dialog = document.querySelector('.confirm-dialog');
            if (dialog) {
                dialog.remove();
            }

            // Limpa o ID armazenado
            productIdToRemove = null;
        }

        function updateShippingCost(shippingPrice) {
            // Atualizar o preço do envio
            const shippingCostElement = document.getElementById('shipping-cost');
            shippingCostElement.textContent = '€' + shippingPrice.toFixed(2);

            // Calcular e atualizar o total
            const subtotal = ${sessionScope.cartTotal};
            const total = subtotal + shippingPrice;

            const cartTotalElement = document.getElementById('cart-total');
            cartTotalElement.innerHTML = '<strong style="background-color: #D9D9D9;">€' + total.toFixed(2) + '</strong>';

            // Enviar a seleção para o servidor
            updateShippingMethod(shippingPrice);
        }

        function updateShippingMethod(shippingMethodId) {
            fetch('${pageContext.request.contextPath}/UpdateShippingMethodServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'shippingMethodId=' + shippingMethodId
            })
                .then(response => response.json())
                .then(data => {
                    if (!data.success) {
                        console.error('Failed to update shipping method');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    </script>
</body>

</html>