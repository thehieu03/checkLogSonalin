<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách sản phẩm</title>
        <link rel="stylesheet" href="../css/home.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100..900&family=Nunito:wght@200..1000&family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="admincss/list.css"> 
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

            .add-product-btn {
                padding: 10px;
                border-radius: 5px;
                background-color: #28a745;
                color: white;
            }

            .add-product-btn:hover {
                background-color: #218838;
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

        <div style="margin-top: 30px; background-color: white; padding: 20px;" class="container">
            <h1>DANH SÁCH SẢN PHẨM</h1>
            <div class="button-container" style="text-align: right; margin-bottom: 20px;">
                <a style="text-decoration: none;" href="${pageContext.request.contextPath}/AddProduct" class="add-product-btn">Add Product</a>
            </div>
            <form action="${pageContext.request.contextPath}/LoadDataProduct" method="GET">
                <label class="label" for="searchName">Tìm kiếm:</label>
                <input class="searchname" type="text" id="searchName" name="searchName" value="${requestScope.searchName}" placeholder="Nhập tên sản phẩm...">
                <label class="label" for="category">Danh mục:</label>
                <select name="category" id="category">
                    <option value="">Tất cả</option>
                    <option value="1" ${requestScope.category == '1' ? 'selected' : ''}>Gear</option>
                    <option value="2" ${requestScope.category == '2' ? 'selected' : ''}>Phụ kiện</option>
                    <option value="3" ${requestScope.category == '3' ? 'selected' : ''}>Đồ chơi</option>
                    <option value="4" ${requestScope.category == '4' ? 'selected' : ''}>Chăm sóc da</option>
                    <option value="5" ${requestScope.category == '5' ? 'selected' : ''}>Quần áo</option>
                    <option value="6" ${requestScope.category == '6' ? 'selected' : ''}>Thiết bị</option>
                </select>
                <label class="label" for="item">Loại hàng:</label>
                <select name="item" id="item">
                    <option value="">Tất cả</option>
                    <option value="1" ${product.itemID == 1 ? 'selected' : ''}>Gear</option>
                    <option value="2" ${product.itemID == 2 ? 'selected' : ''}>Quần áo</option>
                    <option value="3" ${product.itemID == 3 ? 'selected' : ''}>Phụ kiện</option>
                </select>
                <label class="label" for="stock">Số lượng tồn kho:</label>
                <select name="stock" id="stock">
                    <option value="">Tất cả</option>
                    <option value="0-10" ${requestScope.stock == '0-10' ? 'selected' : ''}>0 - 10</option>
                    <option value="10-50" ${requestScope.stock == '10-50' ? 'selected' : ''}>10 - 50</option>
                    <option value="50-100" ${requestScope.stock == '50-100' ? 'selected' : ''}>50 - 100</option>
                    <option value="100+" ${requestScope.stock == '100+' ? 'selected' : ''}>>= 100</option>
                </select>
                <button type="submit">Lọc</button>
            </form>
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá tiền</th>
                        <th>Hình ảnh</th>
                        <th>Mô tả</th>
                        <th>Danh mục</th>
                        <th>Loại hàng</th>
                        <th>Giảm giá (%)</th>
                        <th>Số lượng</th>
                        <th>Chỉnh sửa</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${sessionScope.products}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${product.productName}</td>
                            <td>${product.price}</td>
                            <td><img src="${product.imageURL}" alt="Hình ảnh" class="product-img"></td>
                            <td class="description-cell">${product.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.cateID == 1}">Gear</c:when>
                                    <c:when test="${product.cateID == 2}">Phụ kiện</c:when>
                                    <c:when test="${product.cateID == 3}">Đồ chơi</c:when>
                                    <c:when test="${product.cateID == 4}">Chăm sóc da</c:when>
                                    <c:when test="${product.cateID == 5}">Quần áo</c:when>
                                    <c:when test="${product.cateID == 6}">Thiết bị</c:when>
                                    <c:otherwise>Không xác định</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.itemID == 4}">Gear</c:when>
                                    <c:when test="${product.itemID == 5}">Quần áo</c:when>
                                    <c:when test="${product.itemID == 6}">Phụ kiện</c:when>
                                    <c:otherwise>Không xác định</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${product.discount}%</td>
                            <td>${product.stock}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/EditProduct?productID=${product.productID}" class="edit-btn">Sửa</a>
                                <div class="distance"></div>
                                <a href="${pageContext.request.contextPath}/DeleteProduct?productID=${product.productID}" class="delete-btn" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?');">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <c:forEach begin="${1}" end="${sessionScope.numpage}" var="i">
                    <a class="${i==sessionScope.page?"active":""}" href="${pageContext.request.contextPath}/LoadDataProduct?page=${i}
                       <c:if test="${not empty sessionScope.searchName}">&searchName=${sessionScope.searchName}</c:if>
                       <c:if test="${not empty sessionScope.category}">&category=${sessionScope.category}</c:if>
                       <c:if test="${not empty sessionScope.item}">&item=${sessionScope.item}</c:if>
                       <c:if test="${not empty sessionScope.stock}">&stock=${sessionScope.stock}</c:if>
                       ">${i}</a>
                </c:forEach>
            </div>
        </div>
        <jsp:include page="../footer.jsp" />
    </body>
</html>