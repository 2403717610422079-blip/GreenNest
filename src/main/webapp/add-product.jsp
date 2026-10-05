<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Plant - GreenNest Admin</title>

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
        }

        .header {
            background: #2e7d32;
            color: white;
            padding: 18px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header h2 {
            font-size: 22px;
        }

        .nav-btn {
            background: #1b5e20;
            color: white;
            text-decoration: none;
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
        }

        .container {
            width: 90%;
            max-width: 520px;
            margin: 40px auto;
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
        }

        h2.title {
            color: #2e7d32;
            text-align: center;
            margin-bottom: 25px;
        }

        .alert-error {
            background: #ffebee;
            color: #c62828;
            border: 1px solid #ffcdd2;
            padding: 12px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 14px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 6px;
            font-weight: bold;
            font-size: 14px;
            color: #333;
        }

        input, select, textarea {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: 0.2s;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #2e7d32;
        }

        textarea {
            height: 100px;
            resize: vertical;
        }

        .add-btn {
            width: 100%;
            padding: 13px;
            margin-top: 25px;
            background: #2e7d32;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.2s;
        }

        .add-btn:hover {
            background: #1b5e20;
        }

        .back-btn {
            display: block;
            text-align: center;
            margin-top: 18px;
            color: #2e7d32;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }

        .back-btn:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <div class="header">
        <h2>🌿 GreenNest Admin Panel</h2>
        <a href="ManageProductsServlet" class="nav-btn">← Back to Plants</a>
    </div>

    <div class="container">

        <h2 class="title">🌿 Add New Plant</h2>

        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert-error">⚠️ Error: <%= error.replace("_", " ") %></div>
        <% } %>

        <form action="AddProductServlet" method="post">

            <label for="name">Plant Name</label>
            <input type="text"
                   id="name"
                   name="name"
                   placeholder="e.g. Fiddle Leaf Fig"
                   required>

            <label for="category">Category</label>
            <select id="category" name="category" required>
                <option value="">Select Category</option>
                <option value="Indoor">Indoor</option>
                <option value="Outdoor">Outdoor</option>
                <option value="Flowering">Flowering</option>
                <option value="Succulent">Succulent</option>
                <option value="Balcony">Balcony</option>
                <option value="Fruit">Fruit</option>
                <option value="Vegetable">Vegetable</option>
                <option value="Beginner">Beginner</option>
            </select>

            <label for="price">Price (₹)</label>
            <input type="number"
                   id="price"
                   name="price"
                   step="0.01"
                   min="0"
                   placeholder="e.g. 299.00"
                   required>

            <label for="description">Description</label>
            <textarea id="description"
                      name="description"
                      placeholder="Enter a brief description of the plant..."></textarea>

            <button type="submit" class="add-btn">
                🌱 Add Plant to Catalog
            </button>

        </form>

        <a href="ManageProductsServlet" class="back-btn">
            ← Cancel and Return
        </a>

    </div>

</body>
</html>