<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="dal.CartDAO"%>
<%@page import="dal.ProductDAO"%>
<%@page import="model.Cart"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%
    String accID = (String) session.getAttribute("accID");
    if (accID == null) {
        response.sendRedirect("signin.jsp"); 
        return; 
    }
    String removeCartIDStr = request.getParameter("cartID"); 
    if (removeCartIDStr != null && !removeCartIDStr.isEmpty()) {
        if (accID != null) {
            try {
                int removeCartID = Integer.parseInt(removeCartIDStr);
                CartDAO cartDAO = new CartDAO();
                boolean removed = cartDAO.removeCartItem(removeCartID, accID);
                if (removed) {
                    request.setAttribute("removeMessage", "Sản phẩm đã được xóa khỏi giỏ hàng.");
                } else {
                    request.setAttribute("removeError", "Không thể xóa sản phẩm. Vui lòng thử lại.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("removeError", "Cart ID không hợp lệ.");
            } catch (Exception e) {
                request.setAttribute("removeError", "Lỗi server: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            request.setAttribute("removeError", "Bạn chưa đăng nhập.");
        }
    }
    List<Cart> cartItems = null;
    double totalPrice = 0;
    if (accID != null) {
        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();
        cartItems = cartDAO.getCartByAccID(accID);
        if (cartItems != null) {
            for (Cart cartItem : cartItems) {
                Product product = productDAO.getProductByID(cartItem.getProductID());
                if (product != null) {
                    cartItem.setProduct(product);
                    totalPrice += product.getFinalPrice() * cartItem.getQuantity();
                }
            }
        }
    }
    request.setAttribute("cartItems", cartItems);
    request.setAttribute("totalPrice", totalPrice);
    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
    request.setAttribute("currencyVN", currencyVN);
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale: 1.0">
        <title>Giỏ hàng của bạn</title>
        <link rel="stylesheet" href="css/home.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            .cart-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            .cart-table th, .cart-table td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            .cart-table th {
                background-color: #f2f2f2;
                text-align: center;
            }
            .cart-item-image {
                max-width: 80px;
                height: auto;
            }
            .cart-total {
                margin-top: 20px;
                text-align: right;
                font-size: 1.2em;
            }
            .quantity-input {
                width: 50px;
                padding: 5px;
                text-align: center;
            }
            .cart-actions {
                display: flex;
                justify-content: flex-end;
                gap: 20px;
                margin-top: 20px;
                text-align: right;
            }
            .cart-checkbox {
                width: 20px;
                height: 20px;
                vertical-align: middle;
            }
            .remove-item-btn {
                background: none;
                color: red;
                border: none;
                cursor: pointer;
                padding: 0;
            }
            .cart-checkbox {
                accent-color: #014576;
            }

            .btn, .btn-secondary{
                font-size: 14px;
                font-family: 'Nunito';
                padding: 14px;
                border-radius: 10px;
                height: 50px;
                align-items: center;
                align-self: center;
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.acc}">
                <jsp:include page="userheader.jsp" />
            </c:when>
            <c:otherwise>
                <jsp:include page="guestheader.jsp" />
            </c:otherwise>
        </c:choose>

        <h1 style="text-align: center; margin: 0 auto; padding-top: 20px;">Giỏ hàng của bạn</h1>
        <section style="padding: 10px;" class="smooth-foam-section">
            <div class="container">
                <c:if test="${empty cartItems}">
                    <p>Giỏ hàng của bạn hiện đang trống.</p>
                    <a href="${pageContext.request.contextPath}/ListProduct" class="view-ingredients">Tiếp tục mua sắm ></a>
                </c:if>
                <c:if test="${not empty cartItems}">
                    <form style="width: 80%; margin: 0 auto;" action="checkout.jsp" method="get" id="checkout-form">
                        <table class="cart-table">
                            <thead>
                                <tr>
                                    <th>Chọn</th>
                                    <th>Sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Tổng cộng</th>
                                    <th>Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cartItem" items="${cartItems}">
                                    <tr>
                                        <td style="text-align: center; color: #014576;">
                                            <input style="color: #014576;" type="checkbox" class="cart-checkbox" name="selectedItems" value="${cartItem.cartID}" checked>
                                        </td>
                                        <td>
                                            <div style="display: flex; align-items: center;">
                                                <img src="${cartItem.product.imageURL}" alt="${cartItem.product.productName}" class="cart-item-image">
                                                <span style="margin-left: 10px;">${cartItem.product.productName}</span>
                                            </div>
                                        </td>
                                        <td style="text-align: center;">${currencyVN.format(cartItem.product.getFinalPrice())}</td>
                                        <td style="text-align: center;">
                                            <input type="number" class="quantity-input" value="${cartItem.quantity}" min="1"
                                                   data-cart-id="${cartItem.cartID}" data-product-id="${cartItem.productID}">
                                        </td>
                                        <td style="text-align: center;" class="item-total">${currencyVN.format(cartItem.product.getFinalPrice()* cartItem.quantity)}</td>
                                        <td style="text-align: center;">
                                            <a href="${pageContext.request.contextPath}/RemoveCartItemServlet?cartID=${cartItem.cartID}" class="remove-item-btn" onclick="return confirmRemove();"> <%-- Remove Link --%>
                                                <i style="color: #014576;" class="fas fa-trash-alt"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <div style="padding-right: 60px;" class="cart-total">
                            Tổng cộng: <strong> ${currencyVN.format(totalPrice)}</strong>
                        </div>
                        <div class="cart-actions">
                            <button type="button" class="btn btn-secondary"><a style="text-decoration: none; color: #014576;" href="${pageContext.request.contextPath}/ListProduct">Tiếp tục mua sắm</a></button>
                            <button type="submit" class="btn btn-secondary" id="checkout-button">Tiếp tục thanh toán</button>
                        </div>
                    </form>
                </c:if>
            </div>
        </section>
        <jsp:include page="footer.jsp" />
        <script src="js/home.js"></script>
        <script src="js/cart.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const quantityInputs = document.querySelectorAll('.quantity-input');
                const cartTotalAmount = document.querySelector('.cart-total strong');
                const cartCheckboxes = document.querySelectorAll('.cart-checkbox');
                const checkoutButton = document.getElementById('checkout-button');
                quantityInputs.forEach(input => {
                    const cartItemRow = input.closest('tr');
                    const priceCell = cartItemRow.querySelectorAll('td')[2];
                    const itemTotalCell = cartItemRow.querySelector('.item-total');
                    const cartCheckbox = cartItemRow.querySelector('.cart-checkbox');
                    let basePriceText = priceCell.textContent.trim();
                    let basePriceValue = parseFloat(basePriceText.replace(/[^\d,-]/g, '').replace('.', '').replace(',', '.'));
                    if (isNaN(basePriceValue)) {
                        console.error("Invalid base price found in price cell:", priceCell);
                        basePriceValue = 0;
                    }
                    let basePrice = basePriceValue;
                    function updateItemTotalPrice() {
                        const quantity = parseInt(input.value);
                        if (isNaN(quantity) || quantity < 1) {
                            input.value = 1;
                            return;
                        }
                        const itemTotalPrice = basePrice * quantity;

                        const localeVN = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'});
                        itemTotalCell.textContent = localeVN.format(itemTotalPrice);
                        updateCartTotal();
                    }
                    input.addEventListener('change', updateItemTotalPrice);
                    input.addEventListener('keyup', updateItemTotalPrice);
                    cartCheckbox.addEventListener('change', function () {
                        updateCartTotal();
                    });
                    updateItemTotalPrice();
                });
                function updateCartTotal() {
                    let overallTotalPrice = 0;
                    document.querySelectorAll('tbody tr').forEach(row => {
                        const totalPriceCell = row.querySelector('.item-total');
                        const cartCheckbox = row.querySelector('.cart-checkbox');

                        if (cartCheckbox.checked) {
                            let totalPriceText = totalPriceCell.textContent.trim();
                            let totalPriceValue = parseFloat(totalPriceText.replace(/[^\d,-]/g, '').replace('.', '').replace(',', '.'));
                            if (!isNaN(totalPriceValue)) {
                                overallTotalPrice += totalPriceValue;
                            }
                        }
                    });
                    const localeVN = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'});
                    cartTotalAmount.textContent = localeVN.format(overallTotalPrice);
                }
                cartCheckboxes.forEach(checkbox => {
                    checkbox.addEventListener('change', updateCartTotal);
                });
                updateCartTotal();
                checkoutButton.addEventListener('click', function (event) {
                    event.preventDefault();
                    const selectedItems = [];
                    cartCheckboxes.forEach(checkbox => {
                        if (checkbox.checked) {
                            selectedItems.push(checkbox.value);
                        }
                    });
                    if (selectedItems.length > 0) {
                        alert("Proceeding to checkout with Cart IDs: " + selectedItems.join(', '));
                        const form = document.getElementById('checkout-form');
                        form.submit();
                    } else {
                        alert("Vui lòng chọn sản phẩm để thanh toán.");
                    }
                });
            });
            function confirmRemove() {
                return confirm("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?");
            }
        </script>
        <script src="js/cart2.js"></script>
    </body>
</html>