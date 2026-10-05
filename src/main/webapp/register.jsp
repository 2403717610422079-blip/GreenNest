<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userName = (String) session.getAttribute("userName");
    if (userName != null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration - GreenNest</title>
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

        .auth-container {
            width: 90%;
            max-width: 480px;
            margin: 50px auto;
        }

        .auth-box {
            background: white;
            padding: 40px 35px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            border: 1px solid #eef2ed;
        }

        .auth-title {
            text-align: center;
            color: #2e7d32;
            margin-bottom: 25px;
            font-size: 26px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 7px;
            font-size: 14px;
            outline: none;
            transition: 0.2s;
        }

        .form-group input:focus {
            border-color: #2e7d32;
            box-shadow: 0 0 0 2px rgba(46,125,50,0.15);
        }

        .auth-btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 7px;
            background: #2e7d32;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
            margin-top: 10px;
        }

        .auth-btn:hover {
            background: #1b5e20;
        }

        .auth-link {
            text-align: center;
            margin-top: 22px;
            font-size: 14px;
            color: #555;
        }

        .auth-link a {
            color: #2e7d32;
            font-weight: bold;
            text-decoration: none;
        }

        .auth-link a:hover {
            text-decoration: underline;
        }

        .alert-error {
            background: #ffebee;
            color: #c62828;
            padding: 11px 14px;
            border-radius: 7px;
            text-align: left;
            margin-bottom: 20px;
            font-size: 13px;
            font-weight: bold;
            border: 1px solid #ffcdd2;
        }
    </style>
</head>

<body>

<nav class="navbar">
    <div class="logo">
        <a href="index.jsp" style="color:white; text-decoration:none;">🌱 GreenNest</a>
    </div>

    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="plants.jsp">Plants</a>
        <a href="cart.jsp">🛒 Cart</a>
        <a href="login.jsp">Login</a>
    </div>
</nav>

<div class="auth-container">

    <div class="auth-box">

        <h1 class="auth-title">🌱 Create an Account</h1>

        <% if ("duplicate_email".equals(error)) { %>
            <div class="alert-error">⚠️ An account with this email address already exists! Please log in instead.</div>
        <% } else if ("empty_fields".equals(error)) { %>
            <div class="alert-error">⚠️ Please fill in all required fields.</div>
        <% } else if (error != null && !error.isEmpty()) { %>
            <div class="alert-error">⚠️ Error: <%= error.replace("_", " ") %></div>
        <% } %>

        <form id="registerForm" action="RegisterServlet" method="post">

            <div class="form-group">
                <label for="name">Full Name</label>
                <input
                    type="text"
                    id="name"
                    name="name"
                    placeholder="Enter your full name"
                    required
                >
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Enter your email address"
                    required
                >
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input
                    type="tel"
                    id="phone"
                    name="phone"
                    placeholder="10-digit mobile number"
                    pattern="[0-9]{10}"
                    maxlength="10"
                    required
                >
            </div>

            <div class="form-group">
                <label for="password">Password (min 6 characters)</label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Create a password"
                    minlength="6"
                    required
                >
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input
                    type="password"
                    id="confirmPassword"
                    placeholder="Confirm your password"
                    minlength="6"
                    required
                >
            </div>

            <button type="submit" class="auth-btn">
                Register Account
            </button>

        </form>

        <div class="auth-link">
            Already have an account?
            <a href="login.jsp">Login here</a>
        </div>

    </div>

</div>

<script>
document.getElementById("registerForm").addEventListener("submit", function(event) {
    let password = document.getElementById("password").value;
    let confirmPassword = document.getElementById("confirmPassword").value;

    if (password.length < 6) {
        event.preventDefault();
        alert("Password must be at least 6 characters long!");
        return;
    }

    if (password !== confirmPassword) {
        event.preventDefault();
        alert("Passwords do not match!");
        return;
    }
});
</script>

</body>
</html>