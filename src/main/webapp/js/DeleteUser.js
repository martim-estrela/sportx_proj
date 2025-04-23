document.addEventListener("DOMContentLoaded", function () {
    const deleteButtons = document.querySelectorAll('.delete-user');

    deleteButtons.forEach(button => {
        button.addEventListener('click', function () {
            const userId = this.getAttribute('data-userid');

            if (confirm("Tens a certeza que queres eliminar este utilizador?")) {
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
                        alert("Erro ao eliminar o utilizador: " + error.message);
                    });
            }
        });
    });
});
