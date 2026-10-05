<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("adminId") != null) {
        response.sendRedirect("admin-dashboard.jsp");
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
    <title>Admin Login - GreenNest</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f1f8f3;
            color: #263a2c;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            background: #2e7d32;
            color: white;
            padding: 18px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .navbar .logo {
            font-size: 22px;
            font-weight: bold;
            color: white;
            text-decoration: none;
        }

        .navbar a.store-link {
            color: white;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }

        .login-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .login-box {
            width: 100%;
            max-width: 400px;
            background: white;
            padding: 40px 35px;
            border-radius: 14px;
            box-shadow: 0 6px 22px rgba(0,0,0,0.08);
            text-align: center;
        }

        .login-box .icon {
            font-size: 45px;
            margin-bottom: 12px;
        }

        .login-box h2 {
            color: #2e7d32;
            font-size: 24px;
            margin-bottom: 8px;
        }

        .login-box p.subtitle {
            color: #666;
            font-size: 14px;
            margin-bottom: 25px;
        }

        .alert-error {
            background: #ffebee;
            color: #c62828;
            border: 1px solid #ffcdd2;
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: left;
        }

        .alert-success {
            background: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #c8e6c9;
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group {
            text-align: left;
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            font-size: 13px;
            color: #444;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: 0.2s;
        }

        input:focus {
            border-color: #2e7d32;
            box-shadow: 0 0 0 2px rgba(46,125,50,0.15);
        }

        button {
            width: 100%;
            padding: 13px;
            margin-top: 10px;
            background: #2e7d32;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            transition: 0.2s;
        }

        button:hover {
            background: #1b5e20;
        }

        .footer-note {
            margin-top: 25px;
            font-size: 12px;
            color: #888;
        }
    </style>
</head>

<body>

<nav class="navbar">
    <a href="index.jsp" class="logo">🌿 GreenNest</a>
    <a href="index.jsp" class="store-link">← Back to Store</a>
</nav>

<div class="login-wrapper">

    <div class="login-box">

        <div class="icon">🔐</div>
        <h2>Admin Portal</h2>
        <p class="subtitle">Secure administrative access to GreenNest</p>

        <% if ("invalid".equals(error)) { %>
            <div class="alert-error">⚠️ Invalid admin email or password!</div>
        <% } else if ("logged_out".equals(msg)) { %>
            <div class="alert-success">✅ You have been logged out successfully.</div>
        <% } else if (error != null && !error.isEmpty()) { %>
            <div class="alert-error">⚠️ Error: <%= error.replace("_", " ") %></div>
        <% } %>

        <form action="AdminLoginServlet" method="post">

            <div class="form-group">
                <label for="email">Admin Email</label>
                <input type="email"
                       id="email"
                       name="email"
                       placeholder="admin@greennest.com"
                       required>
            </div>

            <div class="form-group">
                <label for="password">Admin Password</label>
                <input type="password"
                       id="password"
                       name="password"
                       placeholder="••••••••"
                       required>
            </div>

            <button type="submit">Log In to Dashboard</button>

        </form>

        <div class="footer-note">
            GreenNest Internal Management System
        </div>

    </div>

</div>

</body>
</html>