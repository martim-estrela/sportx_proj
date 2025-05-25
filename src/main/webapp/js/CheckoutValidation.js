document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('checkoutForm');
    const cashRadio = document.getElementById('cash-on-delivery');
    const cardRadio = document.getElementById('credit-or-debit');
    const cardFields = document.getElementById('card-fields');
    const validationModal = document.getElementById('validationModal');

    // Handle payment method change
    function toggleCardFields() {
        const isCardPayment = cardRadio.checked;
        const cardInputs = cardFields.querySelectorAll('input');

        if (isCardPayment) {
            cardFields.style.display = 'block';
            cardInputs.forEach(input => {
                input.required = true;
            });
        } else {
            cardFields.style.display = 'none';
            cardInputs.forEach(input => {
                input.required = false;
                clearError(input);
            });
        }
    }

    // Event listeners for payment method
    cashRadio.addEventListener('change', toggleCardFields);
    cardRadio.addEventListener('change', toggleCardFields);

    // Format card number input
    const cardNumberInput = document.getElementById('card-number');
    if (cardNumberInput) {
        cardNumberInput.addEventListener('input', function(e) {
            // Remove all non-digits
            let value = e.target.value.replace(/\D/g, '');

            // Add spaces every 4 digits
            value = value.replace(/(\d{4})(?=\d)/g, '$1 ');

            e.target.value = value;
        });
    }

    // Format expiry date input
    const expDateInput = document.getElementById('exp-date');
    if (expDateInput) {
        expDateInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');

            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }

            e.target.value = value;
        });
    }

    // Format CVC input (numbers only)
    const cvcInput = document.getElementById('cvc');
    if (cvcInput) {
        cvcInput.addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '');
        });
    }

    // Phone number formatting (numbers only, max 9 digits)
    const phoneInput = document.getElementById('phone-number');
    if (phoneInput) {
        phoneInput.addEventListener('input', function(e) {
            // Allow only numbers and limit to 9 digits
            e.target.value = e.target.value.replace(/[^0-9]/g, '').substring(0, 9);
        });
    }

    // Validation function - only shows errors when explicitly called
    function validateField(field, showErrors = false) {
        const value = field.value.trim();
        const fieldName = field.name || field.id;
        let isValid = true;
        let errorMessage = '';

        // Skip validation if field is not required
        if (!field.required) {
            return true;
        }

        // Basic required field validation
        if (!value) {
            isValid = false;
            errorMessage = 'This field is required';
        } else {
            // Specific field validations
            switch (fieldName) {
                case 'your-name':
                case 'cardeHolder-name':
                    if (value.length < 2) {
                        isValid = false;
                        errorMessage = 'Must be at least 2 characters';
                    }
                    break;

                case 'email':
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!emailRegex.test(value)) {
                        isValid = false;
                        errorMessage = 'Please enter a valid email address';
                    }
                    break;

                case 'phone-number':
                    const phoneRegex = /^[0-9\s\-\+\(\)]{9}$/;
                    const digitsOnly = value.replace(/[^0-9]/g, '');
                    if (digitsOnly.length !== 9) {
                        isValid = false;
                        errorMessage = 'Phone number must be exactly 9 digits';
                    }
                    break;

                case 'address':
                    if (value.length < 5) {
                        isValid = false;
                        errorMessage = 'Address must be at least 5 characters';
                    }
                    break;

                case 'postal-code':
                    const postalRegex = /^[A-Za-z0-9\s\-]{3,10}$/;
                    if (!postalRegex.test(value)) {
                        isValid = false;
                        errorMessage = 'Please enter a valid postal code';
                    }
                    break;

                case 'city':
                case 'country':
                    if (value.length < 2) {
                        isValid = false;
                        errorMessage = 'Must be at least 2 characters';
                    }
                    break;

                case 'card-number':
                    const cardRegex = /^[0-9\s]{13,19}$/;
                    if (!cardRegex.test(value)) {
                        isValid = false;
                        errorMessage = 'Please enter a valid card number';
                    }
                    break;

                case 'exp-date':
                    const expRegex = /^(0[1-9]|1[0-2])\/([0-9]{2})$/;
                    if (!expRegex.test(value)) {
                        isValid = false;
                        errorMessage = 'Please enter date in MM/YY format';
                    } else {
                        // Check if date is not in the past
                        const [month, year] = value.split('/');
                        const currentDate = new Date();
                        const currentYear = currentDate.getFullYear() % 100;
                        const currentMonth = currentDate.getMonth() + 1;

                        const expYear = parseInt(year);
                        const expMonth = parseInt(month);

                        if (expYear < currentYear || (expYear === currentYear && expMonth < currentMonth)) {
                            isValid = false;
                            errorMessage = 'Card has expired';
                        }
                    }
                    break;

                case 'cvc':
                    const cvcRegex = /^[0-9]{3,4}$/;
                    if (!cvcRegex.test(value)) {
                        isValid = false;
                        errorMessage = 'Please enter a valid CVC (3-4 digits)';
                    }
                    break;
            }
        }

        // Only show/clear errors if showErrors is true
        if (showErrors) {
            if (!isValid) {
                showError(field, errorMessage);
            } else {
                clearError(field);
            }
        }

        return isValid;
    }

    function showError(field, message) {
        field.classList.add('input-error');

        // Create error element if it doesn't exist
        let errorElement = document.getElementById(field.id + '-error');
        if (!errorElement) {
            errorElement = document.createElement('div');
            errorElement.id = field.id + '-error';
            errorElement.className = 'error-text';
            field.parentNode.appendChild(errorElement);
        }

        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }

    function clearError(field) {
        field.classList.remove('input-error');
        const errorElement = document.getElementById(field.id + '-error');
        if (errorElement) {
            errorElement.style.display = 'none';
        }
    }

    // Add event listeners to form inputs (but don't validate on load)
    const formInputs = form.querySelectorAll('input');
    formInputs.forEach(input => {
        // Only validate on blur if the field was previously marked as invalid
        input.addEventListener('blur', function() {
            if (this.classList.contains('input-error')) {
                validateField(this, true);
            }
        });

        // Clear error styling when user starts typing in an invalid field
        input.addEventListener('input', function() {
            if (this.classList.contains('input-error')) {
                clearError(this);
            }
        });
    });

    // Form submission validation
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        let isFormValid = true;

        // Clear all previous errors first
        const allInputs = form.querySelectorAll('input');
        allInputs.forEach(input => clearError(input));

        // Validate all required fields and show errors
        const requiredFields = form.querySelectorAll('input[required]');
        requiredFields.forEach(field => {
            if (!validateField(field, true)) {
                isFormValid = false;
            }
        });

        if (!isFormValid) {
            // Focus the first invalid field
            const firstInvalidField = form.querySelector('.input-error');
            if (firstInvalidField) {
                firstInvalidField.focus();
                firstInvalidField.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
            return;
        }

        // If validation passes, submit the form
        this.submit();
    });

    // Initialize payment method visibility
    toggleCardFields();
});