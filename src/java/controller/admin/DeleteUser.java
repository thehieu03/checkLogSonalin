package controller.admin;

import dal.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Account;

public class DeleteUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Account loggedInUser = (Account) session.getAttribute("acc");

        if (loggedInUser == null || loggedInUser.getRole() != 0) {
            response.sendRedirect("home");
            return;
        }

        String accID = request.getParameter("accIDdel");

        if (accID == null || accID.isEmpty()) {
            request.setAttribute("errorMessage", "Không tìm thấy ID người dùng.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        AccountDAO accountDAO = new AccountDAO();
        boolean success = accountDAO.deleteAccount(accID);

        if (success) {
            session.removeAttribute("users");
            response.sendRedirect("LoadDataUser");
        } else {
            request.setAttribute("errorMessage", "Xóa người dùng thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
