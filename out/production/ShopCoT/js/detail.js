document.addEventListener('DOMContentLoaded', function() {
    const qtyMinusBtn = document.querySelector('.qty-btn.minus');
    const qtyPlusBtn = document.querySelector('.qty-btn.plus');
    const qtyInput = document.querySelector('.qty-input');
    const totalPriceAmount = document.querySelector('.total-amount');
    const productCard = document.querySelector('.product-card');
    
    let basePrice = parseFloat(productCard?.dataset.basePrice || 0); 
    let discount = parseFloat(productCard?.dataset.discount || 0);

    function updateTotalPrice() {
        const quantity = parseInt(qtyInput.value);
        let discountedPrice = basePrice * (1 - discount / 100);
        const totalPrice = discountedPrice * quantity;

        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
            minimumFractionDigits: 0, 
            maximumFractionDigits: 0, 
        });
        totalPriceAmount.textContent = formatter.format(totalPrice);
    }

    qtyMinusBtn.addEventListener('click', (event) => {
        event.preventDefault();
        let currentQty = parseInt(qtyInput.value);
        if (currentQty > 1) {
            qtyInput.value = currentQty - 1;
            updateTotalPrice();
        }
    });

    qtyPlusBtn.addEventListener('click', (event) => {
        event.preventDefault();
        let currentQty = parseInt(qtyInput.value);
        qtyInput.value = currentQty + 1;
        updateTotalPrice();
    });

    qtyInput.addEventListener('change', () => {
        let currentQty = parseInt(qtyInput.value);
        if (isNaN(currentQty) || currentQty < 1) {
            qtyInput.value = 1;
        }
        updateTotalPrice();
    });
     updateTotalPrice();
});

//
//document.addEventListener('DOMContentLoaded', function() {
//    // --- Quantity selector and dynamic price update ---
//    const qtyMinusBtn = document.querySelector('.qty-btn.minus');
//    const qtyPlusBtn = document.querySelector('.qty-btn.plus');
//    const qtyInput = document.querySelector('.qty-input');
//    const totalPriceAmount = document.querySelector('.total-amount');
//    const productCard = document.querySelector('.product-card'); // Get product card to access data attributes
//
//    // --- Get base price and discount from data attributes ---
//    let basePrice = parseFloat(productCard?.dataset.basePrice || 0);
//    let discount = parseFloat(productCard?.dataset.discount || 0);
//
//    function updateTotalPrice() {
//        const quantity = parseInt(qtyInput.value);
//        let discountedPrice = basePrice * (1 - discount / 100);
//        const totalPrice = discountedPrice * quantity;
//
//        totalPriceAmount.textContent = `${totalPrice.toFixed(2)}đ`;
//    }
//
//    qtyMinusBtn.addEventListener('click', (event) => {
//        event.preventDefault();
//        let currentQty = parseInt(qtyInput.value);
//        if (currentQty > 1) {
//            qtyInput.value = currentQty - 1;
//            updateTotalPrice();
//        }
//    });
//
//    qtyPlusBtn.addEventListener('click', (event) => {
//        event.preventDefault();
//        let currentQty = parseInt(qtyInput.value);
//        qtyInput.value = currentQty + 1;
//        updateTotalPrice();
//    });
//
//    qtyInput.addEventListener('change', () => {
//        let currentQty = parseInt(qtyInput.value);
//        if (isNaN(currentQty) || currentQty < 1) {
//            qtyInput.value = 1;
//        }
//        updateTotalPrice();
//    });
//
//    updateTotalPrice();
//});