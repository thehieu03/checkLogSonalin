package controller;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;

public class UpdateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accID = request.getParameter("accID");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        AccountDAO accountDAO = new AccountDAO();

        Account oldAccount = accountDAO.getAc(accID);
        if (accountDAO.isAccountExist(accID, email, phone) && (!email.equals(oldAccount.getEmail()) || !phone.equals(oldAccount.getPhone()))) {
            request.setAttribute("errorMessage", "Email hoặc số điện thoại đã tồn tại.");
            request.setAttribute("account", oldAccount);
            request.getRequestDispatcher("edituser.jsp").forward(request, response);
            return;
        }

        Account updatedAccount = new Account(accID, email, oldAccount.getPassword(), name, oldAccount.getRole(), phone);
        boolean success = accountDAO.updateAccount(updatedAccount);

        if (success) {
            request.setAttribute("updateMessage", "Cập nhật thông tin thành công!");
            request.setAttribute("account", updatedAccount);
            request.getRequestDispatcher("edituser.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Cập nhật thông tin thất bại. Vui lòng thử lại.");
            request.setAttribute("account", oldAccount);
            request.getRequestDispatcher("edituser.jsp").forward(request, response);
        }
    }
}
