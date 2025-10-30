package model;

import dal.ProductDAO;

public class Product {
    private int productID;
    private String productName;
    private double price;
    private String description;
    private int cateID;
    private int itemID;
    private String imageURL;
    private double discount;
    private int stock;
    private double rating;

    public Product() {
    }

    public Product(int productID, String productName, double price, String description, int cateID, int itemID, String imageURL, double discount, int stock) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.description = description;
        this.cateID = cateID;
        this.itemID = itemID;
        this.imageURL = imageURL;
        this.discount = discount;
        this.stock = stock;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCateID() {
        return cateID;
    }

    public void setCateID(int cateID) {
        this.cateID = cateID;
    }

    public int getItemID() {
        return itemID;
    }

    public void setItemID(int itemID) {
        this.itemID = itemID;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }
    
    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Product(int productID, String productName, double price, String description, int cateID, int itemID, String imageURL, double discount, int stock, double rating) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.description = description;
        this.cateID = cateID;
        this.itemID = itemID;
        this.imageURL = imageURL;
        this.discount = discount;
        this.stock = stock;
        this.rating = rating;
    }

    public double getRating() {
        ProductDAO dao = new ProductDAO();
        return dao.getRatingByProductID(productID);
    }

    public void setRating(double rating) {
        this.rating = rating;
    }
    
    public double getFinalPrice(){
        double pprice = price;
        if (discount > 0) {
            pprice -= price * (discount/100.0); 
        }
        return pprice;
    }
    
}
