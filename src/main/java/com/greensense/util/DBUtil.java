package com.greensense.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/waste_management";
    private static final String USER = "root";
    private static final String PASSWORD = "vansh@12345"; 

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Add this line to explicitly load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException | ClassNotFoundException e) { // Add ClassNotFoundException
            e.printStackTrace();
        }
        return conn;
    }
    public static void main(String[] args) {
        System.out.println("Testing database connection...");
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            if (conn != null) {
                System.out.println("Connection Successful!");
                conn.close();
            } else {
                System.out.println("Connection Failed! The getConnection() method returned null.");
            }
        } catch (Exception e) {
            System.out.println("An exception occurred during connection test.");
            e.printStackTrace();
        }
    }
}
