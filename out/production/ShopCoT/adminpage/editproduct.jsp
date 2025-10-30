<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa sản phẩm</title>
    <link rel="stylesheet" href="../css/home.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100..900&family=Nunito:wght@200..1000&family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/adminpage/admincss/add.css">
</head>
<body>
    <header style="margin: 0;">
        <div class="container">
            <div class="header-top">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/adminpage/adminhome.jsp">
                        <img src="../css/images/2.png" alt="Logo Website">
                    </a>
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

    <div style="margin-top: 30px;" class="login-container container">
        <div style="width: 100%;" class="form-section">
            <h1>CHỈNH SỬA SẢN PHẨM</h1>
            <form action="${pageContext.request.contextPath}/EditProduct" method="post" class="form-part">
                <input type="hidden" name="productID" value="${product.productID}">
                <input type="text" name="productName" value="${product.productName}" placeholder="Tên sản phẩm" required>
                <input type="text" name="price" value="${product.price}" placeholder="Giá tiền" required>
                <textarea name="description" placeholder="Mô tả sản phẩm" required>${product.description}</textarea>

                <select id="category" name="category" required>
                    <option value="" disabled hidden>Chọn danh mục</option>
                    <c:forEach var="c" items="${sessionScope.categories}">
                        <option value="${c.cateID}"
                            <c:if test="${product.cateID == c.cateID}">selected</c:if>>
                            ${c.cateName}
                        </option>
                    </c:forEach>
                </select>

                <select id="item" name="item" required>
                    <option value="" disabled hidden>Chọn loại hàng</option>
                    <option value="4" <c:if test="${product.itemID == 4}">selected</c:if>>Gear</option>
                    <option value="5" <c:if test="${product.itemID == 5}">selected</c:if>>Quần áo</option>
                    <option value="6" <c:if test="${product.itemID == 6}">selected</c:if>>Phụ kiện</option>
                </select>

                <input type="text" name="discount" value="${product.discount}" placeholder="Chọn % giảm giá" required>
                <input type="text" name="stock" value="${product.stock}" placeholder="Số lượng tồn kho" required>

                <label class="file-label">Chèn URL hình ảnh mới (nếu có)</label>
                <input type="text" name="imageurl" value="" placeholder="Nhập URL hình ảnh">
                <p>Hình ảnh hiện tại: <img src="${product.imageURL}" alt="Hình ảnh sản phẩm" width="100"></p>
                <input type="hidden" name="currentImage" value="${product.imageURL}">

                <button type="submit" class="login-btnn">CẬP NHẬT SẢN PHẨM</button>
            </form>

            <c:if test="${sessionScope.errorep != null}">
                <p style="color: red; margin-top: 1rem;">${sessionScope.errorep}</p>
                <c:remove var="errorep" scope="session"/>
            </c:if>
        </div>
    </div>

    <jsp:include page="../footer.jsp" />
</body>
</html>
