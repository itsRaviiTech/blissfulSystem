/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Database configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/sad";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";
    
    // Private constructor to prevent instantiation
    private DatabaseConnection() {}
    
    /**
     * Gets a database connection using the configured parameters
     * @return Connection object
     * @throws RuntimeException if connection fails
     */
    public static Connection getConnection() {
        try {
            // Load MySQL JDBC Driver (for MySQL 8+)
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Get connection with autoReconnect and other optimizations
            return DriverManager.getConnection(
                DB_URL + "?useSSL=false&serverTimezone=UTC&autoReconnect=true",
                DB_USER,
                DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to connect to database", e);
        }
    }
    
    /**
     * Closes a connection quietly (no exception thrown)
     * @param connection The connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}