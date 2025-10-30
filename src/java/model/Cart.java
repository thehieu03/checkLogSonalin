package model;

import dal.ProductDAO;

public class Cart {
    private int cartID;
    private String accID;
    private int productID;
    private int quantity;
    private Product product; 

    public Cart() {
    }

    public Cart(int cartID, String accID, int productID, int quantity) {
        this.cartID = cartID;
        this.accID = accID;
        this.productID = productID;
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public String getAccID() {
        return accID;
    }

    public void setAccID(String accID) {
        this.accID = accID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    ProductDAO dao = new ProductDAO();
    public double getTotalPrice() {
        Product p = dao.getProductByID(productID);
        double price = p.getPrice();
        if (p.getDiscount() > 0) {
            price -= price * (p.getDiscount()/100.0); 
        }
        return price * quantity;
    }

}