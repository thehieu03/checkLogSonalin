<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="css/signup.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <script src="js/signscript.js"></script>
</head>
<body>
    <div style="width: 600px; aspect-ratio: 11/9.5;" class="login-container container">
        <div style="width: 100%;" class="form-section">
            <h1>ĐỔI MẬT KHẨU</h1>
            <form action="forgot" method="post" class="form-part">
                <input type="text" name="accID" placeholder="Tên tài khoản" required>
                <input type="email" name="email" placeholder="Email của bạn" required>
                <input type="text" name="phone" placeholder="Số điện thoại của bạn" required>
                <input type="password" name="password" placeholder="Mật khẩu mới" required>
                <input type="password" name="password2" placeholder="Nhập lại mật khẩu" required>
                <button type="submit" class="login-btnn">ĐỔI MẬT KHẨU</button>
            </form>
            <c:if test="${sessionScope.errorfp != null}">
                <p style="color: red; margin-bottom: 0px; margin-top: 1rem;">${sessionScope.errorfp}</p>
            </c:if>
            <p style="margin-bottom: 0.3rem;">Chưa có tài khoản? <a href="signup.jsp" class="signup register-btn">Đăng Ký</a></p>
            <p style="margin-top: 0px;">Đã có tài khoản? <a href="signin.jsp" class="signup login-btn">Đăng Nhập</a></p>
        </div>
    </div>
</body>
</html>
