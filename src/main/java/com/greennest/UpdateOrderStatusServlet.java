package com.greennest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");

        if (orderId == null || status == null || orderId.trim().isEmpty()) {
            response.sendRedirect("AdminOrdersServlet?error=invalid_data");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                response.sendRedirect("AdminOrdersServlet?error=db_error");
                return;
            }

            ps = con.prepareStatement(sql);
            ps.setString(1, status.trim());
            ps.setString(2, orderId.trim());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("AdminOrdersServlet?msg=status_updated");
            } else {
                response.sendRedirect("AdminOrdersServlet?error=order_not_found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminOrdersServlet?error=" + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ignored) {
            }
        }
    }
}