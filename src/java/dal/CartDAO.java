package dal;

import model.Cart;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class CartDAO extends DBContext {

    public List<Cart> getCarttByAccID(String accID) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM Cart WHERE accID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, accID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Cart cartItem = new Cart();
                cartItem.setCartID(rs.getInt("cartID"));
                cartItem.setAccID(rs.getString("accID"));
                cartItem.setProductID(rs.getInt("productID"));
                cartItem.setQuantity(rs.getInt("quantity"));
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return cartItems;
    }

    public boolean removeCartItem(int cartID, String accID) {
        String sql = "DELETE FROM Cart WHERE cartID = ? AND accID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, cartID);
            pre.setString(2, accID);
            int rowsDeleted = pre.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public void addItemToCart(String accID, int productID, int quantity) {
        String sqlCheckIfExists = "SELECT quantity FROM Cart WHERE accID = ? AND productID = ?";
        String sqlUpdateQuantity = "UPDATE Cart SET quantity = quantity + ? WHERE accID = ? AND productID = ?";
        String sqlInsertNewItem = "INSERT INTO Cart (accID, productID, quantity) VALUES (?, ?, ?)";

        try {
            PreparedStatement checkStmt = connection.prepareStatement(sqlCheckIfExists);
            checkStmt.setString(1, accID);
            checkStmt.setInt(2, productID);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int existingQuantity = rs.getInt("quantity");
                PreparedStatement updateStmt = connection.prepareStatement(sqlUpdateQuantity);
                updateStmt.setInt(1, quantity);
                updateStmt.setString(2, accID);
                updateStmt.setInt(3, productID);
                updateStmt.executeUpdate();
            } else {
                PreparedStatement insertStmt = connection.prepareStatement(sqlInsertNewItem);
                insertStmt.setString(1, accID);
                insertStmt.setInt(2, productID);
                insertStmt.setInt(3, quantity);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println("Error in addItemToCart: " + e.getMessage());
        }
    }

    public boolean updateCartQuantity(int cartID, int quantity) {
        String sql = "UPDATE Cart SET quantity = ? WHERE cartID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, quantity);
            pre.setInt(2, cartID);
            int rowsUpdated = pre.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("Error in updateCartQuantity: " + e.getMessage());
            return false;
        }
    }

    public Cart getCartByID(int cartID) {
        String sql = "SELECT * FROM Cart WHERE cartID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, cartID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                Cart cartItem = new Cart();
                cartItem.setCartID(rs.getInt("cartID"));
                cartItem.setAccID(rs.getString("accID"));
                cartItem.setProductID(rs.getInt("productID"));
                cartItem.setQuantity(rs.getInt("quantity"));
                return cartItem;
            }
        } catch (SQLException e) {
            System.out.println("Error in getCartByID: " + e.getMessage());
        }
        return null;
    }

    public List<Cart> getCartByAccID(String accID) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT c.cartID, c.productID, c.quantity, p.productName, p.price, p.imageURL "
                + "FROM Cart c "
                + "JOIN Product p ON c.productID = p.productid "
                + "WHERE c.accID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, accID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartID(rs.getInt("cartID"));
                cart.setProductID(rs.getInt("productID"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setAccID(accID);

                Product product = new Product();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setPrice(rs.getDouble("price"));
                product.setImageURL(rs.getString("imageURL"));

                cart.setProduct(product);
                cartItems.add(cart);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return cartItems;
    }

    public void reduceStock(int productID, int quantitySold) {
        String sql = "UPDATE Product SET stock = stock - ? WHERE productID = ? AND stock >= ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, quantitySold);
            ps.setInt(2, productID);
            ps.setInt(3, quantitySold);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        CartDAO cartDAO = new CartDAO();
        ProductDAO dao = new ProductDAO();
        List<Cart> cartItemsTest = cartDAO.getCartByAccID("user1");
        if (cartItemsTest != null) {
            for (Cart cartItem : cartItemsTest) {
                System.out.println("CartID: " + cartItem.getCartID()
                        + ", Product: " + cartItem.getProduct().getProductName()
                        + ", Quantity: " + cartItem.getQuantity());
                System.out.println(cartItem.getProductID());
                System.out.println(dao.getProductByID(cartItem.getProductID()).getFinalPrice());
                System.out.println(cartItem.getProduct().getFinalPrice() * cartItem.getProduct().getDiscount());
            }
        } else {
            System.out.println("No cart items found for the given accID.");
        }

    }
}
