document.addEventListener("DOMContentLoaded", function () {
    const deleteButtons = document.querySelectorAll('.delete-user');
    const confirmDeletePopup = document.getElementById('confirmDeletePopup');
    const errorPopup = document.getElementById('errorPopup');
    const confirmYesBtn = document.getElementById('confirmYesBtn');
    const confirmNoBtn = document.getElementById('confirmNoBtn');
    const errorCloseBtn = document.getElementById('errorCloseBtn');
    const errorMessage = document.getElementById('errorMessage');

    let currentUserId = null;

    // Adicionar eventos aos botões de eliminação
    deleteButtons.forEach(button => {
        button.addEventListener('click', function () {
            currentUserId = this.getAttribute('data-userid');
            showConfirmPopup();
        });
    });

    // Mostrar popup de confirmação
    function showConfirmPopup() {
        confirmDeletePopup.style.display = 'flex';
    }

    // Esconder popup de confirmação
    function hideConfirmPopup() {
        confirmDeletePopup.style.display = 'none';
    }

    // Mostrar popup de erro
    function showErrorPopup(message) {
        errorMessage.textContent = message;
        errorPopup.style.display = 'flex';
    }

    // Esconder popup de erro
    function hideErrorPopup() {
        errorPopup.style.display = 'none';
    }

    // Eventos para os botões do popup de confirmação
    confirmYesBtn.addEventListener('click', function() {
        hideConfirmPopup();
        deleteUser(currentUserId);
    });

    confirmNoBtn.addEventListener('click', function() {
        hideConfirmPopup();
    });

    // Evento para o botão do popup de erro
    errorCloseBtn.addEventListener('click', function() {
        hideErrorPopup();
    });

    // Fechar popups ao clicar fora deles
    window.addEventListener('click', function(event) {
        if (event.target === confirmDeletePopup) {
            hideConfirmPopup();
        }
        if (event.target === errorPopup) {
            hideErrorPopup();
        }
    });

    // Função para eliminar utilizador
    function deleteUser(userId) {
        fetch(`${contextPath}/manageUser`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `action=deleteUser&userId=${encodeURIComponent(userId)}`
        })
            .then(response => {
                if (response.ok) {
                    // Reload da página para atualizar a tabela
                    location.reload();
                } else {
                    return response.text().then(msg => {
                        throw new Error(msg);
                    });
                }
            })
            .catch(error => {
                showErrorPopup("Erro ao eliminar o utilizador: " + error.message);
            });
    }
});