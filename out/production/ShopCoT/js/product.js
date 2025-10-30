document.addEventListener('DOMContentLoaded', function () {
    const filterHeaders = document.querySelectorAll('.filter-header');
    filterHeaders.forEach(header => {
        header.addEventListener('click', function () {
            const filterGroup = this.closest('.filter-group');
            const filterOptions = filterGroup.querySelector('.filter-options');
            const icon = this.querySelector('i');
            filterOptions.classList.toggle('active');
            if (filterOptions.classList.contains('active')) {
                filterOptions.style.display = 'block';
                icon.classList.replace('fa-chevron-down', 'fa-chevron-up');
            } else {
                filterOptions.style.display = 'none';
                icon.classList.replace('fa-chevron-up', 'fa-chevron-down');
            }
        });
    });

    const allFilterOptions = document.querySelectorAll('.filter-options');
    allFilterOptions.forEach(options => {
        options.style.display = 'none';
    });
});

document.querySelectorAll('.scroll-link').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const targetId = this.getAttribute('href');
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
            window.scrollTo({
                top: targetElement.offsetTop - 50,
                behavior: 'smooth'
            });
        }
    });
});