package com.greennest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ManageProductsServlet")
public class ManageProductsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<String[]> products = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();
            if (con == null) {
                request.setAttribute("error", "Database connection failed");
                request.setAttribute("products", products);
                request.getRequestDispatcher("manage-products.jsp").forward(request, response);
                return;
            }

            String sql = "SELECT id, name, category, price, description FROM products";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String[] product = new String[5];

                product[0] = String.valueOf(rs.getInt("id"));
                product[1] = rs.getString("name");
                product[2] = rs.getString("category");
                product[3] = String.valueOf(rs.getDouble("price"));
                product[4] = rs.getString("description");

                products.add(product);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
        }

        request.setAttribute("products", products);

        request.getRequestDispatcher("manage-products.jsp")
               .forward(request, response);
    }
}