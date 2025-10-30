<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Signup Page</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/signup.css">
        <script src="js/signscript.js"></script>
    </head>
    <body>
        <div class="login-container container">
            <div class="image-section">
                <img src="css/images/1.png">
            </div>
            <div class="form-section">
                <h1>TẠO TÀI KHOẢN</h1>
                <form action="signup" method="post" class="form-part">
                    <input name="name" type="text" placeholder="Tên của bạn" required>
                    <input name="accID" type="text" placeholder="Tên tài khoản" required>
                    <input name="email" type="email" placeholder="Email" required>
                    <input name="password" type="password" placeholder="Mật khẩu" required>
                    <input name="phone" type="text" placeholder="Số điện thoại" required>
                    <button style="margin-top: 0" type="submit" class="login-btnn">ĐĂNG KÝ</button>
                </form>
                <c:if test="${sessionScope.errorsu != null}">
                    <p style="color: red; margin-bottom: 0px; margin-top: 1rem;">${sessionScope.errorsu}</p>
                </c:if>
                <p>Đã có tài khoản? <a href="signin.jsp" class="signup login-btn">Đăng Nhập</a></p>
            </div>
        </div>
    </body>
</html>
