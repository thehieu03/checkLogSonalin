package controller;

import dal.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class RemoveCartItemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String accID = (String) session.getAttribute("accID");

        if (accID == null) {
            session.setAttribute("removeError", "Bạn chưa đăng nhập.");
            response.sendRedirect("cartpage.jsp");
            return;
        }

        String cartIDStr = request.getParameter("cartID"); 
        if (cartIDStr == null || cartIDStr.isEmpty()) {
            session.setAttribute("removeError", "Cart ID không hợp lệ.");
            response.sendRedirect("cartpage.jsp");
            return;
        }

        try {
            int cartID = Integer.parseInt(cartIDStr);
            CartDAO cartDAO = new CartDAO();
            boolean removed = cartDAO.removeCartItem(cartID, accID);

            if (removed) {
                session.setAttribute("removeMessage", "Sản phẩm đã được xóa khỏi giỏ hàng.");
                response.sendRedirect("cartpage.jsp");
                return;
            } else {
                session.setAttribute("removeError", "Không thể xóa sản phẩm. Vui lòng thử lại.");
                response.sendRedirect("cartpage.jsp");
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("removeError", "Cart ID không hợp lệ.");
        } catch (Exception e) {
            request.setAttribute("removeError", "Lỗi server: " + e.getMessage());
            System.out.println(e);
        }

        request.getRequestDispatcher("cartpage.jsp").forward(request, response);
    }
}