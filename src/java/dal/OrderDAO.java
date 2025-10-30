package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Order;
import model.Product;

public class OrderDAO extends DBContext {

    public Cart getCartItem(int cartID, String accID) {
        String sql = "SELECT * FROM Cart WHERE cartID = ? AND accID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, cartID);
            pre.setString(2, accID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartID(rs.getInt("cartID"));
                cart.setAccID(rs.getString("accID"));
                cart.setProductID(rs.getInt("productID"));
                cart.setQuantity(rs.getInt("quantity"));
                return cart;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Product getProductForCart(int productID) {
        String sql = "SELECT * FROM Product WHERE productid = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, productID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("productid"));
                product.setProductName(rs.getString("productName"));
                product.setPrice(rs.getDouble("price"));
                product.setImageURL(rs.getString("imageURL"));
                return product;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int createOrder(Order order) {
        String sql = "INSERT INTO [Order] (userID, create_at, totalPrice, address, receiver_name, receiver_phone) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setString(1, order.getAccID());
            pre.setString(2, order.getOrderDate());
            pre.setDouble(3, order.getTotalPrice());
            pre.setString(4, order.getAddress());
            pre.setString(5, order.getReceiverName());
            pre.setString(6, order.getReceiverPhone());

            int affectedRows = pre.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pre.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM [Order] WHERE orderID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, orderId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Order(
                        rs.getInt("orderID"),
                        rs.getString("userID"),
                        rs.getString("create_at"),
                        rs.getString("status"),
                        rs.getDouble("totalPrice"),
                        rs.getString("address"),
                        rs.getString("receiver_name"),
                        rs.getString("receiver_phone")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE [Order] SET status = ? WHERE orderID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, status);
            pre.setInt(2, orderId);
            int rowsUpdated = pre.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void removeCartItem(int cartID, String accID) {
        String sql = "DELETE FROM Cart WHERE cartID = ? AND accID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, cartID);
            pre.setString(2, accID);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Order> getOrdersByAccID(String accID) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM [Order] WHERE userID = ? ORDER BY create_at DESC";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, accID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("orderID"),
                        rs.getString("userID"),
                        rs.getString("create_at"),
                        rs.getString("status"),
                        rs.getDouble("totalPrice"),
                        rs.getString("address"),
                        rs.getString("receiver_name"),
                        rs.getString("receiver_phone")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orders;
    }

    public List<Order> getAllOrders(String sort) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM [Order]";
        if (sort != null) {
            switch (sort) {
                case "date_asc":
                    sql += " ORDER BY create_at ASC";
                    break;
                case "date_desc":
                    sql += " ORDER BY create_at DESC";
                    break;
                case "total_asc":
                    sql += " ORDER BY totalPrice ASC";
                    break;
                case "total_desc":
                    sql += " ORDER BY totalPrice DESC";
                    break;
            }
        }

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("orderID"),
                        rs.getString("userID"),
                        rs.getString("create_at"),
                        rs.getString("status"),
                        rs.getDouble("totalPrice"),
                        rs.getString("address"),
                        rs.getString("receiver_name"),
                        rs.getString("receiver_phone")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orders;
    }
    
    public List<Order> getListByPage(List<Order> list, int start, int end) {
        ArrayList<Order> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }
}
