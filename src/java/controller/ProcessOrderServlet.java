package controller;

import dal.CartDAO;
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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Cart;
import model.Order;
import model.OrderDetail;

@WebServlet(name = "ProcessOrderServlet", urlPatterns = {"/ProcessOrderServlet"})
public class ProcessOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String accID = (String) session.getAttribute("accID");

        if (accID == null) {
            response.sendRedirect("signin.jsp");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        CartDAO cartDAO = new CartDAO();
        List<Cart> cartItems = cartDAO.getCartByAccID(accID);

        double totalPrice = 0;
        for (Cart cartItem : cartItems) {
            totalPrice += cartItem.getTotalPrice();

            System.out.println("totalPriceCart: " + cartItem.getTotalPrice());
        }

        System.out.println("totalPrice: " + totalPrice);

        Order order = new Order();
        order.setAccID(accID);
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        order.setOrderDate(now.format(formatter));
        order.setTotalPrice(totalPrice);
        order.setAddress(address);
        order.setReceiverName(name);
        order.setReceiverPhone(phone);
        order.setStatus("pending");

        OrderDAO orderDAO = new OrderDAO();
        int orderID = orderDAO.createOrder(order);

        if (orderID != -1) {
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            for (Cart cartItem : cartItems) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderID(orderID);
                orderDetail.setProductID(cartItem.getProduct().getProductID());
                orderDetail.setQuantity(cartItem.getQuantity());

                orderDetailDAO.createOrderDetail(orderDetail);
                cartDAO.reduceStock(cartItem.getProduct().getProductID(), cartItem.getQuantity());
                orderDAO.removeCartItem(cartItem.getCartID(), accID);
            }

            response.sendRedirect("ListProduct");

        } else {
            request.setAttribute("errorMessage", "Đặt hàng không thành công. Vui lòng thử lại.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
