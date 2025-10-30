package controller.sign;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import model.Account;

public class SigninServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        checkRememberMe(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDAO dac = new AccountDAO();
        String user = request.getParameter("accID");
        String pass = request.getParameter("password");
        String remember = request.getParameter("checklogin");

        Account ac = dac.getAc(user);
        if (ac != null && ac.getPassword().equals(pass)) {
            session.setAttribute("errorsi", null);
            session.setAttribute("isAdmin", ac.getRole() == 0);
            session.setAttribute("accID", user);
            session.setAttribute("acc", ac);
            session.setAttribute("user", ac);

            if (remember != null && remember.equals("rem")) {
                Cookie userCookie = new Cookie("user", user);
                Cookie passCookie = new Cookie("pass", pass);

                userCookie.setMaxAge(60 * 60 * 24 * 30);
                passCookie.setMaxAge(60 * 60 * 24 * 30);

                response.addCookie(userCookie);
                response.addCookie(passCookie);
            } else {
                deleteRememberMeCookies(request, response);
            }

            if (ac.getRole() == 0) {
                response.sendRedirect("adminpage/adminhome.jsp");
            } else {
                response.sendRedirect("HomeProduct");
            }

        } else {
            session.setAttribute("errorsi", "Sai tên tài khoản hoặc mật khẩu");
            response.sendRedirect("signin.jsp");
        }
    }

    private void deleteRememberMeCookies(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("user") || cookie.getName().equals("pass")) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
    }

    private void checkRememberMe(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String user = null;
        String pass = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("user")) {
                    user = cookie.getValue();
                } else if (cookie.getName().equals("pass")) {
                    pass = cookie.getValue();
                }
            }
        }

        if (user != null && pass != null) {
            AccountDAO dac = new AccountDAO();
            Account ac = dac.getAc(user);
            if (ac != null && ac.getPassword().equals(pass)) {
                HttpSession session = request.getSession();
                session.setAttribute("errorsi", null);
                session.setAttribute("isAdmin", ac.getRole() == 0);
                session.setAttribute("accID", user);
                session.setAttribute("acc", ac);
                session.setAttribute("user", ac);

                if (ac.getRole() == 0) {
                    response.sendRedirect("adminpage/adminhome.jsp");
                } else {
                    response.sendRedirect("HomeProduct");
                }
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
