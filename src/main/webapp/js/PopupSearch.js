// Modal, botoes
const modal = document.getElementById("searchModal");
const searchButton = document.getElementById("searchButton");
const closeBtn = document.getElementsByClassName("close")[0];

// Aparece quando é clicado
searchButton.onclick = function () 
{
    modal.style.display = "block";
}

// Fecha se clicar em sitio a volta
window.onclick = function (event) 
{
    if (event.target == modal) 
    {
        modal.style.display = "none";
    }
}