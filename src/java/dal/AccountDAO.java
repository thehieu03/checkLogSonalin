package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Account;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO extends DBContext {

    public Account getAc(String accID) {
        String sql = "select * from Account where accID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, accID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new Account(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
        System.out.println(dao.getAc("user1").getPassword());
    }

    public void addAccount(Account ac) {
        String sql = "insert into Account values(?,?,?,?,1,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, ac.getAccID());
            pre.setString(2, ac.getEmail());
            pre.setString(3, ac.getPassword());
            pre.setString(4, ac.getName());
            pre.setString(5, ac.getPhone());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean isAccountExist(String accID, String email, String phone) {
        String sql = "select count(*) from Account where accID = ? OR email = ? OR phone = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, accID);
            pre.setString(2, email);
            pre.setString(3, phone);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean changePassword(String accID, String newPassword) {
        String sql = "update Account set password = ? where accID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, newPassword);
            pre.setString(2, accID);
            int rowsUpdated = pre.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateAccount(Account updatedAccount) {
        String sql = "UPDATE Account SET name = ?, email = ?, phone = ? WHERE accID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, updatedAccount.getName());
            pre.setString(2, updatedAccount.getEmail());
            pre.setString(3, updatedAccount.getPhone());
            pre.setString(4, updatedAccount.getAccID());

            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public List<Account> getAllAccounts() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM Account";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Account ac = new Account(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6));
                list.add(ac);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Account> getListByPage(List<Account> list, int start, int end) {
        ArrayList<Account> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }
    
    public List<Account> getAccountsByFilter(String searchName, Integer role) {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM Account WHERE 1=1";

        if (searchName != null && !searchName.isEmpty()) {
            sql += " AND (accID LIKE ? OR name LIKE ?)";
        }
        if (role != null) {
            sql += " AND role = ?";
        }

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            int parameterIndex = 1;

            if (searchName != null && !searchName.isEmpty()) {
                pre.setString(parameterIndex++, "%" + searchName + "%");
                pre.setString(parameterIndex++, "%" + searchName + "%");
            }
            if (role != null) {
                pre.setInt(parameterIndex++, role);
            }

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Account ac = new Account(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6));
                list.add(ac);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean deleteAccount(String accID) {
        String sql = "DELETE FROM Account WHERE accID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, accID);
            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi xóa tài khoản: " + e.getMessage());
            return false;
        }
    }
}
