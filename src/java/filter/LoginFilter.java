package filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class LoginFilter implements Filter {

    private static final Set<String> ADMIN_PAGES = new HashSet<>(Arrays.asList(
            "/LoadDataCate", "/LoadDataProduct", "/EditProduct", "/AddProduct", "/DeleteProduct", "/adminorders", "/updatestatus",
            "/LoadDataUser", "/DeleteUser",
            "/adminpage/addproduct.jsp", "/adminpage/adminhome.jsp", "/adminpage/adminorders.jsp",
            "/adminpage/editproduct.jsp", "/adminpage/listproduct.jsp", "/adminpage/listuser.jsp"
    ));

    private static final Set<String> LOGIN_REQUIRED = new HashSet<>(Arrays.asList(
            "/AddCommentServlet", "/RemoveCartItemServlet", "/AddToCartServlet", "/UpdateCartServlet", "/OrderServlet", "/ProcessOrderServlet",
            "/ListOrderServlet", "/orderDetail", "/cancelorder", "/signout", "/updateUser", "/confirmreceived",
            "/cartpage.jsp", "/checkout.jsp", "/edituser.jsp", "/listorder.jsp", "/orderdetail.jsp", "/userpage.jsp"
    ));

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI().substring(req.getContextPath().length());
        Account user = (session != null) ? (Account) session.getAttribute("acc") : null;

        Boolean isAdminObj = (session != null) ? (Boolean) session.getAttribute("isAdmin") : null;
        boolean isAdmin = (isAdminObj != null) && isAdminObj;

        if (ADMIN_PAGES.contains(uri)) {
            if (user == null || !isAdmin) {
                res.getWriter().println("<script>alert('You must be admin'); history.back();</script>");
                return;
            }
        }

        if (LOGIN_REQUIRED.contains(uri)) {
            if (user == null) {
                if (session == null) {
                    session = req.getSession(true);
                }
                session.setAttribute("alert", "You must login");
                res.sendRedirect(req.getContextPath() + "/signin.jsp");
                return;
            }

        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
