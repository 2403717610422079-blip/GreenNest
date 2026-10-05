<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.greennest.users" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    List<users> userList =
        (List<users>) request.getAttribute("users");

    Integer userCount =
        (Integer) request.getAttribute("userCount");

    if (userCount == null) {
        userCount = (userList == null) ? 0 : userList.size();
    }

    String msg = request.getParameter("msg");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Users - GreenNest Admin</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f1f8f3;
            color: #263a2c;
        }

        .header {
            background: #2e7d32;
            color: white;
            padding: 18px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .nav-links {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .nav-btn {
            background: #1b5e20;
            color: white;
            text-decoration: none;
            padding: 9px 13px;
            border-radius: 6px;
            font-size: 14px;
        }

        .nav-btn:hover {
            background: #144d18;
        }

        .container {
            max-width: 1150px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-title-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        h1 {
            color: #2e7d32;
            font-size: 28px;
        }

        .count-badge {
            background: #2e7d32;
            color: white;
            padding: 9px 16px;
            border-radius: 20px;
            font-weight: bold;
        }

        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-error {
            background: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            background: #2e7d32;
            color: white;
            padding: 14px;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #eef2ed;
            overflow-wrap: anywhere;
        }

        tbody tr:hover {
            background: #f9fbf9;
        }

        .btn-delete {
            background: #e53935;
            color: white;
            padding: 7px 12px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            white-space: nowrap;
        }

        .btn-delete:hover {
            background: #c62828;
        }

        .empty-state {
            text-align: center;
            padding: 40px 15px;
            color: #666;
        }

        .empty-state h3 {
            color: #2e7d32;
            margin-bottom: 10px;
        }

        @media (max-width: 768px) {
            .header {
                padding: 18px;
                flex-direction: column;
                align-items: flex-start;
            }

            h1 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

<header class="header">
    <h2>🌿 GreenNest Admin Panel</h2>

    <div class="nav-links">
        <a href="admin-dashboard.jsp" class="nav-btn">
            Dashboard
        </a>

        <a href="ManageProductsServlet" class="nav-btn">
            Plants
        </a>

        <a href="ManageUsersServlet"
           class="nav-btn"
           style="background:#144d18;">
            Users
        </a>

        <a href="AdminOrdersServlet" class="nav-btn">
            Orders
        </a>

        <a href="index.jsp" class="nav-btn">
            Store
        </a>

        <a href="admin-logout.jsp"
           class="nav-btn"
           style="background:#c62828;">
            Logout
        </a>
    </div>
</header>

<div class="container">

    <div class="page-title-box">
        <div>
            <h1>👥 Registered Customers</h1>
            <p style="color:#666; margin-top:6px;">
                Manage user accounts and customer information
            </p>
        </div>

        <div class="count-badge">
            Total Users: <%= userCount %>
        </div>
    </div>

    <% if ("deleted".equals(msg)) { %>

        <div class="alert-success">
            User account deleted successfully!
        </div>

    <% } else if ("user_has_orders".equals(error)) { %>

        <div class="alert-error">
            Cannot delete this user because order history exists.
        </div>

    <% } else if (error != null && !error.isEmpty()) { %>

        <div class="alert-error">
            Error: <%= error.replace("_", " ") %>
        </div>

    <% } %>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Customer Name</th>
                    <th>Email Address</th>
                    <th>Phone Number</th>
                    <th style="text-align:center;">Action</th>
                </tr>
            </thead>

            <tbody>

                <% if (userList != null && !userList.isEmpty()) { %>

                    <% for (users u : userList) { %>

                        <tr>
                            <td>
                                <strong>#<%= u.getId() %></strong>
                            </td>

                            <td>
                                <%= u.getName() %>
                            </td>

                            <td>
                                <%= u.getEmail() %>
                            </td>

                            <td>
                                <%= (u.getPhone() != null
                                    && !u.getPhone().trim().isEmpty())
                                    ? u.getPhone() : "-" %>
                            </td>

                            <td style="text-align:center;">
                                <a class="btn-delete"
                                   href="DeleteUserServlet?id=<%= u.getId() %>"
                                   onclick="return confirm('Are you sure you want to delete this user?');">
                                    Delete
                                </a>
                            </td>
                        </tr>

                    <% } %>

                <% } else { %>

                    <tr>
                        <td colspan="5">
                            <div class="empty-state">
                                <h3>No Registered Users Found</h3>
                                <p>
                                    Registered customers will appear here.
                                </p>
                            </div>
                        </td>
                    </tr>

                <% } %>

            </tbody>
        </table>
    </div>

</div>

</body>
</html>