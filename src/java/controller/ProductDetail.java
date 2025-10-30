package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;

import java.io.IOException;

public class ProductDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        String productID_raw = request.getParameter("productID");
        if (productID_raw == null || productID_raw.isEmpty()) {
            response.getWriter().println("Product ID is missing."); 
            return;
        }
        try {
            int productID = Integer.parseInt(productID_raw);
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductByID(productID);

            if (product == null) {
                response.getWriter().println("Product not found."); 
                return;
            }

            session.setAttribute("product", product);
            response.sendRedirect("productdetail.jsp");
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid Product ID format.");
        } catch (IOException e) {
            throw e; 
        }
    }

}