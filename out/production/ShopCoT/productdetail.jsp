<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Product" %>
<%@ page import="dal.CommentDAO" %>
<%@ page import="dal.CategoryDAO" %>
<%@ page import="model.Comment" %>
<%@ page import="model.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="dal.ProductDAO" %> 
<%
    Product product = (Product) session.getAttribute("product");
    if (product == null) {
        response.getWriter().println("Không tìm thấy sản phẩm!");
        return;
    }
    int cateID = product.getCateID();
    CommentDAO commentDAO = new CommentDAO();
    List<Comment> comments = commentDAO.getCommentsByProductID(product.getProductID());
    request.setAttribute("comments", comments);

    CategoryDAO categoryDAO = new CategoryDAO();
    Category category = categoryDAO.getCateByID(cateID);

    ProductDAO productDAO = new ProductDAO();
    List<Product> similarProducts = productDAO.getSimilarProducts(product.getCateID(), product.getItemID(), product.getProductID(), 4); // Thêm productID để loại trừ sản phẩm hiện tại
    request.setAttribute("similarProducts", similarProducts);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><c:out value="${product.getProductName()}" /></title>
        <link rel="stylesheet" href="css/home.css">
        <link rel="stylesheet" href="css/product.css">
        <link rel="stylesheet" href="css/productdetail.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.acc}">
                <jsp:include page="userheader.jsp" />
            </c:when>
            <c:otherwise>
                <jsp:include page="guestheader.jsp" />
            </c:otherwise>
        </c:choose>
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/HomeProduct">Trang chủ</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/ListProduct">Sản phẩm</a>
            <span>/</span>
            <span class="pr-name">${product.getProductName()}</span>
        </div>

        <div class="product-page2">
            <div class="product-page">
                <div class="product-card" data-base-price="<c:out value="${product.getPrice()}"/>" data-discount="<c:out value="${product.getDiscount()}"/>">
                    <div class="product-image">
                        <img src="<c:out value="${product.getImageURL()}"/>" alt="<c:out value="${product.getProductName()}"/>">
                    </div>
                    <div class="product-info">
                        <div class="product-header">
                            <h1 class="product-name"><c:out value="${product.getProductName()}"/></h1>
                        </div>
                        <div class="price-rating">
                            <p class="ppprice">
                                <c:if test="${product.getDiscount() > 0}">
                                    <del style="color: red; font-size: 0.8em; margin-right: 5px;"><c:out value="${product.getPrice()}đ"/></del>
                                </c:if>
                                <span class="discounted-price"></span>
                            </p>
                            <div class="rating">
                                <c:set var="rating" value="${product.getRating()}" />
<c:set var="fullStars" value="${rating - (rating % 1)}" />
<c:set var="hasHalfStar" value="${(rating % 1) >= 0.5}" />
<c:set var="emptyStars" value="${5 - fullStars - (hasHalfStar ? 1 : 0)}" />


<c:forEach var="i" begin="1" end="${fullStars}">
    <i class="fas fa-star"></i>
</c:forEach>

<c:if test="${hasHalfStar}">
    <i class="fas fa-star-half-alt"></i>
</c:if>

<c:forEach var="i" begin="1" end="${emptyStars}">
    <i class="far fa-star"></i>
</c:forEach>

                              
                            </div>
                        </div>
                        <div class="order-section">
                            <div class="color-quantity">
                                <div class="total-price">
                                    <p class="section-title">TỔNG GIÁ TIỀN</p>
                                    <p class="total-amount">0.00đ</p>
                                </div>
                            </div>
                            <p id="stock-error" style="color: red; display: none;">
                                Số lượng hàng chỉ còn <span id="stock-amount">${product.getStock()}</span> sản phẩm!
                            </p>
                            <div class="order-actions">
                                <div class="order-actions">
                                    <form class="order-actions" action="AddToCartServlet" method="get" onsubmit="return validateStock(event)">
                                        <input type="hidden" name="productID" value="${product.getProductID()}">
                                        <div class="quantity-control">
                                            <button type="button" class="qty-btn minus">-</button>
                                            <input type="number" name="quantity" id="quantity" class="qty-input" value="1" min="1">
                                            <button type="button" class="qty-btn plus">+</button>
                                        </div>
                                        <div class="add-to-cart">
                                            <button type="submit" class="btn btn-primary">THÊM VÀO GIỎ HÀNG</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="margin-top: 30px;" class="destitle"><h3>MÔ TẢ SẢN PHẨM</h3></div>
            <div class="tab-content active" id="description">
                <p><c:out value="${product.getDescription()}"/><a href="#"></a></p>
            </div>

            <div class="product-comments">
                <div class="destitle"><h3>BÌNH LUẬN SẢN PHẨM</h3></div>
                <ul class="comment-list">
                    <c:forEach var="comment" items="${comments}">
                        <li class="comment-item">
                            <div class="comment-header">
                                <span class="comment-author"><c:out value="${comment.getAccID()}"/></span>

                                <div class="comment-rating">
                                    <c:forEach begin="1" end="${comment.getRating()}">
                                        <i class="fas fa-star"></i>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="comment-header">
                                <span class="comment-date"><c:out value="${comment.getDate()}"/></span>
                            </div>
                            <div class="comment-body">
                                <p><c:out value="${comment.getComment()}"/></p>
                            </div>
                        </li>
                    </c:forEach>
                </ul>

                <div class="comment-form">
                    <div class="destitle"><h3>THÊM BÌNH LUẬN</h3></div>
                    <form action="AddCommentServlet" method="post"> <%-- Tạo Servlet AddCommentServlet để xử lý --%>
                        <input type="hidden" name="productID" value="${product.getProductID()}"> <%-- Truyền productID --%>
                        <div class="form-group">
                            <label for="commentText">Bình luận của bạn:</label>
                            <textarea id="commentText" name="commentText" rows="4" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="rating">Đánh giá:</label>
                            <select id="rating" name="rating">
                                <option value="5">5 Sao</option>
                                <option value="4">4 Sao</option>
                                <option value="3">3 Sao</option>
                                <option value="2">2 Sao</option>
                                <option value="1">1 Sao</option>
                            </select>
                        </div>
                        <button style="margin: 15px auto; width: 200px;" type="submit" class="btn btn-primary">GỬI BÌNH LUẬN</button>
                    </form>
                </div>
            </div>
        </div>

        <div style="width:100%;" class="similar-products">
            <div class="destitle"><h3>SẢN PHẨM TƯƠNG TỰ</h3></div>
            <div class="product-list"> <%-- Sử dụng class product-list đã có hoặc tạo class mới --%>
                <c:forEach var="similarProduct" items="${similarProducts}">
                    <div class="product-item">
                        <a style="text-decoration: none;" href="${pageContext.request.contextPath}/ProductDetail?productID=${similarProduct.getProductID()}">
                            <div class="smproduct-image">
                                <img src="${similarProduct.getImageURL()}" alt="${similarProduct.getProductName()}">
                            </div>
                            <div class="product-info">
                                <h4 class="product-name">${similarProduct.getProductName()}</h4>
                                <p class="price">
                                    <c:if test="${similarProduct.getDiscount() > 0}">
                                        <del style="color: red; font-size: 0.8em; margin-right: 5px;">${similarProduct.getPrice()}đ</del>
                                    </c:if>
                                    ${similarProduct.getPrice() * (1 - similarProduct.getDiscount()/100)}đ
                                </p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
        <jsp:include page="footer.jsp" />

        <script src="js/detail.js"></script>
        <script src="js/formhidden.js"></script>
        <script>
            function validateStock(event) {
                var stock = ${product.getStock()};
                var quantity = document.getElementById("quantity").value;
                var stockError = document.getElementById("stock-error");

                if (quantity > stock) {
                    stockError.style.display = "block";
                    stockError.innerHTML = "Số lượng hàng chỉ còn " + stock + " sản phẩm!";
                    event.preventDefault();
                    return false;
                } else {
                    stockError.style.display = "none";
                    return true;
                }
            }
        </script>
    </body>
</html>