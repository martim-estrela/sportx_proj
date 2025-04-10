document.addEventListener('DOMContentLoaded', function() 
{
    const questions = document.querySelectorAll('.question');
    questions.forEach(question => 
    {
        question.addEventListener('click', function() 
        {
            const answer = this.nextElementSibling;
            const symbol = this.querySelector('.logo');
            if (answer.style.visibility === 'hidden' || answer.style.visibility === '') 
            {
                answer.style.visibility = 'visible';
                symbol.textContent = '-';
            } 
            else 
            {
                answer.style.visibility = 'hidden';
                symbol.textContent = '+';
            }
        });
    });
});