package model;

public class Order {
    private int orderID;
    private String accID; 
    private String orderDate;
    private String status;
    private double totalPrice;
    private String address;
    private String receiverName;
    private String receiverPhone;

    public Order() {}
     public Order(int orderID, String accID, String orderDate, String status, double totalPrice, String address,String receiverName, String receiverPhone) {
        this.orderID = orderID;
        this.accID = accID;
        this.orderDate = orderDate;
        this.status = status;
        this.totalPrice = totalPrice;
        this.address = address;
        this.receiverName = receiverName;
        this.receiverPhone = receiverPhone;
    }
     
    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getAccID() {
        return accID;
    }

    public void setAccID(String accID) {
        this.accID = accID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }
    
     @Override
    public String toString() {
        return "Order{" +
                "orderID=" + orderID +
                ", accID='" + accID + '\'' +
                ", orderDate=" + orderDate +
                ", status='" + status + '\'' +
                ", totalPrice=" + totalPrice +
                ", address='" + address + '\'' +
                ", receiverName='" + receiverName + '\'' +
                ", receiverPhone='" + receiverPhone + '\'' +
                '}';
    }
}