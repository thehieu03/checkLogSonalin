<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop Cot - Trang chủ</title>
        <link rel="stylesheet" href="css/home.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <header>
            <div class="container">
                <div class="header-top">
                    <nav class="top-nav">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/HomeProduct">Trang chủ</a></li>
                            <li><a href="mailto:chnm10032001@gmail.com">Liên hệ</a></li>
                        </ul>
                    </nav>
                    <div class="logo">
                        <a href="${pageContext.request.contextPath}/HomeProduct"><img src="css/images/2.png" alt="Logo"></a>
                    </div>
                    <nav class="top-nav right-nav">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/ListProduct">Sản phẩm</a></li>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.acc}">
                                    <li><a href="cartpage.jsp"><i class="fas fa-shopping-bag"></i></a></li>
                                    <li><a href="userpage.jsp"><i class="far fa-user"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/signout">Đăng xuất</a></li>
                                    </c:when>
                                    <c:otherwise>
                                    <li><a href="signin.jsp">Đăng nhập</a></li>
                                    <li><a href="signup.jsp">Đăng ký</a></li>
                                    </c:otherwise>
                                </c:choose>
                        </ul>
                    </nav>
                </div>
            </div>
        </header>

        <section class="heroimagehome hero">
            <div class="container">
                <div class="hero-content">
                    <p>Shop CoT – Nơi mang đến những sản phẩm chất lượng cho bạn!</p>
                    <a href="${pageContext.request.contextPath}/ListProduct" class="btn btn-primary">Tìm kiếm thêm</a>
                </div>
            </div>
        </section>

        <section class="smooth-foam-section">
            <div class="container">
                <div class="foam-image">
                    <img src="css/images/homeimage.jpg" alt="Home Image">
                </div>
                <div class="foam-content">
                    <h2>Mục tiêu Shop CoT</h2>
                    <p>Chúng tôi cung cấp đa dạng các loại phụ kiện máy tính, quần áo và đồ chơi... giúp bạn luôn luôn có những lựa chọn tối ưu nhất. Đồng hành cùng Shop CoT, bạn sẽ dễ dàng bắt kịp xu hướng, lựa chọn thông minh và tận hưởng trải nghiệm mua sắm tiện lợi, phong cách và đầy cảm hứng.!</p>
                    <div class="foam-actions">
                        <a href="${pageContext.request.contextPath}/ListProduct" class="view-ingredients">Xem sản phẩm ></a>
                    </div>
                </div>
            </div>
        </section>

        <section class="popular-products">
            <div class="container">
                <center><h2>SẢN PHẨM MỚI</h2></center>
                <div class="products-slider">
                    <c:forEach var="p" items="${products}" varStatus="loop" begin="${fn:length(products) - 3}" end="${fn:length(products) - 1}">

                        <div class="product-card">
                            <a style="text-decoration: none;" href="ProductDetail?productID=${p.productID}" class="recipe-card-link">
                                <img src="${p.imageURL}" alt="${p.productName}">
                                <h3 style="height: 70px;">${p.productName}</h3>
                                <p class="price">
                                    <strong>
                                        <fmt:formatNumber type="currency" currencySymbol="₫" value="${p.price}" maxFractionDigits="0" />
                                    </strong>
                                </p>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <jsp:include page="footer.jsp" />
        <script src="js/home.js"></script>
    </body>
</html>