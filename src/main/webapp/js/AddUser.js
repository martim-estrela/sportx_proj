document.addEventListener("DOMContentLoaded", function() {
    // Elementos do modal
    const modal = document.getElementById("addUserModal");
    const openModalBtn = document.getElementById("openAddUserModalBtn");
    const closeButton = document.querySelector(".user-modal-close");
    const cancelButton = document.getElementById("cancelAddUser");
    const form = document.getElementById("addUserForm");

    // Abrir o modal
    openModalBtn.addEventListener("click", function() {
        modal.style.display = "block";
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
        // Se precisar de validações adicionais antes de enviar, adicione aqui
        // Por exemplo, verificar se email é válido, senha forte, etc.

        // Se quiser manipular o envio com AJAX em vez de submissão normal:
        /*
        e.preventDefault();
        const formData = new FormData(form);
        const data = new URLSearchParams();

        for (const pair of formData) {
            data.append(pair[0], pair[1]);
        }

        fetch(`${contextPath}/manageUser`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: data
        })
        .then(response => {
            if (response.ok) {
                modal.style.display = "none";
                location.reload();
            } else {
                return response.text().then(msg => {
                    throw new Error(msg);
                });
            }
        })
        .catch(error => {
            alert("Erro ao adicionar usuário: " + error.message);
        });
        */
    });
});