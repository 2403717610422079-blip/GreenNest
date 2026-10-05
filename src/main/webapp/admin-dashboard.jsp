<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,com.greennest.DBConnection" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) adminName = "Admin";

    int totalProducts = 0;
    int totalUsers = 0;
    int totalOrders = 0;
    int pendingOrders = 0;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();
        if (con != null) {
            // Count Products
            ps = con.prepareStatement("SELECT COUNT(*) FROM products");
            rs = ps.executeQuery();
            if (rs.next()) totalProducts = rs.getInt(1);
            rs.close();
            ps.close();

            // Count Users
            ps = con.prepareStatement("SELECT COUNT(*) FROM users");
            rs = ps.executeQuery();
            if (rs.next()) totalUsers = rs.getInt(1);
            rs.close();
            ps.close();

            // Count Orders
            ps = con.prepareStatement("SELECT COUNT(*) FROM orders");
            rs = ps.executeQuery();
            if (rs.next()) totalOrders = rs.getInt(1);
            rs.close();
            ps.close();

            // Count Pending Orders
            ps = con.prepareStatement("SELECT COUNT(*) FROM orders WHERE status != 'Delivered' AND status != 'Cancelled'");
            rs = ps.executeQuery();
            if (rs.next()) pendingOrders = rs.getInt(1);
            rs.close();
            ps.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception ignored) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - GreenNest</title>

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
            padding: 20px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 15px;
        }

        .header h2 {
            font-size: 24px;
        }

        .nav-links {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .nav-btn {
            background: #1b5e20;
            color: white;
            text-decoration: none;
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            transition: 0.2s;
        }

        .nav-btn:hover {
            background: #144d18;
        }

        .container {
            max-width: 1150px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .welcome-banner {
            background: linear-gradient(135deg, #2e7d32, #1b5e20);
            color: white;
            padding: 30px;
            border-radius: 14px;
            margin-bottom: 30px;
            box-shadow: 0 6px 20px rgba(46, 125, 50, 0.2);
        }

        .welcome-banner h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .welcome-banner p {
            font-size: 15px;
            opacity: 0.9;
        }

        /* STATS GRID */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 35px;
        }

        .stat-card {
            background: white;
            padding: 25px 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            display: flex;
            align-items: center;
            gap: 18px;
            border-bottom: 4px solid #2e7d32;
        }

        .stat-icon {
            font-size: 38px;
            width: 60px;
            height: 60px;
            background: #e8f5e9;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-info h3 {
            font-size: 28px;
            color: #2e7d32;
            margin-bottom: 4px;
        }

        .stat-info p {
            font-size: 14px;
            color: #666;
            font-weight: bold;
        }

        /* ACTIONS GRID */
        .section-title {
            font-size: 20px;
            color: #2e7d32;
            margin-bottom: 18px;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
        }

        .action-card {
            background: white;
            padding: 30px 25px;
            border-radius: 14px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            text-decoration: none;
            color: inherit;
            transition: all 0.3s ease;
            display: block;
            border: 1px solid #eef2ed;
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(46, 125, 50, 0.15);
            border-color: #2e7d32;
        }

        .action-icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .action-card h3 {
            font-size: 20px;
            color: #2e7d32;
            margin-bottom: 8px;
        }

        .action-card p {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
        }

        @media (max-width: 900px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .actions-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 550px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>

<body>

<header class="header">
    <h2>🌿 GreenNest Administration</h2>
    <div class="nav-links">
        <a href="ManageProductsServlet" class="nav-btn">🌱 Plants</a>
        <a href="ManageUsersServlet" class="nav-btn">👥 Users</a>
        <a href="AdminOrdersServlet" class="nav-btn">📦 Orders</a>
        <a href="index.jsp" class="nav-btn">🌐 Live Store</a>
        <a href="admin-logout.jsp" class="nav-btn" style="background:#c62828;">Logout</a>
    </div>
</header>

<div class="container">

    <div class="welcome-banner">
        <h1>👋 Welcome back, <%= adminName %>!</h1>
        <p>GreenNest Store Overview & Live Database Statistics</p>
    </div>

    <!-- LIVE METRICS -->
    <div class="stats-grid">

        <div class="stat-card">
            <div class="stat-icon">🌱</div>
            <div class="stat-info">
                <h3><%= totalProducts %></h3>
                <p>Total Products</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-info">
                <h3><%= totalUsers %></h3>
                <p>Registered Users</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">📦</div>
            <div class="stat-info">
                <h3><%= totalOrders %></h3>
                <p>Total Orders</p>
            </div>
        </div>

        <div class="stat-card" style="border-bottom-color: #f57c00;">
            <div class="stat-icon" style="background: #fff3e0;">⏳</div>
            <div class="stat-info">
                <h3 style="color: #e65100;"><%= pendingOrders %></h3>
                <p>Pending Orders</p>
            </div>
        </div>

    </div>

    <!-- MANAGEMENT MODULES -->
    <h2 class="section-title">⚡ Quick Management</h2>

    <div class="actions-grid">

        <a href="ManageProductsServlet" class="action-card">
            <div class="action-icon">🌱</div>
            <h3>Manage Plants</h3>
            <p>View, add, edit, and delete products in the live plant catalog.</p>
        </a>

        <a href="ManageUsersServlet" class="action-card">
            <div class="action-icon">👥</div>
            <h3>Manage Users</h3>
            <p>View registered customer accounts, user emails, and contact numbers.</p>
        </a>

        <a href="AdminOrdersServlet" class="action-card">
            <div class="action-icon">📦</div>
            <h3>Manage Orders</h3>
            <p>Track orders, inspect delivery addresses, and update fulfillment status.</p>
        </a>

    </div>

</div>

</body>
</html>