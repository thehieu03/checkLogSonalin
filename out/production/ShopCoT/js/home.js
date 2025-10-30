document.addEventListener('DOMContentLoaded', function () {
    const productSlider = document.querySelector('.products-slider');
    const sliderPrevBtn = document.querySelector('.slider-prev');
    const sliderNextBtn = document.querySelector('.slider-next');
    if (sliderPrevBtn && sliderNextBtn && productSlider) {
        sliderNextBtn.addEventListener('click', () => {
            productSlider.scrollLeft += productSlider.offsetWidth;
        });
        sliderPrevBtn.addEventListener('click', () => {
            productSlider.scrollLeft -= productSlider.offsetWidth;
        });
    }
});