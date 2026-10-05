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
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("admin-login.jsp?error=empty");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT admin_id, name, email FROM admin WHERE email = ? AND password = ?";

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                response.sendRedirect("admin-login.jsp?error=db_error");
                return;
            }

            ps = con.prepareStatement(sql);
            ps.setString(1, email.trim());
            ps.setString(2, password.trim());

            rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("adminId", rs.getInt("admin_id"));
                session.setAttribute("adminName", rs.getString("name"));
                session.setAttribute("adminEmail", rs.getString("email"));

                response.sendRedirect("admin-dashboard.jsp");
            } else {
                response.sendRedirect("admin-login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-login.jsp?error=" + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ignored) {
            }
        }
    }
}