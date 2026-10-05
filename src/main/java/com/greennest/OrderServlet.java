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

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp?error=login_required");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");
        String payment = request.getParameter("payment");
        String totalStr = request.getParameter("total");

        if (name == null || phone == null || address == null || city == null ||
            pincode == null || payment == null || totalStr == null ||
            name.trim().isEmpty() || address.trim().isEmpty()) {
            response.sendRedirect("checkout.jsp?error=empty_fields");
            return;
        }

        double totalAmount = 0.0;
        try {
            totalAmount = Double.parseDouble(totalStr.trim());
            if (totalAmount <= 0) {
                response.sendRedirect("cart.jsp?error=empty_cart");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("checkout.jsp?error=invalid_total");
            return;
        }

        String orderId = "GN" + (int)(Math.random() * 900000 + 100000);

        String sql = "INSERT INTO orders (order_id, customer_name, phone, address, city, "
                   + "pincode, payment_method, total, user_email, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Order Placed')";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            if (con == null) {
                response.sendRedirect("checkout.jsp?error=db_error");
                return;
            }

            ps = con.prepareStatement(sql);
            ps.setString(1, orderId);
            ps.setString(2, name.trim());
            ps.setString(3, phone.trim());
            ps.setString(4, address.trim());
            ps.setString(5, city.trim());
            ps.setString(6, pincode.trim());
            ps.setString(7, payment.trim());
            ps.setDouble(8, totalAmount);
            ps.setString(9, userEmail.trim());

            int result = ps.executeUpdate();

            if (result > 0) {
                session.setAttribute("orderId", orderId);
                session.setAttribute("orderTotal", String.format("%.2f", totalAmount));
                session.setAttribute("customerName", name.trim());

                response.sendRedirect("order-success.jsp");
            } else {
                response.sendRedirect("checkout.jsp?error=order_placement_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?error=" + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ignored) {
            }
        }
    }
}