document.addEventListener("DOMContentLoaded", function () {
    document.body.classList.add("loaded");
    const links = document.querySelectorAll("a.signup, a.register-btn");
    links.forEach(link => {
        link.addEventListener("click", function (event) {
            event.preventDefault();
            let destination = this.href;

            // Thêm hiệu ứng trước khi rời trang
            document.body.style.transition = "opacity 0.5s ease, transform 0.5s ease";
            document.body.style.opacity = "0";
            document.body.style.transform = "translateY(-20px)";

            setTimeout(() => {
                window.location.href = destination;
            }, 500);
        });
    });
});

