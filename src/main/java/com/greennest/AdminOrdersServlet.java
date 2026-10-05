package com.greennest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminOrdersServlet")
public class AdminOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        List<Order> orders = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT id, order_id, customer_name, phone, address, city, pincode, "
                   + "payment_method, total, order_date, user_email, status "
                   + "FROM orders ORDER BY id DESC";

        try {
            con = DBConnection.getConnection();
            if (con != null) {
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setOrderId(rs.getString("order_id"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setPhone(rs.getString("phone"));
                    order.setAddress(rs.getString("address"));
                    order.setCity(rs.getString("city"));
                    order.setPincode(rs.getString("pincode"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setTotal(rs.getDouble("total"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setUserEmail(rs.getString("user_email"));
                    order.setStatus(rs.getString("status"));

                    orders.add(order);
                }
            }

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("admin-orders.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("admin-orders.jsp").forward(request, response);
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