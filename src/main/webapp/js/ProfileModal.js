document.getElementById("btn_edit_profile").onclick = function () {
    document.getElementById("profileModal").style.display = "block";
};

// Fechar o modal
document.querySelector(".close").onclick = function () {
    document.getElementById("profileModal").style.display = "none";
};

// Salvar os dados (exemplo básico)
document.getElementById("btn_save_profile").onclick = function () {
    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const address = document.getElementById("address").value;
    const phone = document.getElementById("phone").value;

    console.log("Dados salvos:");
    console.log("Nome:", name);
    console.log("Email:", email);
    console.log("Endereço:", address);
    console.log("Telefone:", phone);

    // Fechar modal após salvar
    document.getElementById("profileModal").style.display = "none";
};