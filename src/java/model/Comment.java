package model;

import java.sql.Timestamp;

public class Comment {
    private int commentID;
    private int productID;
    private String accID;
    private String comment;
    private Timestamp date;
    private int rating;

    public Comment() {
    }

    public Comment(int productID, String accID, String comment, int rating) {
        this.productID = productID;
        this.accID = accID;
        this.comment = comment;
        this.rating = rating;
    }

    public Comment(int commentID, int productID, String accID, String comment, Timestamp date, int rating) {
        this.commentID = commentID;
        this.productID = productID;
        this.accID = accID;
        this.comment = comment;
        this.date = date;
        this.rating = rating;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getAccID() {
        return accID;
    }

    public void setAccID(String accID) {
        this.accID = accID;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "commentID=" + commentID +
                ", productID=" + productID +
                ", accID='" + accID + '\'' +
                ", comment='" + comment + '\'' +
                ", date=" + date +
                ", rating=" + rating +
                '}';
    }
}