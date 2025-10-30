package controller.sign;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class ForgotPassS extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDAO dac = new AccountDAO();
        String user = request.getParameter("accID");
        String pass = request.getParameter("password");
        String pass2 = request.getParameter("password2");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        Account ac = dac.getAc(user);
        if (ac != null) {
            if (ac.getEmail().equals(email)
                    && ac.getPhone().equals(phone)) {
                if (pass.equals(pass2)) {
                    boolean isUpdated = dac.changePassword(user, pass);
                    if (isUpdated) {
                        session.setAttribute("errorfp", null);
                        session.setAttribute("message", "Đổi mật khẩu thành công!");
                        response.sendRedirect("signin.jsp");
                    } else {
                        session.setAttribute("errorfp", "Lỗi khi cập nhật mật khẩu.");
                        response.sendRedirect("forgotpass.jsp");
                    }
                } else {
                    session.setAttribute("errorfp", "Mật khẩu nhập lại không khớp.");
                    response.sendRedirect("forgotpass.jsp");
                }
            } else {
                session.setAttribute("errorfp", "Email hoặc số điện thoại không khớp.");
                response.sendRedirect("forgotpass.jsp");
            }
        } else {
            session.setAttribute("errorfp", "Tài khoản không tồn tại.");
            response.sendRedirect("forgotpass.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
