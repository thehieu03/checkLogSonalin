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

public class SignupServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDAO dac = new AccountDAO();
        String accID = request.getParameter("accID");
        String pass = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (dac.isAccountExist(accID, email, phone)) {
            session.setAttribute("errorsu", "Tài khoản, email hoặc số điện thoại đã tồn tại!");
            response.sendRedirect("signup.jsp");
            return;
        }

        Account ac = new Account(accID, email, pass, name, 1, phone);
        dac.addAccount(ac);
        session.setAttribute("errorsu", null);
        session.setAttribute("success", "Đăng ký thành công! Hãy đăng nhập.");
        response.sendRedirect("signin.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
