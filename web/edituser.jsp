<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dal.AccountDAO" %>
<%@ page import="model.Account" %>

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
        <title>Chỉnh sửa thông tin cá nhân</title>
        <link rel="stylesheet" href="css/home.css"> <%-- Sử dụng CSS của bạn --%>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            .container2 {
                max-width: 800px;
                margin: 0 auto;
                padding: 40px 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            h2 {
                margin-bottom: 20px;
                text-align: center;
            }
            .form-group {
                margin-bottom: 20px;
            }

            label {
                margin-bottom: 8px;
            }

            input[type="text"],
            input[type="email"],
            input[type="tel"] {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                border: 1px solid var(--border-color);
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
            }
            button[type="submit"] {
                display: inline-block;
                padding: 14px 35px;
                border: none;
                border-radius: 50px;
                cursor: pointer;
                text-decoration: none;
                text-align: center;
                transition: background-color 0.3s ease;
                font-weight: 600;
                font-size: 16px;
                background-color: var(--primary-color);
                color: #fff;
                width: 100%;
                max-width: 300px;
                margin: 20px auto 0;
                display: block;
            }

            button[type="submit"]:hover {
                background-color: #003359;
            }

            .foam-actions{
                text-align: center;
            }
            .error-message {
                margin-top: 10px;
                text-align: center;
            }

            .success-message {
                margin-top: 10px;
                text-align: center;
            }
            .view-ingredients:hover{
                text-decoration: underline;
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

        <section>
            <div style="margin-top: 30px;" class="container2">
                <h2>CHỈNH SỬA THÔNG TIN CÁ NHÂN</h2>
                <c:if test="${not empty errorMessage}">
                    <p class="error-message">${errorMessage}</p>
                </c:if>
                <c:if test="${not empty updateMessage}">
                    <p style="color: green;">${updateMessage}</p>
                </c:if>
                <form action="updateUser" method="post"> <%-- action tới servlet xử lý --%>
                    <input type="hidden" name="accID" value="${account.accID}" /> <%-- Ẩn accID --%>
                    <div class="form-group">
                        <label for="name">Tên:</label>
                        <input type="text" id="name" name="name" value="${account.name}" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="${account.email}" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Số điện thoại:</label>
                        <input type="tel" id="phone" name="phone" value="${account.phone}" required>
                    </div>
                    <button type="submit">CẬP NHẬT</button>
                </form>
                <div style="margin-top: 30px;" class="foam-actions">
                    <a href="userpage.jsp" class="view-ingredients">< Trở về trang cá nhân</a>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp" />
    </body>
</html>