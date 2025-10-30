package controller.admin;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class DeleteProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            ProductDAO productDAO = new ProductDAO();
            boolean deleted = productDAO.deleteProduct(productID);

            if (deleted) {
                session.setAttribute("successMessage", "Xóa sản phẩm thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể xóa sản phẩm!");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID sản phẩm không hợp lệ!");
        }

        response.sendRedirect("LoadDataProduct");
    }
}
