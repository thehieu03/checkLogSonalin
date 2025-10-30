<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm sản phẩm</title>
        <link rel="stylesheet" href="../css/home.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="admincss/add.css">
        <script src="adminjs/addjs.js"></script>
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
                        
        <div style="margin-top: 30px;" class="login-container container">
            <div style="width: 100%;" class="form-section">
                <h1>THÊM SẢN PHẨM</h1>
                <form action="${pageContext.request.contextPath}/AddProduct" method="post" class="form-part">
                    <input type="text" name="productName" placeholder="Tên sản phẩm" required>
                    <input type="text" name="price" placeholder="Giá tiền" required>
                    <textarea name="description" placeholder="Mô tả sản phẩm" required></textarea>
                    <select id="category" name="category" required>
                        <option value="" disabled selected hidden>Chọn danh mục</option>
                        <c:forEach var="c" items="${sessionScope.categories}">
                            <option value="${c.cateID}">${c.cateName}</option>
                        </c:forEach>
                    </select>
                    <select id="item" name="item" required>
                        <option value="" disabled selected hidden>Chọn loại hàng</option>
                        <option value="4">Gear</option>
                        <option value="5">Quần áo</option>
                        <option value="6">Phụ kiện</option>
                    </select>
                    <input type="number" name="stock" placeholder="Số lượng sản phẩm" required min="1">
                    <input type="text" name="discount" placeholder="Chọn % giảm giá" required>
                    <label for="imageurl" id="fileLabel" class="file-label">Nhập URL hình ảnh</label>
                    <input type="text" id="imageurl" name="imageurl" placeholder="Dán URL hình ảnh vào đây" required>
                    <button type="submit" class="login-btnn">XÁC NHẬN THÊM</button>
                </form>
                <c:if test="${sessionScope.errorap != null}">
                    <p style="color: red; margin-bottom: 0px; margin-top: 1rem;">${sessionScope.errorap}</p>
                </c:if>
            </div>
        </div>
        <jsp:include page="../footer.jsp" />
    </body>
</html>