document.addEventListener('DOMContentLoaded', function() {
    // Get all order cards
    const orderCards = document.querySelectorAll('.order-card');

    orderCards.forEach(card => {
        card.addEventListener('click', function() {
            const orderId = this.getAttribute('data-order-id');
            const orderItems = this.querySelector('.order-items');

            // Toggle expanded state
            if (this.classList.contains('expanded')) {
                // Collapse
                this.classList.remove('expanded');
                orderItems.style.display = 'none';
            } else {
                // Expand
                this.classList.add('expanded');

                // Check if order items are already loaded
                if (orderItems.innerHTML.trim() === '') {
                    // Load order items via AJAX
                    loadOrderDetails(orderId, orderItems);
                } else {
                    // Just show the already loaded content
                    orderItems.style.display = 'block';
                }
            }
        });
    });
});

function loadOrderDetails(orderId, orderItemsContainer) {
    // Show loading state
    orderItemsContainer.innerHTML = `
        <div class="loading">
            <div class="loading-spinner"></div>
            <p>Loading order details...</p>
        </div>
    `;
    orderItemsContainer.style.display = 'block';

    // Make AJAX request to get order details
    fetch(`${contextPath}/OrderDetailsServlet?orderId=${orderId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to load order details');
            }
            return response.json();
        })
        .then(data => {
            // Build the order items HTML
            let itemsHtml = '<h4>Order Items:</h4>';

            if (data.orderItems && data.orderItems.length > 0) {
                data.orderItems.forEach(item => {
                    // Parse variations
                    let variationsHtml = '';
                    if (item.variationPairs) {
                        const variations = item.variationPairs.split(',');
                        variations.forEach(variation => {
                            const [key, value] = variation.split(':');
                            if (key && value) {
                                variationsHtml += `<p><strong>${key}:</strong> ${value}</p>`;
                            }
                        });
                    }

                    itemsHtml += `
                        <div class="order-item">
                            <img src="${contextPath}${item.productImage}" alt="${item.productName}" onerror="this.src='${contextPath}/img/placeholder.jpg'">
                            <div class="item-details">
                                <h5>${item.productName}</h5>
                                ${variationsHtml}
                            </div>
                            <div class="item-price">
                                <div class="price">€${item.productPrice.toFixed(2)}</div>
                                <div class="quantity">Qty: ${item.quantity}</div>
                                <div class="subtotal">Subtotal: €${item.subtotal.toFixed(2)}</div>
                            </div>
                        </div>
                    `;
                });

                // Add order summary
                itemsHtml += `
                    <div class="order-total-summary">
                        <hr style="margin: 20px 0;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background-color: #fff;">
                            <div style="background-color: #fff;">
                                <p><strong>Shipping Method:</strong> ${data.shippingMethod}</p>
                                <p><strong>Shipping Address:</strong> ${data.shippingAddress}</p>
                                <p><strong>Order Status:</strong> <span class="status-badge status-${data.orderStatus.toLowerCase()}">${data.orderStatus}</span></p>
                            </div>
                            <div style="text-align: right; background-color: #fff;">
                                <p style="font-size: 18px; font-weight: bold; background-color: #fff;">Total: €${data.orderTotal.toFixed(2)}</p>
                            </div>
                        </div>
                    </div>
                `;
            } else {
                itemsHtml += '<p>No items found for this order.</p>';
            }

            orderItemsContainer.innerHTML = itemsHtml;
        })
        .catch(error => {
            console.error('Error loading order details:', error);
            orderItemsContainer.innerHTML = `
                <div class="error-message">
                    <p>Failed to load order details. Please try again.</p>
                </div>
            `;
        });
}

// Utility function to format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('pt-PT', {
        style: 'currency',
        currency: 'EUR'
    }).format(amount);
}

// Utility function to format date
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('pt-PT', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
}