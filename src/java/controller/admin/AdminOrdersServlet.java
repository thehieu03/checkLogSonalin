package controller.admin;

import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import model.Order;
import model.Account;

public class AdminOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");
        if (account == null || account.getRole() != 0) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        String sort = request.getParameter("sort");

        OrderDAO orderDAO = new OrderDAO();
        if (sort==null){
            sort="date_desc";
        } 
        List<Order> orders = orderDAO.getAllOrders(sort);
        
        int page, numperpage = 10;
        int size = orders.size();
        
        int numpage = (size % numperpage == 0 ? (size/numperpage) : ((size/numperpage)) + 1);
        String xpage = request.getParameter("page");
        if(xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        
        int start, end;
        start = (page - 1) * numperpage;
        end = Math.min(page * numperpage, size);
        
        List<Order> list = orderDAO.getListByPage(orders, start, end);
          
        session.setAttribute("page", page);
        session.setAttribute("numpage", numpage);
        
        if (list == null) {
            list = Collections.emptyList();
        }

        session.setAttribute("sort", sort); 
        session.setAttribute("orders", list);
        response.sendRedirect("adminpage/adminorders.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
