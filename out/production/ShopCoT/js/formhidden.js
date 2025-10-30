document.addEventListener('DOMContentLoaded', function() {
    const searchIconTrigger = document.getElementById('search-icon-trigger');
    const searchBox = document.getElementById('search-box');
    if (searchIconTrigger && searchBox) {
        searchIconTrigger.addEventListener('click', function(event) {
            event.preventDefault(); 
            searchBox.classList.toggle('hidden'); 
        });
    }
});