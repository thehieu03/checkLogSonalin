package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author FPT University - PRJ30X
 */
public class DBContext {

    protected Connection connection;

    public DBContext() {

        try {
            String explicitUrl = firstNonEmpty(System.getProperty("DB_URL"), System.getenv("DB_URL"));
            String host = firstNonEmpty(System.getProperty("DB_HOST"), System.getenv("DB_HOST"), "localhost");
            String port = firstNonEmpty(System.getProperty("DB_PORT"), System.getenv("DB_PORT"), "1433");
            String instance = firstNonEmpty(System.getProperty("DB_INSTANCE"), System.getenv("DB_INSTANCE")); // e.g., SQLEXPRESS
            String database = firstNonEmpty(System.getProperty("DB_NAME"), System.getenv("DB_NAME"), "ItemShopDB");
            String user = firstNonEmpty(System.getProperty("DB_USER"), System.getenv("DB_USER"), "sa");
            String pass = firstNonEmpty(System.getProperty("DB_PASS"), System.getenv("DB_PASS"), "123");

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // 1) Allow full override by DB_URL
            if (explicitUrl != null && !explicitUrl.isEmpty()) {
                connection = DriverManager.getConnection(explicitUrl, user, pass);
                return;
            }

            // 2) Try host:port first
            String urlByPort = "jdbc:sqlserver://" + host + ":" + port + ";databaseName=" + database + ";encrypt=true;trustServerCertificate=true";
            try {
                connection = DriverManager.getConnection(urlByPort, user, pass);
                return;
            } catch (SQLException first) {
                System.err.println("[DBContext] Connection failed using host:port (" + urlByPort + "): " + first.getMessage());
            }

            // 3) If instance provided (or common default), try instanceName style
            String instanceToTry = instance != null && !instance.isEmpty() ? instance : "SQLEXPRESS";
            String urlByInstance = "jdbc:sqlserver://" + host + ";instanceName=" + instanceToTry + ";databaseName=" + database + ";encrypt=true;trustServerCertificate=true";
            try {
                connection = DriverManager.getConnection(urlByInstance, user, pass);
                return;
            } catch (SQLException second) {
                System.err.println("[DBContext] Connection failed using instanceName (" + urlByInstance + "): " + second.getMessage());
            }

            // 4) Final fallback: previous hardcoded host used in this project
            String legacyUrl = "jdbc:sqlserver://THEHIEU:1433;databaseName=" + database + ";encrypt=true;trustServerCertificate=true";
            try {
                connection = DriverManager.getConnection(legacyUrl, user, pass);
                System.err.println("[DBContext] Connected using legacy URL (" + legacyUrl + ")");
                return;
            } catch (SQLException legacy) {
                System.err.println("[DBContext] Connection failed using legacy host (" + legacyUrl + "): " + legacy.getMessage());
                throw legacy;
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("[DBContext] Failed to initialize database connection: " + e.getMessage());
            connection = null;
        }
    }

    private static String firstNonEmpty(String a, String b) {
        if (a != null && !a.isEmpty()) return a;
        if (b != null && !b.isEmpty()) return b;
        return null;
    }

    private static String firstNonEmpty(String a, String b, String defaultValue) {
        String v = firstNonEmpty(a, b);
        return v != null ? v : defaultValue;
    }

    public Connection getConnection() {
        return connection;
    }
}
