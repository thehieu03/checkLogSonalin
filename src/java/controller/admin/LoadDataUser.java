package controller.admin;

import dal.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Account;

public class LoadDataUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Account loggedInUser = (Account) session.getAttribute("acc");

        if (loggedInUser == null || loggedInUser.getRole() != 0) {
            response.sendRedirect("home");
            return;
        }

        String searchName = request.getParameter("searchName");
        String roleParam = request.getParameter("role");
        Integer role = null;
        if (roleParam != null && !roleParam.isEmpty()) {
            try {
                role = Integer.parseInt(roleParam);
            } catch (NumberFormatException e) {
                role = null;
            }
        }

        AccountDAO accountDAO = new AccountDAO();
        List<Account> users;

        if ((searchName == null || searchName.isEmpty()) && role == null) {
            users = accountDAO.getAllAccounts();
        } else {
            users = accountDAO.getAccountsByFilter(searchName, role);
        }

        session.setAttribute("users", users);
        response.sendRedirect("adminpage/listuser.jsp");
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

    @Override
    public String getServletInfo() {
        return "Servlet to load user data for the admin user list page.";
    }
}
