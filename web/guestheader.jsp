<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header style="padding: 5px 0;">
    <div style="width: 100%; margin: 0 auto;" class="container">
        <div style="width: 100%; display: flex; justify-content: space-between;" class="header-top">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/HomeProduct"><img src="css/images/2.png" alt="Logo Website"></a>
            </div>
            <nav class="top-nav right-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/HomeProduct">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/ListProduct">Sản phẩm</a></li>
                    <li><a href="signin.jsp">Đăng nhập</a></li>
                    <li><a href="signup.jsp">Đăng ký</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>