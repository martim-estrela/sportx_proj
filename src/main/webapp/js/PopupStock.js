function openStockModal(productId, itemsJson) {
    const modal = document.getElementById("stockModal");
    const container = document.getElementById("stockInputs");
    container.innerHTML = ""; // Limpar inputs anteriores

    itemsJson.forEach(item => {
        const inputGroup = document.createElement("div");
        inputGroup.className = "input-container";

        inputGroup.innerHTML = `
            <label class="input-label">${item.color} - ${item.size}:</label>
            <input type="hidden" name="product_item_id" value="${item.productItemId}">
            <input type="number" name="stock" value="${item.qtyInStock}" class="input-field">
        `;
        container.appendChild(inputGroup);
    });

    modal.style.display = "block";
}

function closeModal() {
    document.getElementById("stockModal").style.display = "none";
}