<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    Object idObj = request.getAttribute("id");
    String id = idObj != null ? String.valueOf(idObj) : request.getParameter("id");
    String name = (String) request.getAttribute("name");
    String category = (String) request.getAttribute("category");
    Object priceObj = request.getAttribute("price");
    String price = priceObj != null ? String.valueOf(priceObj) : "";
    String description = (String) request.getAttribute("description");

    if (id == null || id.isEmpty()) {
        response.sendRedirect("ManageProductsServlet");
        return;
    }

    if (name == null) name = "";
    if (category == null) category = "";
    if (description == null) description = "";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Plant - GreenNest Admin</title>

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

        .update-btn {
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

        .update-btn:hover {
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

        <h2 class="title">✏️ Edit Plant Details</h2>

        <form action="EditProductServlet" method="post">

            <!-- Product ID -->
            <input type="hidden" name="id" value="<%= id %>">

            <label for="name">Plant Name</label>
            <input type="text"
                   id="name"
                   name="name"
                   value="<%= name %>"
                   placeholder="Enter plant name"
                   required>

            <label for="category">Category</label>
            <select id="category" name="category" required>
                <option value="">Select Category</option>
                <option value="Indoor" <%= "Indoor".equalsIgnoreCase(category) ? "selected" : "" %>>Indoor</option>
                <option value="Outdoor" <%= "Outdoor".equalsIgnoreCase(category) ? "selected" : "" %>>Outdoor</option>
                <option value="Flowering" <%= "Flowering".equalsIgnoreCase(category) || "Flower".equalsIgnoreCase(category) ? "selected" : "" %>>Flowering</option>
                <option value="Succulent" <%= "Succulent".equalsIgnoreCase(category) ? "selected" : "" %>>Succulent</option>
                <option value="Balcony" <%= "Balcony".equalsIgnoreCase(category) ? "selected" : "" %>>Balcony</option>
                <option value="Fruit" <%= "Fruit".equalsIgnoreCase(category) ? "selected" : "" %>>Fruit</option>
                <option value="Vegetable" <%= "Vegetable".equalsIgnoreCase(category) ? "selected" : "" %>>Vegetable</option>
                <option value="Beginner" <%= "Beginner".equalsIgnoreCase(category) ? "selected" : "" %>>Beginner</option>
            </select>

            <label for="price">Price (₹)</label>
            <input type="number"
                   id="price"
                   name="price"
                   step="0.01"
                   min="0"
                   value="<%= price %>"
                   placeholder="Enter price"
                   required>

            <label for="description">Description</label>
            <textarea id="description"
                      name="description"
                      placeholder="Enter plant description"><%= description %></textarea>

            <button type="submit" class="update-btn">
                💾 Save & Update Plant
            </button>

        </form>

        <a href="ManageProductsServlet" class="back-btn">
            ← Cancel and Return
        </a>

    </div>

</body>
</html>