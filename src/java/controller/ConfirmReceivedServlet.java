package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Account;

@WebServlet(name = "ConfirmReceivedServlet", urlPatterns = {"/confirmreceived"})
public class ConfirmReceivedServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");

        String orderIdStr = request.getParameter("orderID");
        int orderId;
        try {
            orderId = Integer.parseInt(orderIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("alertMessage", "Mã đơn hàng không hợp lệ!");
            response.sendRedirect("ListOrderServlet");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        boolean success = orderDAO.updateOrderStatus(orderId, "delivered");

        if (success) {
            session.setAttribute("alertMessage", "✅ Xác nhận đã nhận hàng thành công!");
        } else {
            session.setAttribute("alertMessage", "❌ Xác nhận không thành công, vui lòng thử lại!");
        }
        response.sendRedirect("ListOrderServlet");
    }
}
