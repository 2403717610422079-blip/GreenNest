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

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {

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
            response.sendRedirect("ManageProductsServlet?error=invalid_id");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            int id = Integer.parseInt(idStr.trim());
            con = DBConnection.getConnection();
            if (con == null) {
                response.sendRedirect("ManageProductsServlet?error=db_error");
                return;
            }

            String sql = "DELETE FROM products WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("ManageProductsServlet?msg=deleted");
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
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ignored) {
            }
        }
    }
}
