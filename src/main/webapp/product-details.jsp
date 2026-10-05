<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,com.greennest.DBConnection" %>

<%
    String idParam = request.getParameter("id");
    String nameParam = request.getParameter("name");

    int productId = 0;
    String productName = "Green Plant";
    String category = "Indoor";
    double price = 249.00;
    String description = "A healthy and vibrant plant to enhance your living space.";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();
        if (con != null) {
            if (idParam != null && !idParam.trim().isEmpty()) {
                ps = con.prepareStatement("SELECT id, name, category, price, description FROM products WHERE id = ?");
                ps.setInt(1, Integer.parseInt(idParam.trim()));
            } else if (nameParam != null && !nameParam.trim().isEmpty()) {
                ps = con.prepareStatement("SELECT id, name, category, price, description FROM products WHERE name = ?");
                ps.setString(1, nameParam.trim());
            } else {
                ps = con.prepareStatement("SELECT id, name, category, price, description FROM products LIMIT 1");
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                productId = rs.getInt("id");
                productName = rs.getString("name");
                category = rs.getString("category");
                price = rs.getDouble("price");
                description = rs.getString("description");
            }
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

    if (productName == null || productName.isEmpty()) {
        productName = "Plant";
    }
    if (description == null || description.isEmpty()) {
        description = "A wonderful plant to bring natural beauty and freshness to your environment.";
    }

    // Determine care guide info dynamically
    String nameLower = productName.toLowerCase();
    String catLower = (category != null ? category.toLowerCase() : "");

    String emoji = "🌿";
    String sunlight = "Bright indirect sunlight";
    String watering = "Once every 5–7 days when topsoil is dry";
    String soil = "Well-draining nutrient-rich soil";
    String temperature = "18°C – 30°C";
    String difficulty = "Easy";

    if (nameLower.contains("rose")) {
        emoji = "🌹";
        sunlight = "5–6 hours of direct morning sunlight";
        watering = "Once every 2–3 days";
        soil = "Rich well-draining loamy soil";
        temperature = "18°C – 30°C";
        difficulty = "Medium";
    } else if (nameLower.contains("snake")) {
        emoji = "🌿";
        sunlight = "Low to bright indirect light";
        watering = "Once every 10–14 days";
        soil = "Well-draining potting mix";
        temperature = "15°C – 32°C";
        difficulty = "Very Easy";
    } else if (nameLower.contains("money")) {
        emoji = "🌱";
        sunlight = "Medium to bright indirect light";
        watering = "Once every 5–7 days";
        soil = "Moist, well-draining soil";
        temperature = "18°C – 30°C";
        difficulty = "Easy";
    } else if (nameLower.contains("aloe")) {
        emoji = "🌵";
        sunlight = "Direct to bright sunlight";
        watering = "Once every 12–15 days";
        soil = "Cactus & succulent sandy mix";
        temperature = "18°C – 35°C";
        difficulty = "Easy";
    } else if (nameLower.contains("lily")) {
        emoji = "🪴";
        sunlight = "Moderate indirect light";
        watering = "Once every 4–6 days";
        soil = "Moist organic rich soil";
        temperature = "18°C – 28°C";
        difficulty = "Easy";
    } else if (nameLower.contains("palm")) {
        emoji = "🌴";
        sunlight = "Bright indirect sunlight";
        watering = "Once every 5–7 days";
        soil = "Well-draining fertile mix";
        temperature = "20°C – 32°C";
        difficulty = "Easy";
    } else if (nameLower.contains("hibiscus")) {
        emoji = "🌺";
        sunlight = "6+ hours of full sun";
        watering = "Daily during summer, 2-3 days otherwise";
        soil = "Fertile slightly acidic soil";
        temperature = "20°C – 35°C";
        difficulty = "Medium";
    } else if (catLower.contains("succulent")) {
        emoji = "🌵";
        sunlight = "Full sun to bright light";
        watering = "Once every 10–14 days";
        soil = "Gritty well-draining succulent soil";
        temperature = "18°C – 35°C";
        difficulty = "Easy";
    } else if (catLower.contains("flowering") || catLower.contains("flower")) {
        emoji = "🌸";
        sunlight = "4–6 hours of sunlight daily";
        watering = "Once every 2–3 days";
        soil = "Rich garden soil with organic compost";
        temperature = "18°C – 30°C";
        difficulty = "Medium";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= productName %> | GreenNest</title>
    <link rel="stylesheet" href="css/style.css">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f8faf6;
            color: #263a2c;
        }

        .product-page {
            padding: 40px 8%;
            min-height: 100vh;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 25px;
            text-decoration: none;
            color: #2f7545;
            font-weight: 700;
            font-size: 15px;
        }

        .back-btn:hover {
            text-decoration: underline;
        }

        .product-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            background: white;
            padding: 40px;
            border-radius: 18px;
            box-shadow: 0 10px 30px rgba(40,80,45,0.08);
            border: 1px solid #eef2ed;
        }

        .product-image {
            min-height: 420px;
            background: #edf5eb;
            border-radius: 14px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 150px;
        }

        .badge-tag {
            display: inline-block;
            background: #e8f5e9;
            color: #2e7d32;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 12px;
        }

        .product-info h1 {
            font-size: 38px;
            margin: 0 0 12px;
            color: #176b2f;
        }

        .price {
            font-size: 30px;
            font-weight: 800;
            color: #37804d;
            margin-bottom: 20px;
        }

        .description {
            font-size: 16px;
            line-height: 1.6;
            color: #4f5d52;
            margin-bottom: 25px;
        }

        .care-box {
            background: #f4fbf3;
            padding: 22px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 1px solid #e2f0e0;
        }

        .care-box h2 {
            margin-top: 0;
            font-size: 18px;
            color: #176b2f;
            margin-bottom: 15px;
        }

        .care-item {
            margin: 10px 0;
            font-size: 14px;
            color: #4d5b50;
        }

        .care-item strong {
            color: #365d40;
        }

        .add-cart-btn {
            border: none;
            background: #2f7545;
            color: white;
            padding: 14px 32px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s;
        }

        .add-cart-btn:hover {
            background: #245d36;
        }

        @media(max-width: 850px) {
            .product-container {
                grid-template-columns: 1fr;
            }
            .product-image {
                min-height: 300px;
                font-size: 110px;
            }
            .product-info h1 {
                font-size: 30px;
            }
        }
    </style>
</head>

<body>

    <section class="product-page">

        <a href="plants.jsp" class="back-btn">
            ← Back to Plants Collection
        </a>

        <div class="product-container">

            <!-- PRODUCT IMAGE -->
            <div class="product-image">
                <%= emoji %>
            </div>

            <!-- PRODUCT INFORMATION -->
            <div class="product-info">

                <span class="badge-tag">🌿 <%= category != null ? category : "Plant" %></span>

                <h1><%= productName %></h1>

                <div class="price">
                    ₹<%= String.format("%.2f", price) %>
                </div>

                <p class="description">
                    <%= description %>
                </p>

                <!-- PLANT CARE -->
                <div class="care-box">
                    <h2>🌱 Plant Care Guide</h2>

                    <div class="care-item">
                        🌞 <strong>Sunlight:</strong> <%= sunlight %>
                    </div>

                    <div class="care-item">
                        💧 <strong>Watering:</strong> <%= watering %>
                    </div>

                    <div class="care-item">
                        🌱 <strong>Soil:</strong> <%= soil %>
                    </div>

                    <div class="care-item">
                        🌡️ <strong>Temperature:</strong> <%= temperature %>
                    </div>

                    <div class="care-item">
                        🌿 <strong>Care Level:</strong> <%= difficulty %>
                    </div>
                </div>

                <!-- ADD TO CART -->
                <button
                    class="add-cart-btn"
                    onclick="addToCart('<%= productName.replace("'", "\\'") %>', <%= price %>)">
                    🛒 Add to Cart
                </button>

            </div>

        </div>

    </section>

    <script>
        function addToCart(name, price) {
            let cart = [];
            try {
                cart = JSON.parse(localStorage.getItem("greenNestCart")) || [];
            } catch (e) {
                cart = [];
            }

            let existingItem = cart.find(item => item.name === name);

            if (existingItem) {
                existingItem.quantity = (parseInt(existingItem.quantity, 10) || 1) + 1;
            } else {
                cart.push({
                    name: name,
                    price: Number(price),
                    quantity: 1
                });
            }

            localStorage.setItem("greenNestCart", JSON.stringify(cart));
            alert("🌿 " + name + " added to your cart!");
            window.location.href = "cart.jsp";
        }
    </script>

</body>
</html>