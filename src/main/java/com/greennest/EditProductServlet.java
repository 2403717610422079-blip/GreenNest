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

@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("ManageProductsServlet?error=invalid_id");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            int id = Integer.parseInt(idStr.trim());
            con = DBConnection.getConnection();
            if (con == null) {
                response.sendRedirect("ManageProductsServlet?error=db_error");
                return;
            }

            String sql = "SELECT id, name, category, price, description FROM products WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("id", rs.getInt("id"));
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("category", rs.getString("category"));
                request.setAttribute("price", rs.getDouble("price"));
                request.setAttribute("description", rs.getString("description"));

                request.getRequestDispatcher("edit-product.jsp").forward(request, response);
            } else {
                response.sendRedirect("ManageProductsServlet?error=not_found");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("ManageProductsServlet?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ManageProductsServlet?error=" + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ignored) {
            }
        }
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
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");

        if (idStr == null || name == null || priceStr == null || name.trim().isEmpty()) {
            response.sendRedirect("ManageProductsServlet?error=empty_fields");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            int id = Integer.parseInt(idStr.trim());
            double price = Double.parseDouble(priceStr.trim());

            con = DBConnection.getConnection();
            if (con == null) {
                response.sendRedirect("ManageProductsServlet?error=db_error");
                return;
            }

            String sql = "UPDATE products SET name = ?, category = ?, price = ?, description = ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, name.trim());
            ps.setString(2, category != null ? category.trim() : "General");
            ps.setDouble(3, price);
            ps.setString(4, description != null ? description.trim() : "");
            ps.setInt(5, id);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("ManageProductsServlet?msg=updated");
            } else {
                response.sendRedirect("ManageProductsServlet?error=update_failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("ManageProductsServlet?error=invalid_number");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ManageProductsServlet?error=" + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ignored) {
            }
        }
    }
}