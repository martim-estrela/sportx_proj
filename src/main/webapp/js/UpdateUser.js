document.addEventListener("DOMContentLoaded", function() {
    // Elementos do modal de edição
    const editModal = document.getElementById("editUserModal");
    const editCloseButton = document.querySelector(".edit-user-close");
    const cancelEditButton = document.getElementById("cancelEditUser");
    const editForm = document.getElementById("editUserForm");

    // Selecionar todos os botões de edição
    const editButtons = document.querySelectorAll(".btn-edit.edit-user");


    // Adicionar evento a cada botão de edição


// Adicionar evento a cada botão de edição
    editButtons.forEach(button => {
        button.addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation();

            // Obter o ID do botão clicado
            const userId = this.getAttribute('data-userid');
            document.getElementById("editUserId").value = userId;

            const userRow = this.closest(".row1");

            // Preencher o formulário
            document.getElementById("editName").value = userRow.querySelector(".user-name").textContent;
            document.getElementById("editEmail").value = userRow.querySelector(".user-email").textContent;
            document.getElementById("editPassword").value = "";

            const phoneElement = userRow.querySelector(".user-phone");
            document.getElementById("editPhoneNumber").value = phoneElement ? phoneElement.textContent : "";

            document.getElementById("editUserType").value = userRow.querySelector(".user-type").textContent.toLowerCase();
            document.getElementById("editStatus").value = userRow.querySelector(".user-status").textContent.toLowerCase();

            editModal.style.display = "block";
        });
    });

// Processar submissão
    if (editForm) {
        editForm.addEventListener("submit", function(e) {
            e.preventDefault();

            const requiredInputs = editForm.querySelectorAll('input[required], select[required]');
            let formValido = true;
            let mensagensErro = [];

            requiredInputs.forEach(function(input) {
                if (input.value.trim() === '') {
                    formValido = false;
                    mensagensErro.push(`O campo ${input.name || input.id} é obrigatório.`);
                    input.classList.add('edit-user-input-error');
                } else {
                    input.classList.remove('edit-user-input-error');
                }
            });

            const password = document.getElementById("editPassword");
            if (password && password.value.trim() !== '' && password.value.length < 8) {
                formValido = false;
                mensagensErro.push('A senha deve ter no mínimo 8 caracteres.');
                password.classList.add('edit-user-input-error');
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

            const errorDiv = document.getElementById('edit-form-errors');
            if (errorDiv) {
                errorDiv.innerHTML = '';
            }

            // Recolher os dados e adicionar manualmente o ID
            const formData = new FormData(editForm);
            const data = new URLSearchParams();

            for (const [key, value] of formData.entries()) {
                data.append(key, value);
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
                        editModal.style.display = "none";
                        location.reload();
                    } else {
                        return response.text().then(msg => {
                            throw new Error(msg);
                        });
                    }
                })
                .catch(error => {
                    alert("Erro ao atualizar usuário: " + error.message);
                });
        });
    }
});