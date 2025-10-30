package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Order;
import model.Account;

public class CancelOrder extends HttpServlet {

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
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mã đơn hàng không hợp lệ");
            return;
        }

        String accID = account.getAccID();
        OrderDAO orderDAO = new OrderDAO();
        Order order = orderDAO.getOrderById(orderId);

        if (order == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đơn hàng");
            return;
        }

        if (!order.getAccID().equals(accID)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền hủy đơn hàng này");
            return;
        }

        if (!order.getStatus().equals("pending")) {
            request.setAttribute("message", "Chỉ có thể hủy đơn hàng đang chờ xử lý.");
            request.getRequestDispatcher("listorder.jsp").forward(request, response);
            return;
        }

        boolean success = orderDAO.updateOrderStatus(orderId, "cancelled");

        if (success) {
            request.setAttribute("message", "Hủy đơn hàng thành công!");
        } else {
            request.setAttribute("message", "Có lỗi xảy ra khi hủy đơn hàng.");
        }
        response.sendRedirect("ListOrderServlet");
    }
}
