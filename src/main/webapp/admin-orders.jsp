<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.greennest.Order" %>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    String adminName = (String) session.getAttribute("adminName");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    String msg = request.getParameter("msg");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - GreenNest Admin</title>

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
            padding: 18px 40px;
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
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-title-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .page-title-box h1 {
            color: #2e7d32;
            font-size: 28px;
        }

        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #c8e6c9;
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .alert-error {
            background: #ffebee;
            color: #c62828;
            border: 1px solid #ffcdd2;
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .order-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 22px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            border-left: 5px solid #2e7d32;
        }

        .order-card.status-cancelled {
            border-left-color: #e53935;
        }

        .order-card.status-delivered {
            border-left-color: #2e7d32;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            border-bottom: 1px solid #eef2ed;
            flex-wrap: wrap;
            gap: 10px;
        }

        .order-id {
            color: #2e7d32;
            font-size: 19px;
            font-weight: bold;
        }

        .status-badge {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 13px;
        }

        .status-badge.cancelled {
            background: #ffebee;
            color: #c62828;
        }

        .order-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-top: 18px;
        }

        .info-box {
            background: #f8faf7;
            padding: 14px;
            border-radius: 8px;
        }

        .info-label {
            font-size: 12px;
            color: #777;
            margin-bottom: 5px;
            text-transform: uppercase;
            font-weight: bold;
        }

        .info-value {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            word-break: break-word;
        }

        .info-value.price {
            color: #2e7d32;
            font-size: 17px;
            font-weight: bold;
        }

        .status-form-section {
            margin-top: 18px;
            padding-top: 16px;
            border-top: 1px solid #eef2ed;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
        }

        .status-form {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .status-form select {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
        }

        .btn-update {
            background: #2e7d32;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 13px;
            transition: 0.2s;
        }

        .btn-update:hover {
            background: #1b5e20;
        }

        .empty-state {
            background: white;
            text-align: center;
            padding: 60px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            color: #666;
        }

        .empty-state h3 {
            color: #2e7d32;
            margin-bottom: 8px;
        }

        @media (max-width: 850px) {
            .order-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 550px) {
            .order-grid {
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
    <h2>🌿 GreenNest Admin Panel</h2>
    <div class="nav-links">
        <a href="admin-dashboard.jsp" class="nav-btn">📊 Dashboard</a>
        <a href="ManageProductsServlet" class="nav-btn">🌱 Plants</a>
        <a href="ManageUsersServlet" class="nav-btn">👥 Users</a>
        <a href="AdminOrdersServlet" class="nav-btn" style="background:#144d18;">📦 Orders</a>
        <a href="index.jsp" class="nav-btn">🌐 Store</a>
        <a href="admin-logout.jsp" class="nav-btn" style="background:#c62828;">Logout</a>
    </div>
</header>

<div class="container">

    <div class="page-title-box">
        <div>
            <h1>📦 Customer Orders</h1>
            <p style="color:#666; margin-top:4px;">View customer orders and manage fulfillment status</p>
        </div>
    </div>

    <% if ("status_updated".equals(msg)) { %>
        <div class="alert-success">✅ Order status updated successfully!</div>
    <% } else if (error != null && !error.isEmpty()) { %>
        <div class="alert-error">⚠️ Error: <%= error.replace("_", " ") %></div>
    <% } %>

    <%
        if (orders == null || orders.isEmpty()) {
    %>
        <div class="empty-state">
            <div style="font-size:50px; margin-bottom:12px;">📦</div>
            <h3>No Customer Orders Found</h3>
            <p>Customer orders will appear here as soon as orders are placed.</p>
        </div>
    <%
        } else {
            for (Order order : orders) {
                String currentStatus = order.getStatus() != null ? order.getStatus() : "Order Placed";
                boolean isCancelled = "Cancelled".equalsIgnoreCase(currentStatus);
                boolean isDelivered = "Delivered".equalsIgnoreCase(currentStatus);
    %>

    <div class="order-card <%= isCancelled ? "status-cancelled" : (isDelivered ? "status-delivered" : "") %>">

        <div class="order-header">
            <div class="order-id">
                Order ID: #<%= order.getOrderId() %>
            </div>
            <div>
                <span class="status-badge <%= isCancelled ? "cancelled" : "" %>">
                    📦 <%= currentStatus %>
                </span>
            </div>
        </div>

        <div class="order-grid">

            <div class="info-box">
                <div class="info-label">Customer Name</div>
                <div class="info-value"><%= order.getCustomerName() != null ? order.getCustomerName() : "-" %></div>
            </div>

            <div class="info-box">
                <div class="info-label">User Email</div>
                <div class="info-value"><%= order.getUserEmail() != null ? order.getUserEmail() : "-" %></div>
            </div>

            <div class="info-box">
                <div class="info-label">Phone & City</div>
                <div class="info-value">
                    <%= order.getPhone() != null ? order.getPhone() : "" %>
                    <%= (order.getCity() != null && !order.getCity().isEmpty()) ? " (" + order.getCity() + ")" : "" %>
                </div>
            </div>

            <div class="info-box">
                <div class="info-label">Delivery Pincode</div>
                <div class="info-value"><%= order.getPincode() != null ? order.getPincode() : "-" %></div>
            </div>

            <div class="info-box" style="grid-column: span 2;">
                <div class="info-label">Shipping Address</div>
                <div class="info-value"><%= order.getAddress() != null ? order.getAddress() : "-" %></div>
            </div>

            <div class="info-box">
                <div class="info-label">Order Date & Time</div>
                <div class="info-value"><%= order.getOrderDate() != null ? order.getOrderDate().toString() : "-" %></div>
            </div>

            <div class="info-box">
                <div class="info-label">Payment & Total</div>
                <div class="info-value price">
                    ₹<%= String.format("%.2f", order.getTotal()) %>
                    <span style="font-size:12px; color:#555; font-weight:normal;">(<%= order.getPaymentMethod() %>)</span>
                </div>
            </div>

        </div>

        <div class="status-form-section">
            <div style="font-size:13px; color:#666;">
                Status updates immediately update the customer's order tracking timeline.
            </div>

            <form action="UpdateOrderStatusServlet" method="post" class="status-form">
                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

                <label style="font-size:13px; font-weight:bold;">Update Status:</label>
                <select name="status">
                    <option value="Order Placed" <%= "Order Placed".equals(currentStatus) ? "selected" : "" %>>Order Placed</option>
                    <option value="Packed" <%= "Packed".equals(currentStatus) ? "selected" : "" %>>Packed</option>
                    <option value="Shipped" <%= "Shipped".equals(currentStatus) ? "selected" : "" %>>Shipped</option>
                    <option value="Delivered" <%= "Delivered".equals(currentStatus) ? "selected" : "" %>>Delivered</option>
                    <option value="Cancelled" <%= "Cancelled".equals(currentStatus) ? "selected" : "" %>>Cancelled</option>
                </select>

                <button type="submit" class="btn-update">
                    Update
                </button>
            </form>
        </div>

    </div>

    <%
            }
        }
    %>

</div>

</body>
</html>