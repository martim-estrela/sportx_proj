document.addEventListener("DOMContentLoaded", function() {
    // Elementos do modal de edição
    const editModal = document.getElementById("editUserModal");
    const editCloseButton = document.querySelector(".edit-user-close");
    const cancelEditButton = document.getElementById("cancelEditUser");
    const editForm = document.getElementById("editUserForm");

    // Selecionar todos os botões de edição
    const editButtons = document.querySelectorAll(".btn-edit");

    // Adicionar evento a cada botão de edição
    editButtons.forEach(button => {
        button.addEventListener("click", function(e) {
            // Evitar propagação do evento para não acionar outros elementos
            e.preventDefault();
            e.stopPropagation();

            // Obter o ID e outros dados do utilizador a ser editado
            const userRow = this.closest("tr"); // Encontra a linha da tabela mais próxima
            const userId = userRow.getAttribute("data-userid"); // Assumindo que cada linha tem um atributo data-userid

            // Preencher o formulário com os dados do utilizador
            document.getElementById("editUserId").value = userId;
            document.getElementById("editName").value = userRow.querySelector(".user-name").textContent;
            document.getElementById("editEmail").value = userRow.querySelector(".user-email").textContent;
            document.getElementById("editPassword").value = ""; // Senha é deixada em branco

            // Para o telefone (não obrigatório)
            const phoneElement = userRow.querySelector(".user-phone");
            document.getElementById("editPhoneNumber").value = phoneElement ? phoneElement.textContent : "";

            // Para o tipo de utilizador e status
            document.getElementById("editUserType").value = userRow.querySelector(".user-type").textContent.toLowerCase();
            document.getElementById("editStatus").value = userRow.querySelector(".user-status").textContent.toLowerCase();

            // Exibir o modal
            editModal.style.display = "block";
        });
    });

    // Fechar o modal (X)
    if (editCloseButton) {
        editCloseButton.addEventListener("click", function() {
            editModal.style.display = "none";
        });
    }

    // Fechar o modal (botão Cancelar)
    if (cancelEditButton) {
        cancelEditButton.addEventListener("click", function() {
            editModal.style.display = "none";
        });
    }

    // Fechar o modal ao clicar fora
    window.addEventListener("click", function(event) {
        if (event.target === editModal) {
            editModal.style.display = "none";
        }
    });

    // Processar o formulário de edição com validações
    if (editForm) {
        editForm.addEventListener("submit", function(e) {
            e.preventDefault(); // Impedir o envio do formulário até validar

            // Obter todos os inputs obrigatórios do formulário
            const requiredInputs = editForm.querySelectorAll('input[required], select[required]');
            let formValido = true;
            let mensagensErro = [];

            // Verificar se todos os campos obrigatórios estão preenchidos
            requiredInputs.forEach(function(input) {
                if (input.value.trim() === '') {
                    formValido = false;
                    mensagensErro.push(`O campo ${input.name || input.id} é obrigatório.`);
                    input.classList.add('edit-user-input-error');
                } else {
                    input.classList.remove('edit-user-input-error');
                }
            });

            // Verificar senha apenas se foi preenchida (para atualização)
            const password = document.getElementById("editPassword");
            if (password && password.value.trim() !== '' && password.value.length < 8) {
                formValido = false;
                mensagensErro.push('A senha deve ter no mínimo 8 caracteres.');
                password.classList.add('edit-user-input-error');
            }

            // Se houver erros, exibir mensagens e parar o envio
            if (!formValido) {
                // Criar ou atualizar elemento para exibir erros
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

            // Se não houver erros, remover mensagens de erro e continuar o processamento
            const errorDiv = document.getElementById('edit-form-errors');
            if (errorDiv) {
                errorDiv.innerHTML = '';
            }

            // Processar o envio do formulário
            const formData = new FormData(editForm);
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