package com.greennest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        if (name == null || email == null || password == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=empty_fields");
            return;
        }

        Connection con = null;
        PreparedStatement checkPs = null;
        PreparedStatement insertPs = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                response.sendRedirect("register.jsp?error=db_error");
                return;
            }

            // 1. Check for duplicate email
            String checkSql = "SELECT id FROM users WHERE email = ?";
            checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, email.trim());
            rs = checkPs.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?error=duplicate_email");
                return;
            }

            // 2. Insert new user
            String insertSql = "INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)";
            insertPs = con.prepareStatement(insertSql);
            insertPs.setString(1, name.trim());
            insertPs.setString(2, email.trim());
            insertPs.setString(3, phone != null ? phone.trim() : "");
            insertPs.setString(4, password.trim());

            int rows = insertPs.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("login.jsp?msg=registered");
            } else {
                response.sendRedirect("register.jsp?error=registration_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=" + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkPs != null) checkPs.close();
                if (insertPs != null) insertPs.close();
                if (con != null) con.close();
            } catch (Exception ignored) {
            }
        }
    }
}