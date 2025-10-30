document.addEventListener('DOMContentLoaded', function () {
    const quantityInputs = document.querySelectorAll('.quantity-input');
    quantityInputs.forEach(input => {
        input.addEventListener('change', function () {
            const cartID = this.getAttribute('data-cart-id');
            const quantity = this.value;
            console.log("JavaScript - cartID trước khi fetch:", cartID);
            console.log("JavaScript - quantity trước khi fetch:", quantity);
            if (quantity < 1) {
                alert("Số lượng không hợp lệ!");
                this.value = 1;
                return;
            }
            fetch('UpdateCartServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `cartID=${encodeURIComponent(cartID)}&quantity=${encodeURIComponent(quantity)}`
            })
                    .then(response => response.text())
                    .then(data => {
                        console.log("Server response:", data);
                        if (data.trim() === "success") {
                            alert("Cập nhật thành công!");
                            location.reload();
                        } else {
                            alert("Cập nhật thất bại: " + data);
                        }
                    })
                    .catch(error => {
                        console.error('Lỗi khi gửi yêu cầu:', error);
                        alert("Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại!");
                    });
        });
    });
});