/**
 * GenerateProductPDF.js
 * JavaScript to handle product PDF report generation functionality
 */

document.addEventListener('DOMContentLoaded', function() {
    // Get the generate PDF button
    const generatePdfBtn = document.getElementById('generatePdfBtn');
    const confirmPdfPopup = document.getElementById('confirmPdfPopup');
    const confirmPdfYesBtn = document.getElementById('confirmPdfYesBtn');
    const confirmPdfNoBtn = document.getElementById('confirmPdfNoBtn');

    // Add click event listener to the generate PDF button
    if (generatePdfBtn) {
        generatePdfBtn.addEventListener('click', function() {
            // Show confirmation popup
            confirmPdfPopup.style.display = 'block';
        });
    }

    // Handle confirmation "Yes" button click
    if (confirmPdfYesBtn) {
        confirmPdfYesBtn.addEventListener('click', function() {
            // Hide the confirmation popup
            confirmPdfPopup.style.display = 'none';

            // Get all filter parameters from the form
            const category = document.getElementById('category')?.value || '';
            const subCategory = document.getElementById('sub-category')?.value || '';
            const brand = document.getElementById('brand')?.value || '';
            const color = document.getElementById('color')?.value || '';
            const size = document.getElementById('size')?.value || '';
            const name = document.querySelector('input[name="name"]')?.value || '';

            // Build the URL with all the current filters
            let pdfUrl = `${contextPath}/ProductPdfGenerator?`;

            // Add all filter parameters to the URL
            if (category) pdfUrl += `category=${encodeURIComponent(category)}&`;
            if (subCategory) pdfUrl += `sub-category=${encodeURIComponent(subCategory)}&`;
            if (brand) pdfUrl += `brand=${encodeURIComponent(brand)}&`;
            if (color) pdfUrl += `color=${encodeURIComponent(color)}&`;
            if (size) pdfUrl += `size=${encodeURIComponent(size)}&`;
            if (name) pdfUrl += `name=${encodeURIComponent(name)}&`;

            // Remove trailing ampersand if present
            if (pdfUrl.endsWith('&')) {
                pdfUrl = pdfUrl.slice(0, -1);
            }

            // Open the PDF in a new window/tab (browser will handle download)
            window.open(pdfUrl, '_blank');
        });
    }

    // Handle confirmation "No" button click
    if (confirmPdfNoBtn) {
        confirmPdfNoBtn.addEventListener('click', function() {
            // Just hide the confirmation popup
            confirmPdfPopup.style.display = 'none';
        });
    }

    // Close the popup if user clicks outside of it
    window.addEventListener('click', function(event) {
        if (event.target === confirmPdfPopup) {
            confirmPdfPopup.style.display = 'none';
        }
    });
});