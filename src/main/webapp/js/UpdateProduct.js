document.addEventListener("DOMContentLoaded", function() {
    const editModal = document.getElementById("editProductModal");
    const editCloseButton = document.querySelector(".edit-close");
    const cancelEditButton = document.getElementById("cancelEditProduct");
    const editForm = document.getElementById("editProductForm");

    // Certificar-se de que os botões de edição estão disponíveis no DOM
    const editButtons = document.querySelectorAll(".btn-edit.edit-product");

    // Adicionar evento a cada botão de edição
    editButtons.forEach(button => {
        button.addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation();

            // Obter o ID do botão clicado
            const productId = this.getAttribute('data-productid');

            if (!productId) {
                console.error("Produto ID não encontrado.");
                return;
            }

            // Preencher o ID no formulário de edição
            document.getElementById("editProductId").value = productId;

            const productRow = this.closest(".row1");

            if (productRow) {
                // Preencher os campos do formulário com os dados do produto
                const stock = productRow.querySelector(".product-stock").textContent;
                const price = productRow.querySelector(".product-price").textContent;

                if (stock && price) {
                    document.getElementById("editStock").value = stock;
                    document.getElementById("editPrice").value = price;
                }

                // Mostrar o modal
                editModal.style.display = "flex";
            } else {
                console.error("Linha do produto não encontrada.");
            }
        });
    });

    // Fechar o modal (X)
    if (editCloseButton) {
        editCloseButton.onclick = function() {
            editModal.style.display = "none";
        };
    }

    // Fechar o modal (Cancel)
    if (cancelEditButton) {
        cancelEditButton.onclick = function() {
            editModal.style.display = "none";
        };
    }

    // Fechar o modal ao clicar fora
    window.addEventListener("click", function(event) {
        if (event.target === editModal) {
            editModal.style.display = "none";
        }
    });

    // Processar submissão
    if (editForm) {
        editForm.addEventListener("submit", async function(e) {
            e.preventDefault();

            let formValido = true;
            let mensagensErro = [];

            // Validação de campos
            if (!document.getElementById("editStock").value || !document.getElementById("editPrice").value) {
                mensagensErro.push("Preencha todos os campos.");
                formValido = false;
            }

            if (!formValido) {
                let errorDiv = document.getElementById('edit-form-errors');
                if (!errorDiv) {
                    errorDiv = document.createElement('div');
                    errorDiv.id = 'edit-form-errors';
                    errorDiv.className = 'edit-user-error-message';
                    editForm.prepend(errorDiv);
                }

                errorDiv.innerHTML = mensagensErro.map(msg => `<p>${msg}</p>`).join('');
                return;
            }

            const formData = new FormData(editForm);
            const data = new URLSearchParams();
            for (const [key, value] of formData.entries()) {
                data.append(key, value);
            }

            try {
                const response = await fetch(`${contextPath}/manageStock`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: data
                });

                if (response.ok) {
                    editModal.style.display = "none";
                    location.reload(); // Recarrega a página após atualização
                } else {
                    const msg = await response.text();
                    throw new Error(msg);
                }
            } catch (error) {
                alert("Erro ao atualizar produto: " + error.message);
            }
        });
    }
});
