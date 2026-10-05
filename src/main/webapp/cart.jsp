<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shopping Cart - GreenNest</title>
<link rel="stylesheet" href="css/style.css">

<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

body {
    margin: 0;
    background: #f5f8f3;
    color: #263a2c;
}

.cart-container {
    width: 92%;
    max-width: 1050px;
    margin: 40px auto;
}

.cart-title {
    text-align: center;
    color: #2e7d32;
    margin-bottom: 30px;
    font-size: 32px;
}

.cart-item {
    display: grid;
    grid-template-columns: 90px 2fr 1fr 1fr auto;
    align-items: center;
    gap: 18px;
    background: white;
    padding: 20px;
    margin-bottom: 18px;
    border-radius: 12px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.06);
    border: 1px solid #eef2ed;
}

.product-image {
    width: 80px;
    height: 80px;
    border-radius: 10px;
    background: #edf5e9;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 42px;
}

.item-info h3 {
    margin: 0 0 8px;
    color: #2e7d32;
    font-size: 18px;
}

.item-price {
    color: #666;
    font-size: 14px;
}

.quantity {
    display: flex;
    align-items: center;
    gap: 10px;
}

.quantity button {
    width: 32px;
    height: 32px;
    border: none;
    background: #2e7d32;
    color: white;
    border-radius: 6px;
    font-size: 18px;
    cursor: pointer;
    transition: 0.2s;
}

.quantity button:hover {
    background: #1b5e20;
}

.subtotal {
    color: #2e7d32;
    font-weight: bold;
    font-size: 16px;
}

.remove-btn {
    background: #e53935;
    color: white;
    border: none;
    padding: 9px 14px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    font-size: 13px;
    transition: 0.2s;
}

.remove-btn:hover {
    background: #c62828;
}

.cart-summary {
    margin-top: 30px;
    padding: 25px 30px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
    border: 1px solid #eef2ed;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
}

.total {
    font-size: 24px;
    font-weight: bold;
    color: #2e7d32;
}

.checkout-btn,
.continue-btn {
    display: inline-block;
    padding: 13px 25px;
    border: none;
    border-radius: 7px;
    text-decoration: none;
    cursor: pointer;
    font-size: 15px;
    font-weight: bold;
    transition: 0.2s;
}

.continue-btn {
    background: white;
    color: #2e7d32;
    border: 2px solid #2e7d32;
}

.continue-btn:hover {
    background: #e8f5e9;
}

.checkout-btn {
    background: #2e7d32;
    color: white;
}

.checkout-btn:hover {
    background: #1b5e20;
}

.empty-cart {
    text-align: center;
    padding: 60px 20px;
    background: white;
    border-radius: 14px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
}

.empty-cart h2 {
    color: #2e7d32;
    margin: 15px 0 10px;
}

@media (max-width: 750px) {
    .cart-item {
        grid-template-columns: 75px 1fr;
        gap: 15px;
    }

    .quantity,
    .subtotal,
    .remove-btn {
        grid-column: 2;
    }

    .cart-summary {
        flex-direction: column;
        align-items: stretch;
        text-align: center;
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
        <a href="cart.jsp" class="cart-btn" style="background:#144d18;">🛒 Cart</a>
    </div>
</header>

<div class="cart-container">

    <h1 class="cart-title">🛒 Your Shopping Cart</h1>

    <div id="cartItems"></div>

    <div class="cart-summary" id="cartSummary">
        <div>
            <p style="color:#666; margin-bottom: 5px;">
                Total Items: <strong id="totalItems" style="color:#2e7d32;">0</strong>
            </p>
            <p class="total">
                Grand Total: ₹<span id="totalPrice">0.00</span>
            </p>
        </div>

        <div style="display:flex; gap:12px; flex-wrap:wrap;">
            <a href="plants.jsp" class="continue-btn">
                ← Continue Shopping
            </a>

            <button type="button" class="checkout-btn" onclick="proceedCheckout()">
                Proceed to Checkout →
            </button>
        </div>
    </div>

</div>

<script>
var cart = [];
try {
    cart = JSON.parse(localStorage.getItem("greenNestCart")) || [];
} catch (error) {
    cart = [];
}

function getEmoji(name) {
    var nameLower = (name || "").toLowerCase();
    if (nameLower.contains ? nameLower.contains("rose") : nameLower.indexOf("rose") !== -1) return "🌹";
    if (nameLower.indexOf("snake") !== -1) return "🌿";
    if (nameLower.indexOf("money") !== -1) return "🌱";
    if (nameLower.indexOf("aloe") !== -1) return "🌵";
    if (nameLower.indexOf("lily") !== -1) return "🪴";
    if (nameLower.indexOf("palm") !== -1) return "🌴";
    if (nameLower.indexOf("spider") !== -1) return "🌿";
    if (nameLower.indexOf("zz") !== -1) return "🪴";
    if (nameLower.indexOf("rubber") !== -1) return "🪴";
    if (nameLower.indexOf("fern") !== -1) return "🌿";
    if (nameLower.indexOf("hibiscus") !== -1) return "🌺";
    if (nameLower.indexOf("lemon") !== -1) return "🍋";
    if (nameLower.indexOf("mango") !== -1) return "🥭";
    if (nameLower.indexOf("guava") !== -1) return "🍈";
    if (nameLower.indexOf("orange") !== -1) return "🍊";
    if (nameLower.indexOf("pomegranate") !== -1) return "🍎";
    if (nameLower.indexOf("tomato") !== -1) return "🍅";
    if (nameLower.indexOf("chilli") !== -1 || nameLower.indexOf("chili") !== -1) return "🌶️";
    if (nameLower.indexOf("cucumber") !== -1) return "🥒";
    if (nameLower.indexOf("marigold") !== -1) return "🌼";
    if (nameLower.indexOf("sunflower") !== -1) return "🌻";
    if (nameLower.indexOf("jasmine") !== -1) return "🌸";
    return "🌿";
}

function displayCart() {
    var cartItems = document.getElementById("cartItems");
    var cartSummary = document.getElementById("cartSummary");

    cartItems.innerHTML = "";
    var total = 0;
    var itemCount = 0;

    if (cart.length === 0) {
        cartItems.innerHTML =
            '<div class="empty-cart">' +
                '<div style="font-size:60px">🪴</div>' +
                '<h2>Your Cart is Empty</h2>' +
                '<p style="color:#666; margin-bottom:20px;">You have not added any plants to your cart yet.</p>' +
                '<a href="plants.jsp" class="checkout-btn" style="text-decoration:none;">' +
                    'Start Shopping Plants' +
                '</a>' +
            '</div>';

        document.getElementById("totalItems").innerText = "0";
        document.getElementById("totalPrice").innerText = "0.00";
        cartSummary.style.display = "none";
        return;
    }

    cartSummary.style.display = "flex";

    cart.forEach(function(item, index) {
        var price = Number(item.price) || 0;
        var quantity = Math.max(1, parseInt(item.quantity, 10) || 1);
        var name = item.name || "Plant";
        var itemTotal = price * quantity;

        total += itemTotal;
        itemCount += quantity;

        var card = document.createElement("div");
        card.className = "cart-item";

        var image = document.createElement("div");
        image.className = "product-image";
        image.textContent = getEmoji(name);

        var info = document.createElement("div");
        info.className = "item-info";

        var heading = document.createElement("h3");
        heading.textContent = name;

        var unitPrice = document.createElement("div");
        unitPrice.className = "item-price";
        unitPrice.textContent = "Unit Price: ₹" + price.toFixed(2);

        info.appendChild(heading);
        info.appendChild(unitPrice);

        var quantityBox = document.createElement("div");
        quantityBox.className = "quantity";

        var minus = document.createElement("button");
        minus.type = "button";
        minus.textContent = "−";
        minus.onclick = function() { decreaseQuantity(index); };

        var quantityText = document.createElement("span");
        quantityText.style.fontWeight = "bold";
        quantityText.style.padding = "0 6px";
        quantityText.textContent = quantity;

        var plus = document.createElement("button");
        plus.type = "button";
        plus.textContent = "+";
        plus.onclick = function() { increaseQuantity(index); };

        quantityBox.appendChild(minus);
        quantityBox.appendChild(quantityText);
        quantityBox.appendChild(plus);

        var subtotal = document.createElement("div");
        subtotal.className = "subtotal";
        subtotal.textContent = "₹" + itemTotal.toFixed(2);

        var remove = document.createElement("button");
        remove.type = "button";
        remove.className = "remove-btn";
        remove.textContent = "✕ Remove";
        remove.onclick = function() { removeItem(index); };

        card.appendChild(image);
        card.appendChild(info);
        card.appendChild(quantityBox);
        card.appendChild(subtotal);
        card.appendChild(remove);

        cartItems.appendChild(card);
    });

    document.getElementById("totalItems").innerText = itemCount;
    document.getElementById("totalPrice").innerText = total.toFixed(2);
}

function increaseQuantity(index) {
    if (!cart[index]) return;
    cart[index].quantity = (parseInt(cart[index].quantity, 10) || 1) + 1;
    saveCart();
}

function decreaseQuantity(index) {
    if (!cart[index]) return;
    var quantity = parseInt(cart[index].quantity, 10) || 1;
    if (quantity > 1) {
        cart[index].quantity = quantity - 1;
    } else {
        if (confirm("Remove " + cart[index].name + " from your cart?")) {
            cart.splice(index, 1);
        }
    }
    saveCart();
}

function removeItem(index) {
    if (index < 0 || index >= cart.length) return;
    if (confirm("Remove " + cart[index].name + " from your cart?")) {
        cart.splice(index, 1);
        saveCart();
    }
}

function saveCart() {
    localStorage.setItem("greenNestCart", JSON.stringify(cart));
    displayCart();
}

function proceedCheckout() {
    if (cart.length === 0) {
        alert("Your cart is empty! Please add plants to continue.");
        return;
    }
    <% if (userEmail == null) { %>
        alert("Please log in to proceed to checkout.");
        window.location.href = "login.jsp?error=login_required";
    <% } else { %>
        window.location.href = "checkout.jsp";
    <% } %>
}

displayCart();
</script>

</body>
</html>