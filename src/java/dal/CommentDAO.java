package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Comment;

public class CommentDAO extends DBContext {

    public List<Comment> getCommentsByProductID(int productID) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * FROM Comment WHERE productID = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, productID);
            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    comments.add(new Comment(
                            rs.getInt("commentID"),
                            rs.getInt("productID"),
                            rs.getString("accID"),
                            rs.getString("comment"),
                            rs.getTimestamp("date"),
                            rs.getInt("rating")
                    ));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getCommentsByProductID: " + e);
        }
        return comments;
    }

    public Comment getCommentByID(int commentID) {
        String sql = "SELECT * FROM Comment WHERE commentID = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, commentID);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return new Comment(
                            rs.getInt("commentID"),
                            rs.getInt("productID"),
                            rs.getString("accID"),
                            rs.getString("comment"),
                            rs.getTimestamp("date"),
                            rs.getInt("rating")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getCommentByID: " + e);
        }
        return null;
    }

    public void addComment(Comment comment) {
        String sql = "INSERT INTO Comment (productID, accID, comment, rating) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, comment.getProductID());
            pre.setString(2, comment.getAccID());
            pre.setString(3, comment.getComment());
            pre.setInt(4, comment.getRating());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in addComment: " + e);
        }
    }

    public boolean updateComment(Comment comment) {
        String sql = "UPDATE Comment SET productID=?, accID=?, comment=?, rating=? WHERE commentID=?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, comment.getProductID());
            pre.setString(2, comment.getAccID());
            pre.setString(3, comment.getComment());
            pre.setInt(4, comment.getRating());
            pre.setInt(5, comment.getCommentID());
            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in updateComment: " + e);
        }
        return false;
    }

    public boolean deleteComment(int commentID) {
        String sql = "DELETE FROM Comment WHERE commentID = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, commentID);
            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in deleteComment: " + e);
        }
        return false;
    }

    public static void main(String[] args) {
        CommentDAO dao = new CommentDAO();
        System.out.println("Comments for productID 1:");
        List<Comment> commentsForProduct1 = dao.getCommentsByProductID(1);
        if (commentsForProduct1.isEmpty()) {
            System.out.println("No comments found for productID 1.");
        } else {
            for (Comment c : commentsForProduct1) {
                System.out.println(c);
            }
        }
        System.out.println("\nComment with commentID 1:");
        Comment comment1 = dao.getCommentByID(1);
        if (comment1 == null) {
            System.out.println("Comment with ID 1 not found.");
        } else {
            System.out.println(comment1);
        }
    }
}
