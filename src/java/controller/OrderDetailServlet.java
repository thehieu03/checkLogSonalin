package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.Account;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/orderDetail"})
public class OrderDetailServlet extends HttpServlet {

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
            response.sendRedirect("listorder.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        Order order = orderDAO.getOrderById(orderId);
        if (order == null) {
            session.setAttribute("alertMessage", "Đơn hàng không tồn tại!");
            response.sendRedirect("listorder.jsp");
            return;
        }

        if (account.getRole() != 0 && !order.getAccID().equals(account.getAccID())) {
            session.setAttribute("alertMessage", "Bạn không có quyền xem đơn hàng này!");
            response.sendRedirect("listorder.jsp"); // Chuyển hướng về trang danh sách đơn hàng của user
            return;
        }

        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(orderId);

        ProductDAO productDAO = new ProductDAO();
        for (OrderDetail detail : orderDetails) {
            Product product = productDAO.getProductByID(detail.getProductID());
            detail.setProduct(product);
        }

        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("orderdetail.jsp").forward(request, response);
    }
}
