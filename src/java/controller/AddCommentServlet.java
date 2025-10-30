package controller;

import dal.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Comment;
import java.io.IOException;

public class AddCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accID = (String) session.getAttribute("accID");
        
        if (accID == null) {
            session.setAttribute("alert", "Bạn cần đăng nhập");
            response.sendRedirect("signin.jsp");
            return;
        }
        
        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            String commentText = request.getParameter("commentText");
            int rating = Integer.parseInt(request.getParameter("rating"));

            Comment newComment = new Comment();
            newComment.setProductID(productID);
            newComment.setAccID(accID);
            newComment.setComment(commentText);
            newComment.setRating(rating);

            CommentDAO commentDAO = new CommentDAO();
            commentDAO.addComment(newComment);

            response.sendRedirect("ProductDetail?productID=" + productID);
        } catch (NumberFormatException e) {
            response.getWriter().println("Lỗi: Dữ liệu không hợp lệ.");
        }
    }
}
