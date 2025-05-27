// CheckoutValidation.js
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('checkoutForm');
    const cardFields = document.getElementById('card-fields');
    const paypalFields = document.getElementById('paypal-fields');

    // Toggle payment fields based on selected payment method
    window.togglePaymentFields = function() {
        const selectedPayment = document.querySelector('input[name="payment-method"]:checked').value;

        if (selectedPayment === '1' || selectedPayment === '3') { // Credit Card or Debit Card
            cardFields.style.display = 'block';
            paypalFields.style.display = 'none';

            // Set required attributes for card fields
            document.getElementById('cardholder-name').required = true;
            document.getElementById('card-number').required = true;
            document.getElementById('exp-date').required = true;
            document.getElementById('cvc').required = true;

            // Remove required from PayPal fields
            document.getElementById('paypal-email').required = false;
        } else if (selectedPayment === '2') { // PayPal
            cardFields.style.display = 'none';
            paypalFields.style.display = 'block';

            // Remove required from card fields
            document.getElementById('cardholder-name').required = false;
            document.getElementById('card-number').required = false;
            document.getElementById('exp-date').required = false;
            document.getElementById('cvc').required = false;

            // Set required for PayPal fields
            document.getElementById('paypal-email').required = true;
        }
    };

    // Initialize payment fields on page load
    togglePaymentFields();

    // Format card number input
    document.getElementById('card-number').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
        let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
        e.target.value = formattedValue;
    });

    // Format expiry date input
    document.getElementById('exp-date').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length >= 2) {
            value = value.substring(0, 2) + '/' + value.substring(2, 4);
        }
        e.target.value = value;
    });

    // Format CVC input (numbers only)
    document.getElementById('cvc').addEventListener('input', function(e) {
        e.target.value = e.target.value.replace(/[^0-9]/g, '');
    });

    // Validate form on submit
    form.addEventListener('submit', function(e) {
        if (!validateForm()) {
            e.preventDefault();
        }
    });

    function validateForm() {
        let isValid = true;
        const selectedPayment = document.querySelector('input[name="payment-method"]:checked').value;

        // Clear previous errors
        clearErrors();

        // Validate required fields
        const requiredFields = form.querySelectorAll('input[required]');
        requiredFields.forEach(field => {
            if (!field.value.trim()) {
                showError(field, 'This field is required');
                isValid = false;
            }
        });

        // Validate email format
        const emailField = document.getElementById('email');
        if (emailField.value && !isValidEmail(emailField.value)) {
            showError(emailField, 'Please enter a valid email address');
            isValid = false;
        }

        // Validate PayPal email if PayPal is selected
        const paypalEmailField = document.getElementById('paypal-email');
        if (selectedPayment === '2' && paypalEmailField.value && !isValidEmail(paypalEmailField.value)) {
            showError(paypalEmailField, 'Please enter a valid PayPal email address');
            isValid = false;
        }

        // Validate card fields if card payment is selected
        if (selectedPayment === '1' || selectedPayment === '3') {
            const cardNumber = document.getElementById('card-number').value.replace(/\s/g, '');
            const expDate = document.getElementById('exp-date').value;
            const cvc = document.getElementById('cvc').value;

            // Validate card number (basic validation)
            if (cardNumber && (cardNumber.length < 13 || cardNumber.length > 19)) {
                showError(document.getElementById('card-number'), 'Please enter a valid card number');
                isValid = false;
            }

            // Validate expiry date
            if (expDate && !isValidExpiryDate(expDate)) {
                showError(document.getElementById('exp-date'), 'Please enter a valid expiry date (MM/YY)');
                isValid = false;
            }

            // Validate CVC
            if (cvc && (cvc.length < 3 || cvc.length > 4)) {
                showError(document.getElementById('cvc'), 'Please enter a valid CVC (3-4 digits)');
                isValid = false;
            }
        }

        return isValid;
    }

    function isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    function isValidExpiryDate(expDate) {
        const regex = /^(0[1-9]|1[0-2])\/\d{2}$/;
        if (!regex.test(expDate)) return false;

        const [month, year] = expDate.split('/');
        const currentDate = new Date();
        const currentYear = currentDate.getFullYear() % 100;
        const currentMonth = currentDate.getMonth() + 1;

        const expYear = parseInt(year);
        const expMonth = parseInt(month);

        if (expYear < currentYear) return false;
        if (expYear === currentYear && expMonth < currentMonth) return false;

        return true;
    }

    function showError(field, message) {
        field.classList.add('input-error');

        // Remove existing error message
        const existingError = field.parentNode.querySelector('.error-message');
        if (existingError) {
            existingError.remove();
        }

        // Add new error message
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.textContent = message;
        field.parentNode.appendChild(errorDiv);
    }

    function clearErrors() {
        // Remove error classes
        document.querySelectorAll('.input-error').forEach(field => {
            field.classList.remove('input-error');
        });

        // Remove error messages
        document.querySelectorAll('.error-message').forEach(error => {
            error.remove();
        });
    }
});