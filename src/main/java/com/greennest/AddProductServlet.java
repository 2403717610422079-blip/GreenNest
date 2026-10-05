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

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");

        if (name == null || priceStr == null || name.trim().isEmpty()) {
            response.sendRedirect("add-product.jsp?error=empty_fields");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            double price = Double.parseDouble(priceStr.trim());
            con = DBConnection.getConnection();
            if (con == null) {
                response.sendRedirect("add-product.jsp?error=db_error");
                return;
            }

            String sql = "INSERT INTO products (name, category, price, description) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, name.trim());
            ps.setString(2, category != null ? category.trim() : "General");
            ps.setDouble(3, price);
            ps.setString(4, description != null ? description.trim() : "");

            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("ManageProductsServlet?msg=added");
            } else {
                response.sendRedirect("add-product.jsp?error=add_failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("add-product.jsp?error=invalid_price");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-product.jsp?error=" + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ignored) {
            }
        }
    }
}