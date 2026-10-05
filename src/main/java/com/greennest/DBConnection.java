package com.greennest;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 1. Check for complete MySQL connection URL (common on Railway / cloud providers)
            String mysqlUrl = System.getenv("MYSQL_URL");
            if (mysqlUrl == null || mysqlUrl.trim().isEmpty()) {
                mysqlUrl = System.getenv("DATABASE_URL");
            }

            if (mysqlUrl != null && !mysqlUrl.trim().isEmpty() && mysqlUrl.startsWith("mysql://")) {
                URI uri = new URI(mysqlUrl);
                String host = uri.getHost();
                int port = uri.getPort() == -1 ? 3306 : uri.getPort();
                String path = uri.getPath();
                String dbName = (path != null && path.length() > 1) ? path.substring(1) : "greennest";
                String userInfo = uri.getUserInfo();
                String user = "";
                String password = "";
                if (userInfo != null) {
                    String[] parts = userInfo.split(":", 2);
                    user = parts[0];
                    if (parts.length > 1) {
                        password = parts[1];
                    }
                }
                String jdbcUrl = "jdbc:mysql://" + host + ":" + port + "/" + dbName
                        + "?useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8&serverTimezone=UTC";
                return DriverManager.getConnection(jdbcUrl, user, password);
            }

            // 2. Check for individual environment variables with Railway and custom support
            String host = getEnv("DB_HOST", getEnv("MYSQLHOST", "localhost"));
            String port = getEnv("DB_PORT", getEnv("MYSQLPORT", "3306"));
            String dbName = getEnv("DB_NAME", getEnv("MYSQLDATABASE", "greennest"));
            String user = getEnv("DB_USER", getEnv("MYSQLUSER", "root"));
            String password = getEnv("DB_PASSWORD", getEnv("MYSQLPASSWORD", "root"));

            String jdbcUrl = "jdbc:mysql://" + host + ":" + port + "/" + dbName
                    + "?useSSL=false&allowPublicKeyRetrieval=true&characterEncoding=UTF-8&serverTimezone=UTC";

            return DriverManager.getConnection(jdbcUrl, user, password);
        } catch (Exception e) {
            System.err.println("DATABASE CONNECTION ERROR: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    private static String getEnv(String name, String defaultValue) {
        String value = System.getenv(name);
        if (value != null && !value.trim().isEmpty()) {
            return value.trim();
        }
        return defaultValue;
    }
}