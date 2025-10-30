<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sản Phẩm</title>
        <link rel="stylesheet" href="css/home.css">
        <link rel="stylesheet" href="css/product.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            .filter-submit {
                width: 100%;
                margin-bottom: 15px;
            }

            .filter-options select {
                width: 100%;
                padding: 10px;
                border: 1px solid #E2E8F0;
                border-radius: 5px;
                font-size: 14px;
                color: #333;
                background-color: #f8f8f8;
                cursor: pointer;
            }

            .filter-options button {
                margin-top: 10px;
                width: 100%;
                padding: 8px;
                background-color: #014576;
                color: #fff;
                border: none;
                border-radius: 5px;
                font-size: 14px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .filter-options button:hover {
                background-color: #023b63;
            }

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

        </style>
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
        <section class="recipes-section">
            <div class="container">
                <form action="ListProduct" method="GET">
                    <div id="search-box" class="search-bar">
                        <input type="text" name="searchName" value="${param.searchName}" placeholder="Nhập tên sản phẩm...">
                        <button type="submit"><i class="fas fa-search"></i></button>
                    </div>
                </form>
                <div class="recipes-grid-container">
                    <aside class="recipes-sidebar">
                        <form action="ListProduct" method="GET">
                            <div class="filter-group">
                                <div class="filter-header">Sắp xếp theo <i class="fas fa-chevron-down"></i></div>
                                <div class="filter-options">
                                    <select name="sortBy" > 
                                        <option value="">-- Chọn tiêu chí --</option>
                                        <option value="priceAsc" ${param.sortBy == 'priceAsc' ? 'selected' : ''}>Giá tăng dần</option>
                                        <option value="priceDesc" ${param.sortBy == 'priceDesc' ? 'selected' : ''}>Giá giảm dần</option>
                                        <option value="stockAsc" ${param.sortBy == 'stockAsc' ? 'selected' : ''}>Số lượng bán ra nhiều</option>
                                        <option value="ratingDesc" ${param.sortBy == 'ratingDesc' ? 'selected' : ''}>Đánh giá cao nhất</option>
                                    </select>
                                </div>
                            </div>

                            <div class="filter-group">
                                <div class="filter-header">Danh mục <i class="fas fa-chevron-down"></i></div>
                                <div class="filter-options">
                                    <ul>
                                        <li><label><input type="checkbox" name="category" value="1" ${fn:contains(paramValues.category, '1') ? 'checked' : ''}> Gear</label></li>
                                        <li><label><input type="checkbox" name="category" value="2" ${fn:contains(paramValues.category, '2') ? 'checked' : ''}> Phụ kiện</label></li>
                                        <li><label><input type="checkbox" name="category" value="3" ${fn:contains(paramValues.category, '3') ? 'checked' : ''}> Đồ chơi</label></li>
                                        <li><label><input type="checkbox" name="category" value="4" ${fn:contains(paramValues.category, '4') ? 'checked' : ''}> Chăm sóc da</label></li>
                                        <li><label><input type="checkbox" name="category" value="5" ${fn:contains(paramValues.category, '5') ? 'checked' : ''}> Balo</label></li>
                                        <li><label><input type="checkbox" name="category" value="6" ${fn:contains(paramValues.category, '6') ? 'checked' : ''}> Thiết bị</label></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="filter-group">
                                <div class="filter-header">Loại hàng <i class="fas fa-chevron-down"></i></div>
                                <div class="filter-options">
                                    <ul>
                                        <li><label><input type="checkbox" name="item" value="4" ${fn:contains(paramValues.item, '4') ? 'checked' : ''}> Gear</label></li>
                                        <li><label><input type="checkbox" name="item" value="5" ${fn:contains(paramValues.item, '5') ? 'checked' : ''}> Quần áo</label></li>
                                        <li><label><input type="checkbox" name="item" value="6" ${fn:contains(paramValues.item, '6') ? 'checked' : ''}> Phụ kiện</label></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="filter-group">
                                <div class="filter-header">Giá tiền <i class="fas fa-chevron-down"></i></div>
                                <div class="filter-options">
                                    <ul>
                                        <li><label><input type="checkbox" name="price" value="0-100000" ${fn:contains(paramValues.price, '0-100000') ? 'checked' : ''}> Dưới 100.000</label></li>
                                        <li><label><input type="checkbox" name="price" value="100000-200000" ${fn:contains(paramValues.price, '100000-200000') ? 'checked' : ''}> 100.000 - 200.000</label></li>
                                        <li><label><input type="checkbox" name="price" value="200000-500000" ${fn:contains(paramValues.price, '200000-500000') ? 'checked' : ''}> 200.000 - 500.000</label></li>
                                        <li><label><input type="checkbox" name="price" value="500000+" ${fn:contains(paramValues.price, '500000+') ? 'checked' : ''}> Trên 500.000</label></li>
                                    </ul>
                                </div>
                            </div>

                            <button class="filter-submit" type="submit">ÁP DỤNG</button>
                            <button class="filter-submit"  type="button" onclick="resetFilter()">ĐẶT LẠI</button>                       
                        </form> 
                    </aside>
                    <main id="sanpham" class="recipes-grid">
                        <c:forEach var="p" items="${products}" varStatus="loop"> 
                            <c:if test="${(empty param.searchName or fn:containsIgnoreCase(p.productName, param.searchName))}">
                                <c:if test="${p.stock > 0}">
                                    <div style="max-height: 350px;" class="recipe-card">
                                        <a style="text-decoration: none;" href="ProductDetail?productID=${p.productID}" class="recipe-card-link">
                                            <img src="${p.imageURL}" alt="${p.productName}">
                                            <h3>${p.productName}</h3>

                                            <c:if test="${p.discount > 0}">
                                                <p class="pprice">
                                                    <del style="color: red;font-size: 0.8rem;">
                                                        <fmt:formatNumber type="currency" currencySymbol="₫" value="${p.price}" maxFractionDigits="0"/>
                                                    </del>
                                                    <strong style="padding-left: 5px;">
                                                        <fmt:formatNumber type="currency" currencySymbol="₫" value="${p.getFinalPrice()}" maxFractionDigits="0"/>
                                                    </strong>
                                                </p>
                                            </c:if>
                                            <c:if test="${p.discount == 0}">
                                                <p  class="pprice">
                                                    <strong>
                                                        <fmt:formatNumber type="currency" currencySymbol="₫" value="${p.price}" maxFractionDigits="0"/>
                                                    </strong>
                                                </p>
                                            </c:if>

                                            <button class="add-to-cart-btn">Thêm vào giỏ hàng</button>
                                        </a>
                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>

                        <c:if test="${empty products}">
                            <p>Không có sản phẩm nào.</p>
                        </c:if>
                    </main>
                </div>
                <div class="pagination">
                    <c:forEach begin="1" end="${sessionScope.numpage}" var="i">
                        <a class="${i == sessionScope.page ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/ListProduct?page=${i}
                           <c:if test="${not empty sessionScope.searchName}">&searchName=${sessionScope.searchName}</c:if>
                           <c:if test="${not empty sessionScope.sortBy}">&sortBy=${sessionScope.sortBy}</c:if>
                           <c:if test="${not empty sessionScope.categoryParams}">
                               <c:forEach var="catParam" items="${sessionScope.categoryParams}">
                                   &category=${catParam}
                               </c:forEach>
                           </c:if>
                           <c:if test="${not empty sessionScope.itemParams}">
                               <c:forEach var="itemParam" items="${sessionScope.itemParams}">
                                   &item=${itemParam}
                               </c:forEach>
                           </c:if>
                           <c:if test="${not empty sessionScope.priceParams}">
                               <c:forEach var="priceParam" items="${sessionScope.priceParams}">
                                   &price=${priceParam}
                               </c:forEach>
                           </c:if>
                           ">
                            ${i}
                        </a>
                    </c:forEach>
                </div>

            </div>
        </section>

        <section class="recipe-request-section">
            <div class="container">
                <div class="request-content">
                    <h2>Không tìm thấy sản phẩm bạn muốn?</h2>
                    <p>Rất tiếc, chúng tôi chưa có sản phẩm mà bạn đang tìm kiếm. Tuy nhiên, bạn có thể thử tìm kiếm với từ khóa khác hoặc liên hệ với chúng tôi để được tư vấn. Chúng tôi luôn sẵn sàng giúp bạn tìm ra sản phẩm phù hợp nhất!</p>
                    <a href="mailto:info@yourbuddy.com" class="btn btn-primary">Mail to us</a>
                </div>
            </div>
        </section>
        <h2 style="margin: 0 auto 30px; text-align: center">SẢN PHẨM HẾT HÀNG</h2>
        <div style="width: 80%; margin: 0 auto; margin-bottom: 30px;" class="product-container recipes-grid out-of-stock"> 
            <c:forEach var="p" items="${sessionScope.outstockproducts}">
                <div class="recipe-card out-of-stock-card">
                    <a style="text-decoration: none;" href="ProductDetail?productID=${p.productID}" class="recipe-card-link">
                        <img src="${p.imageURL}" alt="${p.productName}">
                        <h3>${p.productName}</h3>
                        <p class="pprice">
                            <strong>
                                <fmt:formatNumber type="currency" currencySymbol="₫" value="${p.price}" maxFractionDigits="0"/>
                            </strong>
                        </p>
                        <p class="add-to-cart-btn out-of-stock-label">Tạm hết hàng</p>
                    </a>
                </div>
            </c:forEach>

            <c:if test="${empty sessionScope.outstockproducts}">
                <p>Không có sản phẩm nào tạm hết hàng.</p>
            </c:if>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="js/product.js"></script>
        <script>
                                function resetFilter() 
                                {
                                    window.location.href = "ListProduct"; 
                                }
        </script>
    </body>
</html>