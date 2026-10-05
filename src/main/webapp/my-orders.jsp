<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.greennest.Order" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>My Orders - GreenNest</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    background: #f5f7f6;
    color: #222;
}

/* ================= NAVBAR ================= */

.navbar {
    width: 100%;
    height: 80px;
    background: white;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 45px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
}

.logo {
    font-size: 25px;
    font-weight: bold;
    color: #146b3a;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 35px;
}

.nav-links a {
    text-decoration: none;
    color: #222;
    font-weight: bold;
}

.nav-links a:hover {
    color: #168044;
}

.user-area {
    display: flex;
    align-items: center;
    gap: 15px;
}

.welcome {
    font-weight: bold;
}

.logout-btn {
    padding: 11px 18px;
    border: 1px solid #ddd;
    border-radius: 8px;
    text-decoration: none;
    color: #222;
    background: white;
}

/* ================= PAGE ================= */

.page-title {
    text-align: center;
    margin: 40px 0 25px;
    color: #174d32;
}

.orders-container {
    width: 90%;
    max-width: 1100px;
    margin: auto;
}

/* ================= ORDER CARD ================= */

.order-card {
    background: white;
    border-radius: 15px;
    margin-bottom: 30px;
    padding: 30px;
    box-shadow: 0 4px 18px rgba(0,0,0,0.08);
}

.order-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.order-id {
    font-size: 25px;
    font-weight: bold;
}

.status-badge {
    padding: 12px 18px;
    border-radius: 25px;
    background: #edf5ef;
    color: #185c35;
    font-weight: bold;
}

/* ================= ORDER DETAILS ================= */

.order-details {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 25px;
    margin-bottom: 25px;
}

.detail-box {
    padding: 10px;
}

.detail-title {
    font-size: 13px;
    font-weight: bold;
    color: #777;
    margin-bottom: 8px;
    text-transform: uppercase;
}

.detail-value {
    font-size: 16px;
    font-weight: bold;
}

/* ================= ADDRESS ================= */

.address-box {
    margin-top: 10px;
    margin-bottom: 40px;
}

.address-title {
    font-size: 13px;
    font-weight: bold;
    color: #777;
    text-transform: uppercase;
    margin-bottom: 8px;
}

.address-value {
    font-weight: bold;
}

/* ================= TIMELINE ================= */

.timeline-title {
    text-align: center;
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 35px;
    color: #234f36;
}

.timeline {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    position: relative;
    margin: 0 50px 25px;
}

/* line */

.timeline::before {
    content: "";
    position: absolute;
    top: 25px;
    left: 8%;
    right: 8%;
    height: 4px;
    background: #e5e7e9;
    z-index: 0;
}

/* progress line */

.progress-line {
    position: absolute;
    top: 25px;
    left: 8%;
    height: 4px;
    width: 0%;
    background: #176b3a;
    z-index: 1;
    transition: width 0.8s ease;
}

/* each step */

.timeline-step {
    width: 25%;
    text-align: center;
    position: relative;
    z-index: 2;
}

.timeline-circle {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background: #f0f2f3;
    border: 3px solid #e0e3e5;

    display: flex;
    align-items: center;
    justify-content: center;

    margin: 0 auto 12px;

    font-size: 22px;
    color: #aaa;

    transition: all 0.5s ease;
}

.timeline-step.active .timeline-circle {
    background: #176b3a;
    border-color: #176b3a;
    color: white;
}

.timeline-step.active .timeline-label {
    color: #176b3a;
    font-weight: bold;
}

.timeline-label {
    color: #999;
    font-size: 14px;
    transition: all 0.5s ease;
}

/* ================= CANCELLED ================= */

.cancelled-box {
    background: #fff0f0;
    color: #b42318;
    padding: 15px;
    border-radius: 10px;
    text-align: center;
    font-weight: bold;
    margin-top: 20px;
}

/* ================= EMPTY ================= */

.empty-orders {
    background: white;
    padding: 60px;
    text-align: center;
    border-radius: 15px;
    box-shadow: 0 3px 15px rgba(0,0,0,0.07);
}

.empty-orders h2 {
    color: #174d32;
}

/* ================= FOOTER ================= */

.footer {
    margin-top: 70px;
    background: #0f4d32;
    color: white;
    text-align: center;
    padding: 25px;
}

/* ================= MOBILE ================= */

@media(max-width: 800px) {

    .navbar {
        padding: 0 15px;
        height: auto;
        min-height: 75px;
        flex-wrap: wrap;
        gap: 15px;
        padding-top: 15px;
        padding-bottom: 15px;
    }

    .nav-links {
        gap: 15px;
    }

    .order-details {
        grid-template-columns: repeat(2, 1fr);
    }

    .timeline {
        margin: 0 10px 25px;
    }

    .timeline-label {
        font-size: 11px;
    }

    .timeline-circle {
        width: 40px;
        height: 40px;
        font-size: 17px;
    }

    .timeline::before {
        top: 20px;
    }

    .progress-line {
        top: 20px;
    }
}

</style>

</head>

<body>


<!-- ================= NAVBAR ================= -->

<div class="navbar">

    <div class="logo">
        🌿 GreenNest
    </div>

    <div class="nav-links">

        <a href="index.jsp">Home</a>

        <a href="plants.jsp">Plants</a>

        <a href="plant-care.jsp">Plant Care</a>

        <a href="MyOrdersServlet">📦 My Orders</a>

    </div>

    <div class="user-area">

        <span class="welcome">
            🌱 Welcome,
            <%= session.getAttribute("userName") != null
                    ? session.getAttribute("userName")
                    : "User" %>
        </span>

        <a href="LogoutServlet" class="logout-btn">
            Logout
        </a>

    </div>

</div>


<!-- ================= TITLE ================= -->

<h1 class="page-title">
    My Orders
</h1>


<div class="orders-container">


<%

List<Order> orders =
        (List<Order>) request.getAttribute("orders");


if (orders == null || orders.isEmpty()) {

%>

    <div class="empty-orders">

        <h2>No Orders Found</h2>

        <p>
            You haven't placed any orders yet.
        </p>

        <a href="plants.jsp"
           style="color:#176b3a;font-weight:bold;">
            Continue Shopping
        </a>

    </div>

<%

} else {

    for (Order order : orders) {

        String status =
                order.getStatus() != null
                ? order.getStatus()
                : "Order Placed";

        boolean isCancelled =
                "Cancelled".equalsIgnoreCase(status);


        int statusLevel = 1;

        if ("Packed".equalsIgnoreCase(status)) {

            statusLevel = 2;

        } else if ("Shipped".equalsIgnoreCase(status)) {

            statusLevel = 3;

        } else if ("Delivered".equalsIgnoreCase(status)) {

            statusLevel = 4;

        }

%>


<!-- ================= ORDER CARD ================= -->

<div class="order-card"
     data-status-level="<%= statusLevel %>"
     data-cancelled="<%= isCancelled %>">


    <!-- HEADER -->

    <div class="order-header">

        <div class="order-id">

            Order ID:
            #<%= order.getOrderId() %>

        </div>


        <div class="status-badge">

            📦 <%= status %>

        </div>

    </div>


    <!-- DETAILS -->

    <div class="order-details">


        <div class="detail-box">

            <div class="detail-title">
                Customer
            </div>

            <div class="detail-value">
                <%= order.getCustomerName() %>
            </div>

        </div>


        <div class="detail-box">

            <div class="detail-title">
                Payment Method
            </div>

            <div class="detail-value">
                <%= order.getPaymentMethod() %>
            </div>

        </div>


        <div class="detail-box">

            <div class="detail-title">
                Order Date
            </div>

            <div class="detail-value">
                <%= order.getOrderDate() %>
            </div>

        </div>


        <div class="detail-box">

            <div class="detail-title">
                Total Amount
            </div>

            <div class="detail-value">

                ₹<%= String.format("%.2f",
                        order.getTotal()) %>

            </div>

        </div>


    </div>


    <!-- ADDRESS -->

    <div class="address-box">

        <div class="address-title">
            Delivery Address
        </div>

        <div class="address-value">

            <%= order.getAddress() %>,
            <%= order.getCity() %>
            -
            <%= order.getPincode() %>

        </div>

    </div>


<%

if (isCancelled) {

%>

    <div class="cancelled-box">

        ❌ This order has been cancelled.

    </div>

<%

} else {

%>


    <!-- TIMELINE TITLE -->

    <div class="timeline-title">

        🚚 Live Order Timeline

    </div>


    <!-- TIMELINE -->

    <div class="timeline">


        <!-- PROGRESS LINE -->

        <div class="progress-line"></div>


        <!-- STEP 1 -->

        <div class="timeline-step">

            <div class="timeline-circle">
                ✓
            </div>

            <div class="timeline-label">
                Order Placed
            </div>

        </div>


        <!-- STEP 2 -->

        <div class="timeline-step">

            <div class="timeline-circle">
                ✓
            </div>

            <div class="timeline-label">
                Packed
            </div>

        </div>


        <!-- STEP 3 -->

        <div class="timeline-step">

            <div class="timeline-circle">
                ✓
            </div>

            <div class="timeline-label">
                Shipped
            </div>

        </div>


        <!-- STEP 4 -->

        <div class="timeline-step">

            <div class="timeline-circle">
                ✓
            </div>

            <div class="timeline-label">
                Delivered
            </div>

        </div>


    </div>


<%

}

%>

</div>


<%

    }

}

%>

</div>


<!-- ================= FOOTER ================= -->

<div class="footer">

    © 2026 GreenNest |
    Plant and Plant-Care Marketplace 🌿

</div>



<!-- ===================================================== -->
<!--                 AUTO TRACKING SCRIPT                  -->
<!-- ===================================================== -->

<script>

document.addEventListener("DOMContentLoaded", function () {

    const orderCards =
        document.querySelectorAll(".order-card");


    orderCards.forEach(function (card) {

        let currentLevel =
            parseInt(
                card.getAttribute("data-status-level")
            );


        const isCancelled =
            card.getAttribute("data-cancelled") === "true";


        const steps =
            card.querySelectorAll(".timeline-step");


        const progressLine =
            card.querySelector(".progress-line");


        const statusBadge =
            card.querySelector(".status-badge");


        if (isCancelled) {
            return;
        }


        /*
         * Initial status
         */

        updateTimeline(
            currentLevel,
            steps,
            progressLine,
            statusBadge
        );


        /*
         * Every 5 seconds
         */

        const timer =
            setInterval(function () {


                if (currentLevel >= 4) {

                    clearInterval(timer);

                    return;
                }


                currentLevel++;


                updateTimeline(
                    currentLevel,
                    steps,
                    progressLine,
                    statusBadge
                );


            }, 5000);


    });

});



/*
 * Update timeline
 */

function updateTimeline(
    level,
    steps,
    progressLine,
    statusBadge
) {


    /*
     * Remove active
     */

    steps.forEach(function (step) {

        step.classList.remove("active");

    });


    /*
     * Add active steps
     */

    for (
        let i = 0;
        i < level;
        i++
    ) {

        if (steps[i]) {

            steps[i].classList.add("active");

        }

    }


    /*
     * Progress percentage
     *
     * 1 = 0%
     * 2 = 33%
     * 3 = 66%
     * 4 = 100%
     */

    let progress = 0;


    if (level === 1) {

        progress = 0;

    } else if (level === 2) {

        progress = 33;

    } else if (level === 3) {

        progress = 66;

    } else if (level === 4) {

        progress = 100;

    }


    if (progressLine) {

        progressLine.style.width =
            progress + "%";

    }


    /*
     * Status text
     */

    const statusNames = [

        "Order Placed",
        "Packed",
        "Shipped",
        "Delivered"

    ];


    if (statusBadge) {

        statusBadge.innerHTML =
            "📦 " + statusNames[level - 1];

    }

}

</script>


</body>
</html>