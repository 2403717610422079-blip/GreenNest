<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String orderId = (String) session.getAttribute("orderId");
    String orderTotal = (String) session.getAttribute("orderTotal");
    String customerName = (String) session.getAttribute("customerName");

    if (orderId == null) {
        response.sendRedirect("plants.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Successful - GreenNest</title>
    <link rel="stylesheet" href="css/style.css">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f5f8f3;
            color: #263a2c;
        }

        .success-box {
            width: 90%;
            max-width: 600px;
            margin: 60px auto;
            background: white;
            padding: 45px 35px;
            text-align: center;
            border-radius: 16px;
            box-shadow: 0 6px 25px rgba(46,125,50,0.1);
            border: 1px solid #eef2ed;
        }

        .success-icon {
            font-size: 65px;
            margin-bottom: 15px;
        }

        h1 {
            color: #2e7d32;
            font-size: 28px;
            margin-bottom: 12px;
        }

        .message {
            color: #555;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .order-details {
            background: #f1f8e9;
            padding: 22px;
            border-radius: 12px;
            text-align: left;
            margin-bottom: 30px;
            border: 1px solid #dcedc8;
        }

        .row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e0edd0;
            font-size: 15px;
        }

        .row:last-child {
            border-bottom: none;
            font-size: 17px;
            font-weight: bold;
            color: #2e7d32;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: #2e7d32;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
            font-size: 14px;
            transition: 0.2s;
        }

        .btn:hover {
            background: #1b5e20;
        }

        .btn-outline {
            background: white;
            color: #2e7d32;
            border: 2px solid #2e7d32;
        }

        .btn-outline:hover {
            background: #2e7d32;
            color: white;
        }
    </style>
</head>

<body>

    <div class="success-box">

        <div class="success-icon">🎉</div>

        <h1>Order Placed Successfully!</h1>

        <p class="message">
            Thank you, <strong><%= customerName != null ? customerName : "Customer" %></strong>!
            Your GreenNest order has been confirmed and is being processed with care.
        </p>

        <div class="order-details">
            <div class="row">
                <strong>Order ID</strong>
                <span>#<%= orderId %></span>
            </div>

            <div class="row">
                <strong>Status</strong>
                <span>🌱 Order Placed</span>
            </div>

            <div class="row">
                <strong>Total Amount</strong>
                <span>₹<%= orderTotal %></span>
            </div>
        </div>

        <div class="btn-group">
            <a href="MyOrdersServlet" class="btn">
                🧾 Track in My Orders
            </a>

            <a href="plants.jsp" class="btn btn-outline">
                🌱 Shop More Plants
            </a>

            <a href="index.jsp" class="btn btn-outline">
                🏠 Home
            </a>
        </div>

    </div>

    <script>
        // Clear customer cart from localStorage after successful order placement
        localStorage.removeItem("greenNestCart");
        localStorage.removeItem("greenNestOrder");
    </script>

</body>
</html>