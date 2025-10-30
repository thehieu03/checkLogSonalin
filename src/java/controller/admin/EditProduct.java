package controller.admin;

import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Category;
import model.Product;

public class EditProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCates();
        session.setAttribute("categories", categories);

        int productID = Integer.parseInt(request.getParameter("productID"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductByID(productID);

        session.setAttribute("product", product);
        response.sendRedirect("adminpage/editproduct.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            System.out.println("Request URL: " + request.getRequestURI());
            System.out.println("Raw productID: " + request.getParameter("productID"));
            System.out.println("Raw price: " + request.getParameter("price"));
            System.out.println("Raw category: " + request.getParameter("category"));
            System.out.println("Raw item: " + request.getParameter("item"));
            System.out.println("Raw discount: " + request.getParameter("discount"));
            System.out.println("Raw stock: " + request.getParameter("stock"));

            int productID = Integer.parseInt(request.getParameter("productID"));
            double price = Double.parseDouble(request.getParameter("price"));
            int cateID = Integer.parseInt(request.getParameter("category"));
            int itemID = Integer.parseInt(request.getParameter("item"));
            double discount = Double.parseDouble(request.getParameter("discount"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            System.out.println("Converted productID: " + productID);
            System.out.println("Converted price: " + price);
            System.out.println("Converted category: " + cateID);
            System.out.println("Converted item: " + itemID);
            System.out.println("Converted discount: " + discount);
            System.out.println("Converted stock: " + stock);

            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String imageURL = request.getParameter("imageurl");

            if (productName == null || productName.trim().isEmpty()) {
                throw new IllegalArgumentException("Tên sản phẩm không được để trống!");
            }
            if (description == null || description.trim().isEmpty()) {
                throw new IllegalArgumentException("Mô tả không được để trống!");
            }

            if (imageURL == null || imageURL.isEmpty()) {
                imageURL = request.getParameter("currentImage");
            }

            Product updatedProduct = new Product(productID, productName, price, description, cateID, itemID, imageURL, discount, stock);
            ProductDAO productDAO = new ProductDAO();
            boolean isUpdated = productDAO.updateProduct(updatedProduct);

            if (isUpdated) {
                session.setAttribute("success", "Cập nhật sản phẩm thành công!");
                response.sendRedirect("LoadDataProduct");
            } else {
                session.setAttribute("errorep", "Cập nhật sản phẩm thất bại!");
                session.setAttribute("product", updatedProduct);
                response.sendRedirect("adminpage/editproduct.jsp");
            }
        } catch (NumberFormatException e) {
            System.err.println("Lỗi chuyển đổi số: " + e.getMessage());
            HttpSession session = request.getSession();
            session.setAttribute("errorep", "Dữ liệu không hợp lệ! Vui lòng kiểm tra lại.");
            response.sendRedirect("adminpage/editproduct.jsp");
        } catch (IllegalArgumentException e) {
            System.err.println("Lỗi dữ liệu: " + e.getMessage());
            HttpSession session = request.getSession();
            session.setAttribute("errorep", e.getMessage());
            response.sendRedirect("adminpage/editproduct.jsp");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
