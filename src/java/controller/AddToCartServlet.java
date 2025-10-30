package controller;

import dal.CartDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Product;

public class AddToCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String accID = (String) session.getAttribute("accID");

        if (accID == null) {
            session.setAttribute("alert", "Bạn cần đăng nhập");
            response.sendRedirect("signin.jsp");
            return;
        }

        String productIDStr = request.getParameter("productID");
        String quantityStr = request.getParameter("quantity");

        if (productIDStr == null || quantityStr == null || productIDStr.isEmpty() || quantityStr.isEmpty()) {
            response.getWriter().println("Lỗi: Thiếu thông tin sản phẩm hoặc số lượng.");
            return;
        }

        try {
            int productID = Integer.parseInt(productIDStr);
            int quantity = Integer.parseInt(quantityStr);
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductByID(productID);

            if (quantity <= 0) {
                response.getWriter().println("Lỗi: Số lượng phải lớn hơn 0.");
                return;
            }

            if (quantity > product.getStock()) {
                request.setAttribute("error", "Số lượng không đủ hàng!");
                request.getRequestDispatcher("ProductDetail?productID=" + productID).forward(request, response);
                return;
            }

            CartDAO cartDAO = new CartDAO();
            cartDAO.addItemToCart(accID, productID, quantity);

            response.sendRedirect("cartpage.jsp");

        } catch (NumberFormatException e) {
            response.getWriter().println("Lỗi: ID sản phẩm hoặc số lượng không hợp lệ.");

        } catch (Exception e) {
            response.getWriter().println("Lỗi server khi thêm vào giỏ hàng.");
        }
    }
}
