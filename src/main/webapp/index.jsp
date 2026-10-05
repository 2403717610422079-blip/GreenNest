<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userName = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GreenNest | Plant and Plant Care</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <!-- ================= NAVBAR ================= -->
    <header class="navbar">
        <div class="logo">
            <a href="index.jsp" style="color:white; text-decoration:none;">🌱 GreenNest</a>
        </div>

        <nav class="nav-links">
            <a href="index.jsp" class="active">Home</a>
            <a href="plants.jsp">Plants</a>
            <a href="plant-care.jsp">Plant Care</a>
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

    <!-- ================= HERO SECTION ================= -->
    <section class="hero">
        <div class="hero-content">
            <p class="small-title">WELCOME TO GREENNEST 🌿</p>
            <h1>
                Bring Nature
                <span>Into Your Home</span>
            </h1>
            <p class="hero-text">
                Discover beautiful indoor and outdoor plants, care guides, and everything
                you need to create your own thriving green sanctuary.
            </p>

            <div class="hero-buttons">
                <a href="plants.jsp" class="primary-btn">
                    Shop Plants →
                </a>
                <a href="plant-care.jsp" class="outline-btn">
                    Plant Care Guide
                </a>
            </div>
        </div>

        <div class="hero-plant">
            <div class="plant-circle">
                🌿
            </div>
            <div class="floating-card card-one">
                🌱 Beginner Friendly
            </div>
            <div class="floating-card card-two">
                ☀️ Easy to Grow
            </div>
        </div>
    </section>

    <!-- ================= CATEGORIES ================= -->
    <section class="categories section">
        <div class="section-heading">
            <p class="section-label">EXPLORE OUR COLLECTION</p>
            <h2>
                Find Your Perfect
                <span>Plant</span>
            </h2>
            <p>
                Choose plants based on your space, light, and lifestyle.
            </p>
        </div>

        <div class="category-container">
            <!-- Beginner -->
            <div class="category-card" onclick="window.location.href='plants.jsp';" style="cursor:pointer;">
                <div class="category-icon beginner">🌱</div>
                <h3>Beginner Plants</h3>
                <p>Easy-care plants that are resilient and perfect for first-time plant parents.</p>
                <a href="plants.jsp">Explore Plants →</a>
            </div>

            <!-- Indoor -->
            <div class="category-card featured-category" onclick="window.location.href='plants.jsp';" style="cursor:pointer;">
                <div class="category-icon indoor">🏠</div>
                <h3>Indoor Plants</h3>
                <p>Bring freshness, style, and clean air into your living room, desk, or bedroom.</p>
                <a href="plants.jsp">Explore Plants →</a>
            </div>

            <!-- Balcony -->
            <div class="category-card" onclick="window.location.href='plants.jsp';" style="cursor:pointer;">
                <div class="category-icon balcony">🌤️</div>
                <h3>Balcony Plants</h3>
                <p>Sun-loving, flowering, and fruit-bearing plants that adore outdoor balconies.</p>
                <a href="plants.jsp">Explore Plants →</a>
            </div>
        </div>
    </section>

    <!-- ================= BEST SELLERS ================= -->
    <section class="products section">
        <div class="section-heading product-heading">
            <div>
                <p class="section-label">CURATED SELECTION</p>
                <h2>Popular <span>Plants</span></h2>
            </div>
            <a href="plants.jsp" class="view-all">View Full Catalog →</a>
        </div>

        <div class="product-container">
            <!-- Product 1 -->
            <div class="product-card" onclick="window.location.href='product-details.jsp?name=Snake Plant';" style="cursor:pointer;">
                <div class="product-image">
                    <span class="product-tag">Indoor</span>
                    <div class="plant-emoji">🌿</div>
                </div>
                <div class="product-info">
                    <p class="product-category">Indoor Plant</p>
                    <h3>Snake Plant</h3>
                    <p class="product-description">Low maintenance and air purifying</p>
                    <div class="product-bottom">
                        <span class="price">₹299</span>
                        <button class="add-cart" onclick="event.stopPropagation(); addToCart('Snake Plant', 299);">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- Product 2 -->
            <div class="product-card" onclick="window.location.href='product-details.jsp?name=Money Plant';" style="cursor:pointer;">
                <div class="product-image">
                    <span class="product-tag">Popular</span>
                    <div class="plant-emoji">🌱</div>
                </div>
                <div class="product-info">
                    <p class="product-category">Indoor Plant</p>
                    <h3>Money Plant</h3>
                    <p class="product-description">Easy to grow and beautiful trailing foliage</p>
                    <div class="product-bottom">
                        <span class="price">₹199</span>
                        <button class="add-cart" onclick="event.stopPropagation(); addToCart('Money Plant', 199);">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- Product 3 -->
            <div class="product-card" onclick="window.location.href='product-details.jsp?name=Aloe Vera';" style="cursor:pointer;">
                <div class="product-image">
                    <span class="product-tag">Succulent</span>
                    <div class="plant-emoji">🌵</div>
                </div>
                <div class="product-info">
                    <p class="product-category">Succulent</p>
                    <h3>Aloe Vera</h3>
                    <p class="product-description">Needs less water and full sunlight</p>
                    <div class="product-bottom">
                        <span class="price">₹149</span>
                        <button class="add-cart" onclick="event.stopPropagation(); addToCart('Aloe Vera', 149);">+ Add</button>
                    </div>
                </div>
            </div>

            <!-- Product 4 -->
            <div class="product-card" onclick="window.location.href='product-details.jsp?name=Hibiscus';" style="cursor:pointer;">
                <div class="product-image">
                    <span class="product-tag">Flowering</span>
                    <div class="plant-emoji">🌺</div>
                </div>
                <div class="product-info">
                    <p class="product-category">Outdoor / Balcony</p>
                    <h3>Hibiscus</h3>
                    <p class="product-description">Bright flowering plant that loves the sun</p>
                    <div class="product-bottom">
                        <span class="price">₹249</span>
                        <button class="add-cart" onclick="event.stopPropagation(); addToCart('Hibiscus', 249);">+ Add</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ================= PLANT CARE HIGHLIGHT ================= -->
    <section class="care section">
        <div class="care-image">
            <div class="care-icon">🌿</div>
        </div>

        <div class="care-content">
            <p class="section-label">PLANT CARE GUIDE</p>
            <h2>We Help Your Plants <span>Stay Happy & Healthy.</span></h2>
            <p>
                New to plant parenting? Don't worry. Learn expert tips about watering schedules,
                sunlight positioning, well-draining soil, and seasonal care.
            </p>

            <div class="care-features">
                <div>
                    <span>💧</span>
                    <div>
                        <h4>Watering Wisdom</h4>
                        <p>Check topsoil before watering to prevent root rot.</p>
                    </div>
                </div>

                <div>
                    <span>☀️</span>
                    <div>
                        <h4>Sunlight Balancing</h4>
                        <p>Direct vs. indirect sunlight for every plant type.</p>
                    </div>
                </div>

                <div>
                    <span>🌱</span>
                    <div>
                        <h4>Soil & Growth</h4>
                        <p>Nutrient-rich potting mixes for strong root systems.</p>
                    </div>
                </div>
            </div>

            <a href="plant-care.jsp" class="text-btn">
                Read Complete Plant Care Guide →
            </a>
        </div>
    </section>

    <!-- ================= FOOTER ================= -->
    <footer>
        <div class="footer-content">
            <div class="footer-brand">
                <h2>🌱 GreenNest</h2>
                <p>Bringing nature closer to your everyday life. Quality plants delivered safely to your doorstep.</p>
            </div>

            <div class="footer-links">
                <h4>Quick Navigation</h4>
                <a href="index.jsp">Home</a>
                <a href="plants.jsp">Shop Plants</a>
                <a href="plant-care.jsp">Plant Care</a>
                <a href="cart.jsp">Shopping Cart</a>
            </div>

            <div class="footer-links">
                <h4>Account & Help</h4>
                <% if (userName != null) { %>
                    <a href="MyOrdersServlet">My Orders</a>
                    <a href="logout.jsp">Logout</a>
                <% } else { %>
                    <a href="login.jsp">Customer Login</a>
                    <a href="register.jsp">Create Account</a>
                <% } %>
                <a href="admin-login.jsp">Admin Portal</a>
            </div>

            <div class="footer-links">
                <h4>Community</h4>
                <a href="#">Instagram @GreenNest</a>
                <a href="#">Facebook /GreenNest</a>
                <a href="#">YouTube /GreenNestLife</a>
            </div>
        </div>

        <div class="footer-bottom">
            <p>© 2026 GreenNest. All Rights Reserved.</p>
            <p>Grow Green. Live Better. 🌿</p>
        </div>
    </footer>

    <script>
        function addToCart(name, price) {
            let cart = [];
            try {
                cart = JSON.parse(localStorage.getItem("greenNestCart")) || [];
            } catch(e) {
                cart = [];
            }

            let existing = cart.find(item => item.name === name);
            if (existing) {
                existing.quantity = (parseInt(existing.quantity, 10) || 1) + 1;
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