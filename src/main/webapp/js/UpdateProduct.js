document.addEventListener("DOMContentLoaded", function() {
    // Elementos do modal de edição
    const editModal = document.getElementById("editProductModal");
    const editCloseButton = document.querySelector(".edit-close");
    const cancelEditButton = document.getElementById("cancelEditProduct");
    const editForm = document.getElementById("editProductForm");

    // Selecionar todos os botões de edição
    const editButtons = document.querySelectorAll(".btn-edit.edit-product");

// Adicionar evento a cada botão de edição
    editButtons.forEach(button => {
        button.addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation();

            // Obter o ID do botão clicado
            const productId = this.getAttribute('data-productid');
            document.getElementById("editProductId").value = productId;

            const productRow = this.closest(".row1");

            // Preencher o formulário
            document.getElementById("editName").value = productRow.querySelector(".product-name").textContent;
            document.getElementById("editBrand").value = productRow.querySelector(".product-brand").textContent;
            document.getElementById("editColor").value = productRow.querySelector(".product-color").textContent;
            document.getElementById("editSize").value = productRow.querySelector(".product-size").textContent;
            document.getElementById("editStock").value = productRow.querySelector(".product-stock").textContent;

            editModal.style.display = "block";
        });
    });

    // Fechar o modal (X) - Modificado para garantir funcionamento
    if (editCloseButton) {
        editCloseButton.onclick = function() {
            console.log("Botão fechar clicado");
            editModal.style.display = "none";
        };
    }

    // Fechar o modal (botão Cancelar) - Modificado para garantir funcionamento
    if (cancelEditButton) {
        cancelEditButton.onclick = function() {
            console.log("Botão cancelar clicado");
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


            // Exibir erros, se houver
            let errorDiv = document.getElementById('edit-form-errors');
            if (!formValido) {
                if (!errorDiv) {
                    errorDiv = document.createElement('div');
                    errorDiv.id = 'edit-form-errors';
                    errorDiv.className = 'edit-user-error-message';
                    editForm.prepend(errorDiv);
                }

                errorDiv.innerHTML = mensagensErro.map(msg => `<p>${msg}</p>`).join('');
                return;
            }

            if (errorDiv) {
                errorDiv.innerHTML = '';
            }

            // Recolher os dados do formulário
            const formData = new FormData(editForm);
            const data = new URLSearchParams();
            for (const [key, value] of formData.entries()) {
                data.append(key, value);
            }

            try {
                const response = await fetch(`${contextPath}/manageStock`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: data
                });

                if (response.ok) {
                    editModal.style.display = "none";
                    location.reload(); // Recarrega a página após atualização bem-sucedida
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