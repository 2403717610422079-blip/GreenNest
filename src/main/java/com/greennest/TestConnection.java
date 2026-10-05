package com.greennest;

import java.sql.Connection;

public class TestConnection {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {

            System.out.println(
                "GREENNEST DATABASE CONNECTED! 🌿"
            );

        } else {

            System.out.println(
                "DATABASE CONNECTION FAILED!"
            );
        }
    }
}
