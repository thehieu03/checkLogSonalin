<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String accID = (String) session.getAttribute("accID");
    if (accID == null) {
        response.sendRedirect("signin.jsp"); 
        return; 
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> <%-- Thêm viewport --%>
        <title>Chi tiết đơn hàng</title>
        <link rel="stylesheet" href="css/home.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .status {
                font-weight: bold;
            }
            .status-pending {
                color: orange;
            }
            .status-confirmed {
                color: blue;
            }
            .status-shipped {
                color: green;
            }
            .status-delivered {
                color: black;
            }
            .status-cancelled {
                color: red;
            }
            .order-info p{
                margin-top: 15px;
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
        <div style="margin-top: 20px;" class="container"> <%-- Thêm container để nội dung được căn giữa --%>
            <h2 class="order-detail-heading">Chi tiết đơn hàng</h2>

            <div class="order-info">
                <p><strong>Ngày đặt:</strong> ${order.orderDate}</p>
                <p><strong>Trạng thái:</strong> <span class="status status-${order.status}">${order.status}</span></p>
                <p><strong>Người nhận:</strong> ${order.receiverName}</p>
                <p><strong>Địa chỉ:</strong> ${order.address}</p>
                <p><strong>Số điện thoại:</strong> ${order.receiverPhone}</p>
            </div>

            <h3 style="margin-top: 20px; margin-bottom: 10px;" class = "order-detail-heading">Sản phẩm</h3>
            <table class="cart-table"> <%-- Sử dụng class cart-table từ file cart.jsp --%>
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Hình ảnh</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderDetails}" var="detail">
                        <tr>
                            <td>${detail.product.productName}</td>
                            <td><img style="width: 60px;" src="${detail.product.imageURL}" alt="${detail.product.productName}" class="cart-item-image"></td> <%-- Sử dụng class cart-item-image --%>
                            <td><fmt:formatNumber value="${detail.product.getFinalPrice()}" type="currency" currencyCode="VND"/></td>
                            <td>${detail.quantity}</td>
                            <td><fmt:formatNumber value="${detail.product.getFinalPrice() * detail.quantity}" type="currency" currencyCode="VND"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4"><strong>Tổng cộng:</strong></td>
                        <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencyCode="VND"/></td>
                    </tr>
                </tfoot>
            </table>

            <c:choose>
                <c:when test="${sessionScope.acc.role == 0}">
                    <a style="margin: 30px auto;" href="adminorders" class="btn btn-secondary">
                        Quay lại danh sách đơn hàng
                    </a>
                </c:when>
                <c:otherwise>
                    <a style="margin: 30px auto;" href="ListOrderServlet" class="btn btn-secondary">
                        Quay lại danh sách đơn hàng
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
        <jsp:include page="footer.jsp" />
        <script src="js/home.js"></script>
        <% 
      String alertMessage = (String) session.getAttribute("alertMessage");
      if (alertMessage != null) {
        %>
        <script>
            alert("<%= alertMessage %>");
        </script>
        <%
                session.removeAttribute("alertMessage"); 
            }
        %>
    </body>
</html>