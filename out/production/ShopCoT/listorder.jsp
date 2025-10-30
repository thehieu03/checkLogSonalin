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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách đơn hàng</title>
        <link rel="stylesheet" href="css/home.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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
            .cancel-button {
                background-color: #f44336;
                color: white;
                padding: 5px 10px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                text-decoration: none;
                display: inline-block;
            }
            .cancel-button:hover {
                background-color: #da190b;
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
            .message {
                color: red;
                font-style: italic;
            }
            .confirm-received-button {
                background-color: #4CAF50;
                color: white;
                padding: 5px 10px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                text-decoration: none;
                display: inline-block;
            }

            .confirm-received-button:hover {
                background-color: #367c39;
            }
            .view-ingredients{
                background-color: #2175b1;
                color: white;
                padding: 5px 10px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                text-decoration: none;
                display: inline-block;
            }
            .view-ingredients:hover{
                background-color: #014576;
            }
            .btn-secondary{
                background-color: #e15b42;
                color: white;
                padding: 5px 10px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                text-decoration: none;
                display: inline-block;
            }

            .btn-secondary:hover{
                background-color: #f58a78;
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
        <div style="margin-top: 20px;" class="container">
            <h2 style="margin-bottom: 20px;" class = "order-detail-heading">Danh sách đơn hàng của bạn</h2>
            <c:choose>
                <c:when test="${empty orders}">
                    <p>Bạn chưa có đơn hàng nào.</p>
                </c:when>
                <c:otherwise>
                    <table class="cart-table"> 
                        <thead>
                            <tr>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Địa chỉ</th>
                                <th>Người nhận</th>
                                <th>Số điện thoại</th>
                                <th>Xem chi tiết</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td>${order.orderDate}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencyCode="VND"/></td>
                                    <td class="status status-${order.status.toLowerCase()}">${order.status}</td>
                                    <td>${order.address}</td>
                                    <td>${order.receiverName}</td>
                                    <td>${order.receiverPhone}</td>
                                    <td style="text-align: center;">
                                        <a href="orderDetail?orderID=${order.orderID}" class = "view-ingredients">Xem</a>
                                    </td>
                                    <td style="text-align: center;">
                                        <c:if test="${order.status == 'pending'}">
                                            <a href="${pageContext.request.contextPath}/cancelorder?orderID=${order.orderID}" class="btn btn-secondary" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">Hủy đơn</a>
                                        </c:if>
                                        <c:if test="${order.status == 'shipped'}">
                                            <a href="${pageContext.request.contextPath}/confirmreceived?orderID=${order.orderID}" class="confirm-received-button" onclick="return confirm('Bạn xác nhận đã nhận được đơn hàng này?')">Đã nhận</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>

            <a href="${pageContext.request.contextPath}/ListProduct" class="btn view-ingredients" style="margin: 30px auto; display: block; width: fit-content;" >Tiếp tục mua sắm</a> <%-- Added consistent button styling --%>
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