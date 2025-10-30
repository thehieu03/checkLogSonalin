<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="dal.AccountDAO"%>
<%@page import="model.Account"%>
<%
    String accID = (String) session.getAttribute("accID");
    if (accID == null) {
        response.sendRedirect("signin.jsp"); 
        return; 
    }
    AccountDAO accountDAO = new AccountDAO();
    Account account = accountDAO.getAc(accID);
    if (account == null) {
        String errorMessage = "Không tìm thấy thông tin tài khoản.";
        request.setAttribute("errorMessage", errorMessage);
    } else {
        request.setAttribute("account", account);
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang cá nhân - ${account.name}</title>
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
        <c:choose>
            <c:when test="${not empty sessionScope.acc}">
                <jsp:include page="userheader.jsp" />
            </c:when>
            <c:otherwise>
                <jsp:include page="guestheader.jsp" />
            </c:otherwise>
        </c:choose>
        <section id="profile" class="smooth-foam-section">
            <div class="container">
                <div class="foam-content">
                    <h2>Thông tin cá nhân</h2>
                    <c:if test="${not empty errorMessage}">
                        <p style="color: red;">${errorMessage}</p>
                    </c:if>
                    <c:if test="${not empty account}">
                        <p><strong>Tên khách hàng:</strong> ${account.name}</p>
                        <p><strong>Email:</strong> ${account.email}</p> 
                        <p><strong>Số điện thoại:</strong> ${account.phone}</p>
                        <div class="foam-actions">
                            <a href="${pageContext.request.contextPath}/ListOrderServlet" class="btn btn-secondary">Xem đơn hàng</a>
                            <a href="edituser.jsp" class="view-ingredients">Chỉnh sửa thông tin ></a>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp" />
        <script src="js/home.js"></script>
    </body>
</html>