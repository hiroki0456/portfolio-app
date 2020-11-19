window.addEventListener('load', () => {
    if (!document.querySelector('.btn')) return false
    document.querySelector('#question_question').addEventListener('input', function() {
        document.querySelector('.answer').innerHTML = this.value.length;
    });
});