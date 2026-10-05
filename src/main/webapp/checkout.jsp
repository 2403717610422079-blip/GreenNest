<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    String userName = (String) session.getAttribute("userName");

    if (userEmail == null) {
        response.sendRedirect("login.jsp?error=login_required");
        return;
    }

    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - GreenNest</title>
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

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 40px auto;
        }

        h1.page-title {
            text-align: center;
            color: #2e7d32;
            margin-bottom: 25px;
            font-size: 32px;
        }

        .alert-error {
            background: #ffebee;
            color: #c62828;
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
            border: 1px solid #ffcdd2;
        }

        .checkout-box {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }

        .form-box,
        .summary-box {
            background: white;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            border: 1px solid #eef2ed;
        }

        .form-box h2,
        .summary-box h2 {
            color: #2e7d32;
            margin-bottom: 20px;
            font-size: 20px;
            border-bottom: 2px solid #e8f5e9;
            padding-bottom: 10px;
        }

        label {
            display: block;
            margin-top: 14px;
            margin-bottom: 6px;
            font-weight: bold;
            font-size: 14px;
            color: #444;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: 0.2s;
        }

        input:focus,
        textarea:focus,
        select:focus {
            border-color: #2e7d32;
            box-shadow: 0 0 0 2px rgba(46,125,50,0.15);
        }

        textarea {
            height: 85px;
            resize: vertical;
        }

        .payment-options-grid {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 12px;
        }

        .payment-option {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.2s;
        }

        .payment-option:hover {
            border-color: #2e7d32;
            background: #f8faf7;
        }

        .payment-option input {
            width: auto;
            margin-right: 12px;
            cursor: pointer;
        }

        .payment-option label {
            margin: 0;
            cursor: pointer;
            font-weight: 600;
        }

        .place-order-btn {
            width: 100%;
            margin-top: 25px;
            padding: 15px;
            border: none;
            border-radius: 8px;
            background: #2e7d32;
            color: white;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .place-order-btn:hover {
            background: #1b5e20;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
            font-size: 15px;
        }

        .total-row {
            font-size: 22px;
            font-weight: bold;
            color: #2e7d32;
            border-bottom: none;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 2px solid #e8f5e9;
        }

        @media (max-width: 768px) {
            .checkout-box {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<header class="navbar">
    <div class="logo">
        <a href="index.jsp" style="color:white; text-decoration:none;">🌱 GreenNest</a>
    </div>

    <nav class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="plants.jsp">Plants</a>
        <a href="plant-care.jsp">Plant Care</a>
        <a href="MyOrdersServlet">🧾 My Orders</a>
    </nav>

    <div class="nav-actions">
        <span class="welcome-user">👋 Welcome, <%= userName != null ? userName : "Customer" %></span>
        <a href="logout.jsp" class="login-btn">Logout</a>
        <a href="cart.jsp" class="cart-btn">🛒 Cart</a>
    </div>
</header>

<div class="container">

    <h1 class="page-title">🛍️ Secure Checkout</h1>

    <% if (error != null && !error.isEmpty()) { %>
        <div class="alert-error">⚠️ <%= error.replace("_", " ") %></div>
    <% } %>

    <div class="checkout-box">

        <!-- CUSTOMER & DELIVERY DETAILS -->
        <div class="form-box">
            <h2>📦 Shipping & Delivery Address</h2>

            <form id="checkoutForm" action="OrderServlet" method="post">

                <label for="name">Full Name</label>
                <input
                    type="text"
                    id="name"
                    name="name"
                    value="<%= userName != null ? userName : "" %>"
                    placeholder="Enter recipient full name"
                    required
                >

                <label for="phone">Phone Number (10 digits)</label>
                <input
                    type="tel"
                    id="phone"
                    name="phone"
                    placeholder="10-digit mobile number"
                    pattern="[0-9]{10}"
                    maxlength="10"
                    required
                >

                <label for="address">Street / Door Address</label>
                <textarea
                    id="address"
                    name="address"
                    placeholder="House/flat no., street name, landmark"
                    required
                ></textarea>

                <div style="display:grid; grid-template-columns: 1fr 1fr; gap:15px;">
                    <div>
                        <label for="city">City</label>
                        <input
                            type="text"
                            id="city"
                            name="city"
                            placeholder="City / Town"
                            required
                        >
                    </div>

                    <div>
                        <label for="pincode">Pincode (6 digits)</label>
                        <input
                            type="text"
                            id="pincode"
                            name="pincode"
                            placeholder="6-digit pincode"
                            pattern="[0-9]{6}"
                            maxlength="6"
                            required
                        >
                    </div>
                </div>

                <h2 style="margin-top:30px;">💳 Payment Method</h2>

                <div class="payment-options-grid">

                    <div class="payment-option">
                        <input
                            type="radio"
                            id="cod"
                            name="payment"
                            value="Cash on Delivery"
                            checked
                            required
                        >
                        <label for="cod">💵 Cash on Delivery (COD)</label>
                    </div>

                    <div class="payment-option">
                        <input
                            type="radio"
                            id="upi"
                            name="payment"
                            value="UPI"
                        >
                        <label for="upi">📱 UPI / Google Pay / PhonePe</label>
                    </div>

                    <div class="payment-option">
                        <input
                            type="radio"
                            id="card"
                            name="payment"
                            value="Credit/Debit Card"
                        >
                        <label for="card">💳 Credit / Debit Card</label>
                    </div>

                </div>

                <!-- HIDDEN ORDER TOTAL -->
                <input type="hidden" id="totalInput" name="total" value="0.00">

                <button type="submit" class="place-order-btn">
                    🌿 Confirm & Place Order
                </button>

            </form>
        </div>

        <!-- ORDER SUMMARY -->
        <div class="summary-box">
            <h2>🧾 Order Summary</h2>

            <div id="cartItemsList" style="margin-bottom:15px; max-height:220px; overflow-y:auto;"></div>

            <div class="summary-row">
                <span>Total Items</span>
                <span id="totalItems" style="font-weight:bold;">0</span>
            </div>

            <div class="summary-row">
                <span>Delivery Charges</span>
                <span style="color:#2e7d32; font-weight:bold;">FREE 🌱</span>
            </div>

            <div class="summary-row total-row">
                <span>Grand Total</span>
                <span>₹<span id="totalPrice">0.00</span></span>
            </div>

            <div style="margin-top:20px; font-size:12px; color:#777; text-align:center;">
                🔒 Secure 256-bit encrypted checkout
            </div>
        </div>

    </div>

</div>

<script>
    let cart = [];
    try {
        cart = JSON.parse(localStorage.getItem("greenNestCart")) || [];
    } catch(e) {
        cart = [];
    }

    function calculateCheckout() {
        let total = 0;
        let items = 0;
        let listContainer = document.getElementById("cartItemsList");
        listContainer.innerHTML = "";

        if (cart.length === 0) {
            listContainer.innerHTML = "<p style='color:#777; text-align:center;'>Your cart is empty.</p>";
            document.getElementById("totalItems").innerText = "0";
            document.getElementById("totalPrice").innerText = "0.00";
            document.getElementById("totalInput").value = "0.00";
            return;
        }

        cart.forEach(function(item) {
            let price = Number(item.price) || 0;
            let qty = parseInt(item.quantity, 10) || 1;
            let itemSub = price * qty;

            total += itemSub;
            items += qty;

            let row = document.createElement("div");
            row.className = "summary-item";
            row.innerHTML = "<span>" + item.name + " × " + qty + "</span><strong>₹" + itemSub.toFixed(2) + "</strong>";
            listContainer.appendChild(row);
        });

        document.getElementById("totalItems").innerText = items;
        document.getElementById("totalPrice").innerText = total.toFixed(2);
        document.getElementById("totalInput").value = total.toFixed(2);
    }

    calculateCheckout();

    document.getElementById("checkoutForm").addEventListener("submit", function(event) {
        if (cart.length === 0) {
            event.preventDefault();
            alert("Your cart is empty! Please add plants before placing an order.");
            window.location.href = "plants.jsp";
        }
    });
</script>

</body>
</html>