package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductDAO extends DBContext {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";
        try (PreparedStatement pre = connection.prepareStatement(sql); ResultSet rs = pre.executeQuery()) {
            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getInt("cateID"),
                        rs.getInt("itemID"),
                        rs.getString("imageURL"),
                        rs.getDouble("discount"),
                        rs.getInt("stock")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return products;
    }

    public List<Product> getListByPage(List<Product> list, int start, int end) {
        ArrayList<Product> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }
    
    public Product getProductByID(int productID) {
        String sql = "SELECT * FROM Product WHERE productID = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, productID);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("productID"),
                            rs.getString("productName"),
                            rs.getDouble("price"),
                            rs.getString("description"),
                            rs.getInt("cateID"),
                            rs.getInt("itemID"),
                            rs.getString("imageURL"),
                            rs.getDouble("discount"),
                            rs.getInt("stock")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean addProduct(Product product) {
    String sql = "INSERT INTO Product (productName, price, description, cateID, itemID, imageURL, discount, stock) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    try (PreparedStatement pre = connection.prepareStatement(sql)) {
        pre.setString(1, product.getProductName());
        pre.setDouble(2, product.getPrice());
        pre.setString(3, product.getDescription());
        pre.setInt(4, product.getCateID());
        pre.setInt(5, product.getItemID());
        pre.setString(6, product.getImageURL());
        pre.setDouble(7, product.getDiscount());
        pre.setInt(8, product.getStock());
        return pre.executeUpdate() > 0;  // ✅ Trả true nếu INSERT OK
    } catch (SQLException e) {
        System.out.println("Error in addProduct: " + e);
    }
    return false;
}


    public boolean updateProduct(Product product) {
        String sql = "UPDATE Product SET productName=?, price=?, description=?, cateID=?, itemID=?, imageURL=?, discount=?, stock=? WHERE productID=?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, product.getProductName());
            pre.setDouble(2, product.getPrice());
            pre.setString(3, product.getDescription());
            pre.setInt(4, product.getCateID());
            pre.setInt(5, product.getItemID());
            pre.setString(6, product.getImageURL());
            pre.setDouble(7, product.getDiscount());
            pre.setInt(8, product.getStock());
            pre.setInt(9, product.getProductID());
            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean deleteProduct(int productID) {
        String sql = "DELETE FROM Product WHERE productID = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, productID);
            return pre.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean isProductExist(String productName) {
        String sql = "SELECT COUNT(*) FROM Product WHERE productName = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, productName);
            try (ResultSet rs = pre.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        Product product = dao.getProductByID(20);
        System.out.println(product.getRating());
        System.out.println(product.getPrice());
        System.out.println(product.getFinalPrice());

    }

    public List<Product> getSimilarProducts(int cateID, int itemID, int currentProductID, int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Product WHERE cateID = ? AND itemID = ? AND productID != ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, limit);
            pre.setInt(2, cateID);
            pre.setInt(3, itemID);
            pre.setInt(4, currentProductID);
            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    products.add(new Product(
                            rs.getInt("productID"),
                            rs.getString("productName"),
                            rs.getDouble("price"),
                            rs.getString("description"),
                            rs.getInt("cateID"),
                            rs.getInt("itemID"),
                            rs.getString("imageURL"),
                            rs.getDouble("discount"),
                            rs.getInt("stock")
                    ));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getSimilarProducts: " + e);
        }
        return products;
    }

    public double getRatingByProductID(int productID) {
        String sql = "SELECT rating FROM ProductRating WHERE productid = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, productID);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("rating");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getRatingByProductID: " + e);
        }
        return 0.0;
    }

}