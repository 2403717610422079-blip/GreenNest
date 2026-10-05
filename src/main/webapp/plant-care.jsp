<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userName = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Plant Care Guide - GreenNest</title>
<link rel="stylesheet" href="css/style.css">

<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

body {
    background: #f5fff5;
    color: #263a2c;
}

/* HERO */
.hero {
    text-align: center;
    padding: 50px 20px;
    background: linear-gradient(135deg, #e8f5e9, #c8e6c9);
}

.hero h1 {
    font-size: 38px;
    color: #1b5e20;
    margin-bottom: 10px;
}

.hero p {
    font-size: 16px;
    color: #555;
}

/* CARE CARDS */
.care-container {
    max-width: 1100px;
    margin: 40px auto;
    padding: 0 20px;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 25px;
}

.care-card {
    background: white;
    padding: 28px;
    border-radius: 14px;
    text-align: center;
    box-shadow: 0 5px 15px rgba(0,0,0,0.06);
    transition: 0.3s;
    border: 1px solid #eef2ed;
}

.care-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(46,125,50,0.12);
}

.icon {
    font-size: 45px;
    margin-bottom: 15px;
}

.care-card h2 {
    color: #2e7d32;
    margin-bottom: 12px;
    font-size: 20px;
}

.care-card p {
    line-height: 1.6;
    color: #555;
    font-size: 14px;
}

/* TIPS */
.tips {
    max-width: 1000px;
    margin: 40px auto 60px;
    padding: 35px;
    background: white;
    border-radius: 14px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.06);
    border: 1px solid #eef2ed;
}

.tips h2 {
    text-align: center;
    color: #1b5e20;
    margin-bottom: 25px;
    font-size: 24px;
}

.tips ul {
    padding-left: 25px;
}

.tips li {
    margin-bottom: 15px;
    line-height: 1.6;
    font-size: 15px;
    color: #444;
}

@media(max-width: 800px) {
    .care-container {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<header class="navbar">
    <div class="logo">
        <a href="index.jsp" style="color:white; text-decoration:none;">🌱 GreenNest</a>
    </div>

    <nav class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="plants.jsp">Plants</a>
        <a href="plant-care.jsp" class="active">Plant Care</a>
        <% if (userName != null) { %>
            <a href="MyOrdersServlet">🧾 My Orders</a>
        <% } %>
    </nav>

    <div class="nav-actions">
        <% if (userName != null) { %>
            <span class="welcome-user">👋 Welcome, <%= userName %></span>
            <a href="logout.jsp" class="login-btn">Logout</a>
        <% } else { %>
            <a href="login.jsp" class="login-btn">Login</a>
            <a href="register.jsp" class="login-btn" style="background:#2e7d32;">Register</a>
        <% } %>
        <a href="cart.jsp" class="cart-btn">🛒 Cart</a>
    </div>
</header>

<!-- HERO -->
<section class="hero">
    <h1>🌱 Plant Care Guide</h1>
    <p>Simple and practical tips to keep your plants vibrant, healthy, and thriving.</p>
</section>

<!-- CARE CARDS -->
<div class="care-container">

    <div class="care-card">
        <div class="icon">💧</div>
        <h2>Watering Wisdom</h2>
        <p>Water your plants when the top 1–2 inches of soil feel dry. Overwatering is the #1 cause of root problems—always ensure excess water can drain freely.</p>
    </div>

    <div class="care-card">
        <div class="icon">☀️</div>
        <h2>Sunlight Requirements</h2>
        <p>Most indoor houseplants prefer bright, filtered or indirect sunlight. Outdoor flowering plants and fruits generally require 5–6 hours of direct morning sun.</p>
    </div>

    <div class="care-card">
        <div class="icon">🪴</div>
        <h2>Potting & Soil Mix</h2>
        <p>Use well-draining soil with organic compost and perlite. Choose a pot with drainage holes at the bottom to maintain adequate aeration for roots.</p>
    </div>

    <div class="care-card">
        <div class="icon">🌿</div>
        <h2>Seasonal Feeding</h2>
        <p>Apply organic fertilizer or balanced liquid feed during active growing seasons (Spring & Summer). Reduce feeding during winter dormant months.</p>
    </div>

    <div class="care-card">
        <div class="icon">✂️</div>
        <h2>Pruning & Grooming</h2>
        <p>Snip yellow or damaged leaves regularly to encourage fresh growth and maintain a neat, bushy plant shape.</p>
    </div>

    <div class="care-card">
        <div class="icon">🐛</div>
        <h2>Natural Pest Control</h2>
        <p>Inspect under leaf surfaces once a week. Use diluted neem oil spray or mild soapy water to ward off aphids and spider mites naturally.</p>
    </div>

</div>

<!-- QUICK TIPS -->
<section class="tips">
    <h2>🌿 Quick Daily Habits for Healthy Plants</h2>
    <ul>
        <li>💧 <strong>Finger Test:</strong> Always touch the soil before watering; if it feels damp, wait another day or two.</li>
        <li>☀️ <strong>Light Rotation:</strong> Rotate indoor pots 90 degrees every week so all sides receive equal light.</li>
        <li>🪴 <strong>Repotting:</strong> Repot into a container 1–2 inches larger only when roots start circling the bottom.</li>
        <li>🌿 <strong>Dusting:</strong> Gently wipe wide plant leaves with a soft damp cloth to allow maximum photosynthesis.</li>
        <li>🌱 <strong>Humidity:</strong> Group tropical plants together or mist them occasionally in dry, air-conditioned rooms.</li>
    </ul>
</section>

<footer style="background: #1b5e20; color: white; text-align: center; padding: 25px;">
    <p>© 2026 GreenNest | Plant and Plant-Care Marketplace 🌿</p>
</footer>

</body>
</html>