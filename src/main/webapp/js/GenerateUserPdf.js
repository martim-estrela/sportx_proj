document.addEventListener('DOMContentLoaded', function() {
    // Botão para gerar PDF
    const generatePdfBtn = document.getElementById('generatePdfBtn');
    const confirmPdfPopup = document.getElementById('confirmPdfPopup');
    const confirmPdfYesBtn = document.getElementById('confirmPdfYesBtn');
    const confirmPdfNoBtn = document.getElementById('confirmPdfNoBtn');

    // Mostrar popup de confirmação ao clicar no botão de gerar PDF
    if (generatePdfBtn) {
        generatePdfBtn.addEventListener('click', function() {
            confirmPdfPopup.style.display = 'block';
        });
    }

    // Fechar o popup ao clicar em "Não"
    if (confirmPdfNoBtn) {
        confirmPdfNoBtn.addEventListener('click', function() {
            confirmPdfPopup.style.display = 'none';
        });
    }

    // Gerar o PDF ao clicar em "Sim"
    if (confirmPdfYesBtn) {
        confirmPdfYesBtn.addEventListener('click', function() {
            // Obter os parâmetros de filtro atuais
            const urlParams = new URLSearchParams(window.location.search);
            const role = urlParams.get('role') || '';
            const name = urlParams.get('name') || '';

            // Construir a URL para o servlet de geração de PDF incluindo os filtros
            const pdfUrl = `${contextPath}/generateUserPdf?role=${encodeURIComponent(role)}&name=${encodeURIComponent(name)}`;

            // Fechar o popup
            confirmPdfPopup.style.display = 'none';

            // Abrir o PDF em uma nova aba
            window.open(pdfUrl, '_blank');
        });
    }
});