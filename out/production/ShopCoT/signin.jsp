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
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/signin.css">
        <script src="js/signscript.js"></script>
        <script>
            function getCookie(name) {
                const value = `; ${document.cookie}`;
                const parts = value.split(`; ${name}=`);
                if (parts.length === 2)
                    return parts.pop().split(';').shift();
            }

            window.onload = function () {
                if (getCookie("user")) {
                    document.querySelector("input[name='checklogin']").checked = true;
                }
            }
        </script>
    </head>
    <body>
        <div class="login-container container">
            <div class="form-section">
                <h1>ĐĂNG NHẬP</h1>
                <form action="signin" method="post" class="form-part">
                    <% String redirect = request.getParameter("redirect") != null ? request.getParameter("redirect") : ""; %>
                    <input type="hidden" name="redirect" value="<%= redirect %>">

                    <input type="text" name="accID" placeholder="Tên tài khoản" required>
                    <input type="password" name="password" placeholder="Mật khẩu" required>
                    <label style="display: inline-flex; align-items: center; cursor: pointer;">
                        <input type="checkbox" name="checklogin" value="rem" style="margin-right: 5px;">
                        <small>Ghi nhớ tôi</small>
                    </label>
                    <div class="options">
                        <!-- <div><input type="checkbox"> Remember for 30 days</div> -->
                        <a href="forgotpass.jsp" class="forgot">Quên mật khẩu?</a>
                    </div>
                    <button type="submit" class="login-btnn">ĐĂNG NHẬP</button>
                </form>
                <c:if test="${sessionScope.errorsi != null}">
                    <p style="color: red; margin-bottom: 0px; margin-top: 1rem;">${sessionScope.errorsi}</p>
                </c:if>
                <p>Chưa có tài khoản? <a href="signup.jsp" class="signup register-btn">Đăng Ký</a></p>
            </div>
            <div class="image-section">
                <img src="css/images/1.png">
            </div>
        </div>
        <c:if test="${not empty sessionScope.alert}">
            <script>
                alert("${sessionScope.alert}");
            </script>
        </c:if>
    </body>
</html>
