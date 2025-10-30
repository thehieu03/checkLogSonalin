<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header style="padding: 5px 0;">
    <div style="width: 100%; margin: 0 auto;" class="container">
        <div style="width: 100%; display: flex; justify-content: space-between;" class="header-top">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/HomeProduct"><img src="css/images/2.png" alt="Logo Website"></a>
            </div>
            <nav class="top-nav right-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/HomeProduct">Trang Chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/ListProduct">Sản Phẩm</a></li>
                    <li><a href="cartpage.jsp"><i class="fas fa-shopping-bag"></i></a></li>
                    <li><a href="userpage.jsp"><i class="far fa-user"></i></a></li>
                    <li><a href="${pageContext.request.contextPath}/signout">Đăng xuất</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>