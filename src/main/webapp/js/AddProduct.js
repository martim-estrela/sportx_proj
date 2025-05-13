document.addEventListener("DOMContentLoaded", function() {
    // Elementos do modal
    const modal = document.getElementById("addProductModal");
    const openModalBtn = document.getElementById("openAddProductModalBtn");
    const closeButton = document.querySelector(".product-modal-close");
    const cancelButton = document.getElementById("cancelAddProduct");
    const form = document.getElementById("addProductForm");

    // Abrir o modal
    openModalBtn.addEventListener("click", function() {
        modal.style.display = "flex";
    });

    // Fechar o modal (X)
    closeButton.addEventListener("click", function() {
        modal.style.display = "none";
    });

    // Fechar o modal (botão Cancelar)
    cancelButton.addEventListener("click", function() {
        modal.style.display = "none";
    });

    // Fechar o modal ao clicar fora
    window.addEventListener("click", function(event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });

    // Processar o formulário
    form.addEventListener("submit", function(e) {

    });
});