package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO extends DBContext {

    public List<Category> getAllCates() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT cateID, cateName FROM Category";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                categories.add(new Category(
                        rs.getString("cateID"),
                        rs.getString("cateName")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return categories;
    }

    public void addCategory(Category category) {
        String sql = "insert into Category (cateName) values (?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, category.getCateName());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Category getCateByID(int cateID) {
        String sql = "SELECT cateID, cateName FROM Category WHERE cateID = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, cateID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new Category(
                        rs.getString("cateID"),
                        rs.getString("cateName")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}
