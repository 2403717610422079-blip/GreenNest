<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GreenNest - Plants</title>

<style>
* { box-sizing: border-box; }
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f8f3;
    color: #333;
}
nav {
    background: #2e7d32;
    color: white;
    padding: 18px 5%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 15px;
}
.logo { font-size: 27px; font-weight: bold; }
.nav-links { display: flex; gap: 20px; flex-wrap: wrap; }
.nav-links a {
    color: white;
    text-decoration: none;
    font-weight: bold;
}
.nav-links a:hover { text-decoration: underline; }

.container {
    width: 92%;
    max-width: 1200px;
    margin: 35px auto;
}
h1 { text-align: center; color: #2e7d32; }
.subtitle { text-align: center; color: #666; }

.filters {
    display: flex;
    justify-content: center;
    gap: 10px;
    flex-wrap: wrap;
    margin: 25px 0;
}
.filters button, .filters select {
    padding: 10px 15px;
    border: 1px solid #2e7d32;
    border-radius: 7px;
    background: white;
    cursor: pointer;
}
.filters button.active,
.filters button:hover {
    background: #2e7d32;
    color: white;
}
.search-box {
    display: block;
    width: 100%;
    max-width: 450px;
    padding: 12px;
    margin: 20px auto;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 16px;
}
.plant-grid {
    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 22px;
}
.plant-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 3px 12px #00000012;
    padding-bottom: 18px;
    text-align: center;
    transition: transform .2s;
}
.plant-card:hover { transform: translateY(-4px); }
.plant-image {
    height: 150px;
    background: #eaf5e5;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 65px;
    position: relative;
}
.product-badge {
    position: absolute;
    top: 10px;
    left: 10px;
    background: #2e7d32;
    color: white;
    font-size: 11px;
    padding: 5px 8px;
    border-radius: 12px;
}
.plant-card h3 { color: #2e7d32; margin: 15px 8px 8px; }
.plant-card p { color: #666; margin: 8px; font-size: 14px; }
.price { font-weight: bold; color: #2e7d32 !important; font-size: 19px !important; }
.card-actions { display: flex; flex-direction: column; gap: 8px; padding: 0 15px; }
.card-actions button, .card-actions a {
    display: block;
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 6px;
    text-decoration: none;
    cursor: pointer;
    font-weight: bold;
    font-size: 14px;
}
.add-btn { background: #2e7d32; color: white; }
.add-btn:hover { background: #1b5e20; }
.details-btn { background: #edf5e9; color: #2e7d32; }
.no-results { grid-column: 1 / -1; text-align: center; padding: 35px; }

@media(max-width: 900px) {
    .plant-grid { grid-template-columns: repeat(3, minmax(0, 1fr)); }
}
@media(max-width: 650px) {
    .plant-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
    nav { justify-content: center; }
    .nav-links { justify-content: center; }
}
@media(max-width: 400px) {
    .plant-grid { grid-template-columns: 1fr; }
}
</style>
</head>

<body>

<nav>
    <div class="logo">🌿 GreenNest</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="plants.jsp">Plants</a>
        <a href="cart.jsp">🛒 Cart</a>
        <a href="my-orders.jsp">My Orders</a>
        <a href="logout.jsp">Logout</a>
    </div>
</nav>

<div class="container">
    <h1>🌱 Our Plants Collection</h1>
    <p class="subtitle">Find the perfect plants for your home and garden.</p>

    <input id="searchBox" class="search-box" type="search"
           placeholder="Search plants..." oninput="filterPlants()">

    <div class="filters">
        <button class="active" onclick="setCategory('all', this)">All Plants</button>
        <button onclick="setCategory('indoor', this)">Indoor</button>
        <button onclick="setCategory('flowering', this)">Flowering</button>
        <button onclick="setCategory('fruit', this)">Fruit Plants</button>
        <button onclick="setCategory('vegetable', this)">Vegetables</button>
    </div>

    <div id="plantGrid" class="plant-grid"></div>
</div>

<script>
const plants = [
    {name:"Snake Plant", price:299, emoji:"🌿", category:"indoor", badge:"Beginner"},
    {name:"Money Plant", price:199, emoji:"🪴", category:"indoor", badge:"Popular"},
    {name:"Aloe Vera", price:149, emoji:"🌵", category:"indoor", badge:"Easy Care"},
    {name:"Peace Lily", price:349, emoji:"🪴", category:"indoor", badge:"Air Purifying"},
    {name:"Areca Palm", price:499, emoji:"🌴", category:"indoor", badge:"Popular"},
    {name:"Spider Plant", price:199, emoji:"🌿", category:"indoor", badge:"Beginner"},
    {name:"ZZ Plant", price:399, emoji:"🪴", category:"indoor", badge:"Easy Care"},
    {name:"Rubber Plant", price:449, emoji:"🌿", category:"indoor", badge:"Popular"},
    {name:"Boston Fern", price:249, emoji:"🌿", category:"indoor", badge:"Green Pick"},
    {name:"Hibiscus", price:249, emoji:"🌺", category:"flowering", badge:"Flowering"},
    {name:"Rose Plant", price:299, emoji:"🌹", category:"flowering", badge:"Popular"},
    {name:"Lemon Plant", price:399, emoji:"🍋", category:"fruit", badge:"Fruit Plant"},
    {name:"Mango Plant", price:499, emoji:"🥭", category:"fruit", badge:"Fruit Plant"},
    {name:"Guava Plant", price:349, emoji:"🍈", category:"fruit", badge:"Fruit Plant"},
    {name:"Orange Plant", price:449, emoji:"🍊", category:"fruit", badge:"Fruit Plant"},
    {name:"Pomegranate Plant", price:399, emoji:"🍎", category:"fruit", badge:"Fruit Plant"},
    {name:"Tomato Plant", price:99, emoji:"🍅", category:"vegetable", badge:"Vegetable"},
    {name:"Chilli Plant", price:79, emoji:"🌶️", category:"vegetable", badge:"Vegetable"},
    {name:"Cucumber Plant", price:89, emoji:"🥒", category:"vegetable", badge:"Vegetable"},
    {name:"Marigold", price:99, emoji:"🌼", category:"flowering", badge:"Flowering"},
    {name:"Sunflower", price:129, emoji:"🌻", category:"flowering", badge:"Flowering"},
    {name:"Jasmine", price:199, emoji:"🌸", category:"flowering", badge:"Fragrant"}
];

let selectedCategory = "all";

function renderPlants(list) {
    const grid = document.getElementById("plantGrid");
    grid.innerHTML = "";

    if (list.length === 0) {
        grid.innerHTML = '<p class="no-results">No plants found.</p>';
        return;
    }

    list.forEach(function(plant) {
        const card = document.createElement("div");
        card.className = "plant-card";

        const image = document.createElement("div");
        image.className = "plant-image";

        const badge = document.createElement("span");
        badge.className = "product-badge";
        badge.textContent = plant.badge;

        const emoji = document.createElement("span");
        emoji.textContent = plant.emoji;

        image.appendChild(badge);
        image.appendChild(emoji);

        const name = document.createElement("h3");
        name.textContent = plant.name;

        const category = document.createElement("p");
        category.textContent =
            plant.category.charAt(0).toUpperCase() +
            plant.category.slice(1) + " Plant";

        const price = document.createElement("p");
        price.className = "price";
        price.textContent = "₹" + plant.price.toFixed(2);

        const actions = document.createElement("div");
        actions.className = "card-actions";

        const details = document.createElement("a");
        details.className = "details-btn";
        details.href = "product-details.jsp?name=" +
            encodeURIComponent(plant.name);
        details.textContent = "View Details";

        const addButton = document.createElement("button");
        addButton.className = "add-btn";
        addButton.textContent = "🛒 Add to Cart";
        addButton.addEventListener("click", function() {
            addToCart(plant);
        });

        actions.appendChild(details);
        actions.appendChild(addButton);

        card.appendChild(image);
        card.appendChild(name);
        card.appendChild(category);
        card.appendChild(price);
        card.appendChild(actions);

        grid.appendChild(card);
    });
}

function addToCart(plant) {
    let cart = [];

    try {
        cart = JSON.parse(localStorage.getItem("greenNestCart")) || [];
    } catch (e) {
        cart = [];
    }

    const existing = cart.find(function(item) {
        return item.name === plant.name;
    });

    if (existing) {
        existing.quantity = (parseInt(existing.quantity, 10) || 1) + 1;
        existing.price = plant.price;
    } else {
        cart.push({
            name: plant.name,
            price: plant.price,
            quantity: 1
        });
    }

    localStorage.setItem("greenNestCart", JSON.stringify(cart));
    alert(plant.name + " added to cart successfully! 🌱");
}

function setCategory(category, button) {
    selectedCategory = category;

    document.querySelectorAll(".filters button").forEach(function(btn) {
        btn.classList.remove("active");
    });
    button.classList.add("active");

    filterPlants();
}

function filterPlants() {
    const search = document.getElementById("searchBox")
        .value.trim().toLowerCase();

    const filtered = plants.filter(function(plant) {
        const matchesCategory =
            selectedCategory === "all" ||
            plant.category === selectedCategory;

        const matchesSearch =
            plant.name.toLowerCase().includes(search);

        return matchesCategory && matchesSearch;
    });

    renderPlants(filtered);
}

renderPlants(plants);
</script>

</body>
</html>