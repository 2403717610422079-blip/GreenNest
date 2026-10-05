<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userName = (String) session.getAttribute("userName");
    if (userName != null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String error = request.getParameter("error");
    String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Login - GreenNest</title>
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
            max-width: 450px;
            margin: 60px auto;
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
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
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

        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 11px 14px;
            border-radius: 7px;
            text-align: left;
            margin-bottom: 20px;
            font-size: 13px;
            font-weight: bold;
            border: 1px solid #c8e6c9;
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
        <a href="register.jsp">Register</a>
    </div>
</nav>

<div class="auth-container">

    <div class="auth-box">

        <h1 class="auth-title">🌱 Customer Login</h1>

        <% if ("registered".equals(msg)) { %>
            <div class="alert-success">✅ Registration successful! Please log in to continue.</div>
        <% } %>

        <% if ("invalid".equals(error)) { %>
            <div class="alert-error">⚠️ Invalid email or password! Please check your credentials.</div>
        <% } else if ("login_required".equals(error)) { %>
            <div class="alert-error">⚠️ Please login first to access checkout and orders.</div>
        <% } else if ("empty_fields".equals(error)) { %>
            <div class="alert-error">⚠️ Please fill in all required fields.</div>
        <% } else if (error != null && !error.isEmpty()) { %>
            <div class="alert-error">⚠️ Error: <%= error.replace("_", " ") %></div>
        <% } %>

        <form action="LoginServlet" method="post">

            <div class="form-group">
                <label for="email">Email Address</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Enter your email"
                    required
                >
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter your password"
                    required
                >
            </div>

            <button type="submit" class="auth-btn">
                Log In
            </button>

        </form>

        <div class="auth-link">
            Don't have an account?
            <a href="register.jsp">Register here</a>
        </div>

        <div class="auth-link" style="margin-top:12px; font-size:12px;">
            Store Manager? <a href="admin-login.jsp">Admin Portal</a>
        </div>

    </div>

</div>

</body>
</html>