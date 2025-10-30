package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;
import model.Product;

public class OrderDetailDAO extends DBContext {

    public void createOrderDetail(OrderDetail orderDetail) {
        String sql = "INSERT INTO OrderDetail (orderID, productID, quantity) VALUES (?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, orderDetail.getOrderID());
            pre.setInt(2, orderDetail.getProductID());
            pre.setInt(3, orderDetail.getQuantity());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetail WHERE orderID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, orderId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                orderDetails.add(new OrderDetail(
                        rs.getInt("orderDetailID"),
                        rs.getInt("orderID"),
                        rs.getInt("productID"),
                        rs.getInt("quantity")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orderDetails;
    }

    public double calculateTotalPrice(int orderId) {
        double totalPrice = 0;
        String sql = "SELECT od.quantity, p.price FROM OrderDetail od "
                + "JOIN Product p ON od.productID = p.productid "
                + "WHERE od.orderID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, orderId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");
                totalPrice += quantity * price;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return totalPrice;
    }

}
