<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="dal.CartDAO"%>
<%@page import="model.Cart"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Product"%>
<%@page import="dal.ProductDAO"%>

<%
    String accID = (String) session.getAttribute("accID");
    if (accID == null) {
        response.sendRedirect("signin.jsp");
        return;
    }

    CartDAO cartDAO = new CartDAO();
    ProductDAO productDAO = new ProductDAO(); 
    List<Cart> selectedCartItems = new ArrayList<>();
    double totalPrice = 0;

    String[] selectedItems = request.getParameterValues("selectedItems");

    if (selectedItems != null && selectedItems.length > 0) {
        for (String cartIDStr : selectedItems) {
            try {
                int cartID = Integer.parseInt(cartIDStr);
                Cart cartItem = cartDAO.getCartByID(cartID);

                if (cartItem != null && cartItem.getAccID().equals(accID)) { 

                    Product product = productDAO.getProductByID(cartItem.getProductID());
                   if(product != null){
                        cartItem.setProduct(product); 
                        selectedCartItems.add(cartItem);
                        totalPrice += cartItem.getTotalPrice(); 
                    }
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid cartID: " + cartIDStr); 
            }
        }
    }

    System.out.println("totalPrice: " + totalPrice);
    request.setAttribute("cartItems", selectedCartItems); 
    request.setAttribute("totalPrice", totalPrice);
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán</title>
        <link rel="stylesheet" href="css/home.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #014576;
                --secondary-color: #fbdd94;
                --text-color: #333;
                --light-gray: #f8f8f8;
                --border-color: #eee;
            }

            body {
                font-family: 'Nunito', sans-serif;
                margin: 0;
                color: var(--text-color);
                background-color: var(--light-gray);
                line-height: 1.6;
            }

            h2 {
                color: var(--primary-color);
                margin-bottom: 1rem;
                text-align: center;
            }

            h3 {
                color: var(--primary-color);
                margin-top: 2rem;
                margin-bottom: 1rem;
            }

            form {
                margin-top: 20px;
                max-width: 800px;
                margin-left: auto;
                margin-right: auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            label {
                display: block;
                margin-top: 10px;
                font-weight: 600;
            }

            input[type="text"],
            textarea {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid var(--border-color);
                border-radius: 4px;
                box-sizing: border-box;
                font-family: inherit;
            }

            textarea {
                resize: vertical;
                min-height: 100px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                margin-bottom: 2rem;
            }

            th,
            td {
                border: 1px solid var(--border-color);
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: var(--light-gray);
                font-weight: 600;
            }

            p button {
                display: inline-block;
                padding: 14px 35px;
                border: none;
                border-radius: 50px;
                cursor: pointer;
                text-decoration: none;
                text-align: center;
                transition: background-color 0.3s ease;
                font-weight: 600;
                font-size: 16px;
                background-color: var(--primary-color);
                color: #fff;
                margin: 20px auto 0;
                width: 100%;
                max-width: 200px;
            }

            p button:hover {
                background-color: #003359;
            }

            .error-message {
                color: red;
                margin-top: 10px;
            }
            .link-back{
                text-decoration: none;
                color: #014576;
            }
            .link-back:hover{
                text-decoration: underline;
            }

            @media (max-width: 768px) {
                form {
                    padding: 15px;
                }

                th, td {
                    padding: 8px;
                }
                button{
                    max-width: 100%;
                }
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

        <h2 style="margin: 25px auto 0;">XÁC NHẬN ĐƠN HÀNG</h2>
        <c:if test="${empty cartItems}">
            <p>Bạn chưa chọn sản phẩm nào để thanh toán. <a href="cartpage.jsp">Quay lại giỏ hàng</a></p>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p style="color: red;">${errorMessage}</p>
        </c:if>

        <c:if test="${not empty cartItems}">
            <form action="ProcessOrderServlet" method="post">
                <label for="name">Tên người nhận:</label>
                <input type="text" id="name" name="name" value="<c:out value='${param.name}' />" required><br>

                <label for="phone">Số điện thoại:</label>
                <input type="text" id="phone" name="phone" pattern="\d{10,11}" title="Số điện thoại hợp lệ (10-11 số)" required><br>

                <label for="address">Địa chỉ giao hàng:</label>
                <textarea id="address" name="address" required><c:out value='${param.address}' /></textarea><br>

                <h3>Sản phẩm trong đơn hàng</h3>
                <table border="1">
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                    </tr>
                    <c:forEach var="cartItem" items="${cartItems}">
                        <tr>
                            <td>${cartItem.product.productName}</td>
                            <td><fmt:formatNumber value="${cartItem.product.getFinalPrice()}" type="currency" currencyCode="VND"/></td>
                            <td>${cartItem.quantity}</td>
                            <td><fmt:formatNumber value="${cartItem.getTotalPrice()}" type="currency" currencyCode="VND"/></td> <%-- Dùng getTotalPrice() --%>

                        </tr>
                    </c:forEach>
                </table>
                <p style="text-align: center;"><strong>TỔNG CỘNG: <fmt:formatNumber value="${totalPrice}" type="currency" currencyCode="VND"/></strong></p>

                <p style="width: 100%; text-align: center;"><button type="submit">XÁC NHẬN</button></p>
            </form>
        </c:if>
        <jsp:include page="footer.jsp" />
    </body>
</html>