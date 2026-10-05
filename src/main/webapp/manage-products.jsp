<%@ page session="true" %>
<%@ page import="java.util.List" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<String[]> products =
        (List<String[]>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Manage Plants - GreenNest</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f1f8f3;
            margin: 0;
        }

        .header {
            background: #2e7d32;
            color: white;
            padding: 20px;
        }

        .container {
            padding: 30px;
        }

        .add-btn {
            display: inline-block;
            padding: 12px 20px;
            background: #2e7d32;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th {
            background: #2e7d32;
            color: white;
            padding: 12px;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        tr:hover {
            background: #f5f5f5;
        }

        .edit {
            background: #1976d2;
            color: white;
            padding: 7px 12px;
            text-decoration: none;
            border-radius: 4px;
        }

        .delete {
            background: #d32f2f;
            color: white;
            padding: 7px 12px;
            text-decoration: none;
            border-radius: 4px;
        }

        .empty {
            text-align: center;
            padding: 30px;
        }

    </style>

</head>

<body>

<div class="header">

    <h2>GreenNest - Manage Plants</h2>

</div>

<div class="container">

    <h2>All Plants</h2>

    <a href="add-product.jsp" class="add-btn">
        + Add New Plant
    </a>

    <table>

        <tr>
            <th>ID</th>
            <th>Plant Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Description</th>
            <th>Action</th>
        </tr>

        <%
            if (products != null && !products.isEmpty()) {

                for (String[] p : products) {
        %>

        <tr>

            <td><%= p[0] %></td>

            <td><%= p[1] %></td>

            <td><%= p[2] %></td>

            <td>₹<%= p[3] %></td>

            <td><%= p[4] %></td>

            <td>

                <a href="edit-product.jsp?id=<%= p[0] %>"
                   class="edit">
                    Edit
                </a>

                <a href="DeleteProductServlet?id=<%= p[0] %>"
                   class="delete"
                   onclick="return confirm('Are you sure you want to delete this plant?');">
                    Delete
                </a>

            </td>

        </tr>

        <%
                }

            } else {
        %>

        <tr>
            <td colspan="6" class="empty">
                No plants available.
            </td>
        </tr>

        <%
            }
        %>

    </table>

</div>

</body>
</html>