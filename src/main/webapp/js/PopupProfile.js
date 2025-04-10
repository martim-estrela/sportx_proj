// Seleciona os elementos necessários
const profileButton = document.getElementById('profileButton');
const popup = document.getElementById('profilePopup');
const closePopupButton = document.getElementById('closePopup');

// Função para alternar o popup entre visível e oculto
profileButton.addEventListener('click', function(event) 
{
    event.preventDefault(); // Impede o comportamento padrão da âncora (não recarrega a página)
    
    // Verifica se o popup está visível ou não
    if (popup.style.display === 'none' || popup.style.display === '') 
    {
        popup.style.display = 'block'; // Exibe o popup
    } 
    else 
    {
        popup.style.display = 'none'; // Oculta o popup
    }
});

// Fechar o popup ao clicar no botão "Close"
closePopupButton.addEventListener('click', function() 
{
    popup.style.display = 'none'; // Esconde o popup
});

// Fechar o popup se clicar fora do conteúdo do popup
window.addEventListener('click', function(event) 
{
    if (!popup.contains(event.target) && event.target !== profileButton) 
    {
        popup.style.display = 'none'; // Esconde o popup se clicado fora
    }
});