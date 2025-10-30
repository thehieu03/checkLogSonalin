package controller.admin;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Account;

public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        if (account == null || account.getRole() != 0) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        int orderId = Integer.parseInt(request.getParameter("orderID"));
        String status = request.getParameter("status");
        if (!isValidStatus(status)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid status");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        boolean success = orderDAO.updateOrderStatus(orderId, status);

        if (success) {
            response.sendRedirect("adminorders");
        } else {
            request.setAttribute("message", "Cập nhật trạng thái không thành công.");
            response.sendRedirect("adminorders");
        }
    }

    private boolean isValidStatus(String status) {
        return status.equals("pending") || status.equals("confirmed")
                || status.equals("shipped") || status.equals("delivered")
                || status.equals("cancelled");
    }
}
