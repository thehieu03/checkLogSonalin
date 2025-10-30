<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <title>Quản lý đơn hàng</title>
        <link rel="stylesheet" href="../css/home.css">
        <link rel="stylesheet" href="admincss/home.css">
        <link rel="stylesheet" href="admincss/order.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            .pagination {
                text-align: center;
                margin: 20px 0;
            }

            .pagination a {
                display: inline-block;
                padding: 8px 12px;
                margin: 0 5px;
                text-decoration: none;
                color: #333;
                background-color: #f0f0f0;
                border-radius: 5px;
                border: 1px solid #ccc;
                transition: 0.3s;
            }

            .pagination a:hover {
                background-color: #014576;
                color: white;
                border-color: #014576;
            }

            .pagination a.active {
                background-color: #014576;
                color: white;
                font-weight: bold;
                border-color: #014576;
            }
            
            .update-status-form select{
                font-family: 'Nunito', sans-serif;
            }
        </style>
    </head>
    <body>
        <header style="margin: 0;">
            <div class="container">
                <div class="header-top">
                    <div class="logo">
                        <a href="${pageContext.request.contextPath}/adminpage/adminhome.jsp"><img src="../css/images/2.png" alt="Logo Website"></a>
                    </div>
                    <nav style="margin: 0;" class="top-nav right-nav">
                        <ul style="margin: 0">
                            <li><a href="${pageContext.request.contextPath}/LoadDataProduct">Sản Phẩm</a></li>
                            <li><a href="${pageContext.request.contextPath}/LoadDataUser">Người Dùng</a></li>
                            <li><a href="${pageContext.request.contextPath}/adminorders">Đơn Hàng</a></li>
                            <li><a href="${pageContext.request.contextPath}/signout">Đăng xuất</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </header>

        <div style="margin-top: 30px; padding-bottom: 30px;" class = "container2">
            <h2 class = "order-detail-heading">QUẢN LÝ ĐƠN HÀNG</h2>
            <div class="sort-options" style = "padding-bottom: 20px;">
                <label class = "label"> Sắp xếp theo:</label>
                <a class = "view-ingredients" href="${pageContext.request.contextPath}/adminorders?sort=date_asc">Ngày tăng dần</a> 
                <a class = "view-ingredients" href="${pageContext.request.contextPath}/adminorders?sort=date_desc">Ngày giảm dần</a> 
                <a class = "view-ingredients" href="${pageContext.request.contextPath}/adminorders?sort=total_asc">Tổng tiền tăng dần</a> 
                <a class = "view-ingredients" href="${pageContext.request.contextPath}/adminorders?sort=total_desc">Tổng tiền giảm dần</a>
            </div>
            <c:choose>
                <c:when test="${empty sessionScope.orders}">
                    <p>Không có đơn hàng nào.</p>
                </c:when>
                <c:otherwise>
                    <table class = "cart-table">
                        <thead>
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Khách hàng</th>
                                <th>Địa chỉ</th>
                                <th>Người nhận</th>
                                <th>Số điện thoại</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sessionScope.orders}" var="order">
                                <tr>
                                    <td>${order.orderID}</td>
                                    <td>${order.orderDate}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencyCode="VND"/></td>
                                    <td class="status status-${order.status.toLowerCase()}">${order.status}</td>
                                    <td>${order.accID}</td>
                                    <td>${order.address}</td>
                                    <td>${order.receiverName}</td>
                                    <td>${order.receiverPhone}</td>
                                    <td>
                                        <a class = "view-ingredients" href="${pageContext.request.contextPath}/orderDetail?orderID=${order.orderID}">Xem chi tiết</a>
                                        <form action="${pageContext.request.contextPath}/updatestatus" method="post" class="update-status-form">
                                            <input type="hidden" name="orderID" value="${order.orderID}">
                                            <select name="status">
                                                <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Pending</option>
                                                <option value="confirmed" ${order.status == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                                                <option value="shipped" ${order.status == 'shipped' ? 'selected' : ''}>Shipped</option>
                                                <option value="delivered" ${order.status == 'delivered' ? 'selected' : ''}>Delivered</option>
                                                <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                            </select>
                                            <button type="submit" class = "btn btn-secondary" style = "font-size: 14px; margin-bottom: 0;">Cập nhật</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
            <div class="pagination">
                <c:forEach begin="${1}" end="${sessionScope.numpage}" var="i">
                    <a class="${i==page?"active":""}" href="${pageContext.request.contextPath}/adminorders?page=${i}&sort=${sessionScope.sort}">${i}</a>
                </c:forEach>
            </div>
            <a href = "${pageContext.request.contextPath}/adminpage/adminhome.jsp" class = "btn btn-secondary" style = "display: block; margin: 20px auto; width: fit-content;">Về trang chủ</a>
        </div>
        <jsp:include page="../footer.jsp" />
    </body>
</html>
