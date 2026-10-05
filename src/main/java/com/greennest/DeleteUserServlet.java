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

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("ManageUsersServlet?error=invalid_id");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            int id = Integer.parseInt(idStr.trim());
            con = DBConnection.getConnection();
            if (con == null) {
                response.sendRedirect("ManageUsersServlet?error=db_error");
                return;
            }

            // Find user's email first
            String findEmailSql = "SELECT email FROM users WHERE id = ?";
            ps = con.prepareStatement(findEmailSql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            String userEmail = null;
            if (rs.next()) {
                userEmail = rs.getString("email");
            }
            rs.close();
            ps.close();

            if (userEmail == null) {
                response.sendRedirect("ManageUsersServlet?error=user_not_found");
                return;
            }

            // Check if user has orders before deleting
            String checkOrdersSql = "SELECT COUNT(*) FROM orders WHERE user_email = ?";
            ps = con.prepareStatement(checkOrdersSql);
            ps.setString(1, userEmail);
            rs = ps.executeQuery();

            int orderCount = 0;
            if (rs.next()) {
                orderCount = rs.getInt(1);
            }
            rs.close();
            ps.close();

            if (orderCount > 0) {
                // User has active or historical orders - safeguard data integrity
                response.sendRedirect("ManageUsersServlet?error=user_has_orders");
                return;
            }

            // Safe to delete user
            String deleteSql = "DELETE FROM users WHERE id = ?";
            ps = con.prepareStatement(deleteSql);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("ManageUsersServlet?msg=deleted");
            } else {
                response.sendRedirect("ManageUsersServlet?error=delete_failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("ManageUsersServlet?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ManageUsersServlet?error=" + e.getMessage());
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
