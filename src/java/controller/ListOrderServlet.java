package controller;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Order;
import model.Account;

public class ListOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");

        String accID = account.getAccID();
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getOrdersByAccID(accID);

        session.setAttribute("orders", orders);
        request.getRequestDispatcher("listorder.jsp").forward(request, response);
    }
}
