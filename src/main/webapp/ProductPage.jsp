<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="org.sportx.sportx.util.ProductDAO" %>
<%@ page import="org.sportx.sportx.model.Product" %>
<%@ page import="java.util.*" %>

<%
    String productIdParam = request.getParameter("productId");
    if (productIdParam == null || productIdParam.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/SearchBrowseServlet");
        return;
    }

    int productId = Integer.parseInt(productIdParam);
    ProductDAO productDAO = new ProductDAO();

    Product product = productDAO.getProductById(productId);
    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/SearchBrowseServlet");
        return;
    }

    List productItems = productDAO.getProductItemsByProductId(productId);

    List<Map<String, Object>> productItemsForJs = new ArrayList<>();
    Map<String, Set<String>> variationsMap = new LinkedHashMap<>();

    for (Object obj : productItems) {
        org.sportx.sportx.DTO.ProductItemDTO item = (org.sportx.sportx.DTO.ProductItemDTO) obj;

        Map<String, Object> map = new HashMap<>();
        map.put("id", item.getProductItemId());
        map.put("price", item.getPrice());
        map.put("discountedPrice", item.getDiscountedPrice());
        map.put("discountRate", item.getDiscountRate());
        map.put("stock", item.getQtyInStock());
        map.put("image", item.getImageUrl());
        map.put("variationPairs", item.getVariationPairs());
        productItemsForJs.add(map);

        String variationPairs = item.getVariationPairs();
        if (variationPairs != null && !variationPairs.isEmpty()) {
            String[] pairs = variationPairs.split(",");
            for (String pair : pairs) {
                String[] nv = pair.split(":", 2);
                if (nv.length == 2) {
                    variationsMap.computeIfAbsent(nv[0], k -> new LinkedHashSet<>()).add(nv[1]);
                }
            }
        }
    }

    request.setAttribute("product", product);
    request.setAttribute("similarProducts", productDAO.getSimilarProducts(productId, product.getBrand()));
    request.setAttribute("variationsMap", variationsMap);
    request.setAttribute("productItemsForJs", productItemsForJs);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>SportX | ${product.name}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_ProductPage.css" />
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
        <a href="${pageContext.request.contextPath}/ShoppingCart_Page.jsp"><img src="${pageContext.request.contextPath}/img/shopping-cart.jpg" alt="Cart"></a>
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
                <a href="${pageContext.request.contextPath}/Orderhistory.jsp">Order History</a>
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
        <input type="text" id="searchInput" placeholder="Search..." />
    </div>
</div>

<main>
    <div class="main-div">
        <div class="img-div">
            <img id="productImage" src="${pageContext.request.contextPath}${productItemsForJs[0].image}" alt="${product.name}" />
        </div>

        <div class="product-details">
            <h2>${product.name}</h2>
            <p>Description: ${product.description}</p>

            <form action="${pageContext.request.contextPath}/AddToCartServlet" method="post">
                <input type="hidden" name="productId" value="${product.id}" />
                <input type="hidden" name="productName" value="${product.name}" />
                <input type="hidden" name="productImage" value="${pageContext.request.contextPath}${productItemsForJs[0].image}" />

                <c:forEach var="variation" items="${variationsMap.keySet()}">
                    <div class="variation">
                        <label for="${variation}">${variation}:</label>
                        <select name="${variation}" id="${variation}" class="variation-select" required>
                            <option value="">Select ${variation}</option>
                            <c:forEach var="option" items="${variationsMap[variation]}">
                                <option value="${option}">${option}</option>
                            </c:forEach>
                        </select>
                    </div>
                </c:forEach>

                <p>Price: <span id="price"></span></p>
                <p>Stock: <span id="stock"></span></p>

                <input type="hidden" name="productItemId" id="productItemId" value="" />
                <div class="quantity">
                    <label for="quantity">Quantity:</label>
                    <select name="quantity" id="quantity" min="1" max="10">
                        <c:forEach begin="1" end="10" var="i">
                            <option value="${i}">${i}</option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" id="addToCartBtn" disabled>Add to Cart</button>
            </form>
        </div>
    </div>

    <div class="extra-div">
        <section class="product-section">
            <h2>More from this brand</h2>
            <div class="product-grid">
                <c:choose>
                    <c:when test="${not empty similarProducts}">
                        <c:forEach var="similar" items="${similarProducts}">
                            <a href="${pageContext.request.contextPath}/ProductPage.jsp?productId=${similar.id}" class="product-card">
                                <img src="${not empty similar.imageUrl ? pageContext.request.contextPath.concat(similar.imageUrl) : pageContext.request.contextPath.concat('/img/default-product.jpg')}" alt="${similar.name}" />
                                <p class="Top-Left-text">${similar.name}</p>
                                <p class="Top-Left-text2">
                                    <fmt:formatNumber value="${similar.price}" type="currency" currencySymbol="€" />
                                </p>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-results">
                            <p>No more products from this brand</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
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

<script>
    const contextPath = '${pageContext.request.contextPath}';

    const productItems = [
        <c:forEach var="item" items="${productItemsForJs}">
        {
            id: ${item.id},
            price: ${item.price},
            discountedPrice: ${item.discountedPrice},
            discountRate: ${item.discountRate},
            stock: ${item.stock},
            image: '${item.image}',
            variationMap: (function() {
                const map = {};
                const pairs = '${item.variationPairs}'.split(',');
                for (let p of pairs) {
                    const nv = p.split(':');
                    if (nv.length === 2) {
                        map[nv[0]] = nv[1];
                    }
                }
                return map;
            })()
        }<c:if test="${!item.equals(productItemsForJs[productItemsForJs.size()-1])}">,</c:if>
        </c:forEach>
    ];

    const selects = document.querySelectorAll('.variation-select');
    const priceSpan = document.getElementById('price');
    const stockSpan = document.getElementById('stock');
    const productImage = document.getElementById('productImage');
    const productItemIdInput = document.getElementById('productItemId');
    const addToCartBtn = document.getElementById('addToCartBtn');
    const quantitySelect = document.getElementById('quantity');

    selects.forEach(select => select.addEventListener('change', updateProductItem));

    function updateProductItem() {
        const selected = {};
        let allSelected = true;
        selects.forEach(s => {
            selected[s.name] = s.value;
            if (!s.value) allSelected = false;
        });

        const defaultImage = productItems.length > 0 ? contextPath + productItems[0].image : contextPath + '/img/default-product.jpg';

        if (!allSelected) {
            priceSpan.textContent = 'N/A';
            stockSpan.textContent = '0';
            productImage.src = defaultImage;
            productItemIdInput.value = '';
            addToCartBtn.disabled = true;
            quantitySelect.max = 1;
            quantitySelect.value = 1;
            return;
        }

        const matched = productItems.find(item => {
            for (const [key, value] of Object.entries(item.variationMap)) {
                if (selected[key] !== value) return false;
            }
            return true;
        });

        if (matched) {
            if (matched.discountRate > 0) {
                // Mostra apenas o preço com desconto e a porcentagem
                const discountedPrice = matched.discountedPrice.toLocaleString('pt-PT', {minimumFractionDigits: 2, maximumFractionDigits: 2});
                    priceSpan.innerHTML = `<span id="discountedPrice"">${discountedPrice}€ (${matched.discountRate}% OFF)</span>`;
            } else {
                // Mostra o preço normal quando não há desconto
                priceSpan.textContent = matched.price.toLocaleString('pt-PT', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + '€';
            }
            stockSpan.textContent = matched.stock;
            productItemIdInput.value = matched.id;

            if (matched.stock > 0) {
                productImage.src = contextPath + matched.image;
                addToCartBtn.disabled = false;
                quantitySelect.max = matched.stock;
                if (quantitySelect.value > matched.stock) {
                    quantitySelect.value = matched.stock;
                }
            } else {
                productImage.src = contextPath + '/img/no-stock.jpg';
                addToCartBtn.disabled = true;
                quantitySelect.max = 1;
                quantitySelect.value = 1;
            }
        }

    updateProductItem();
    }
</script>

<script src="${pageContext.request.contextPath}/js/PopupSearch.js"></script>
<script src="${pageContext.request.contextPath}/js/PopupProfile.js"></script>
</body>
</html>