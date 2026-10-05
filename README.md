# 🌿 GreenNest — Plant & Plant-Care Marketplace

GreenNest is a Java EE and JSP/Servlet e-commerce web platform designed for purchasing indoor, outdoor, flowering, fruit, and balcony plants, along with plant-care guidance. The application includes a full shopping flow for customers and a comprehensive administrative portal for plant inventory, user account management, and order fulfillment.

---

## 📌 Main Features

### 🛍️ Customer Storefront
- **Live Plant Catalog:** Browse curated plants across categories (Indoor, Flowering, Fruit, Vegetable, Succulent, Balcony).
- **Instant Search & Category Filtering:** Interactive filtering and searching by name or category.
- **Product Details:** Detailed views with plant specifications, care tips, and pricing.
- **Persistent Cart & Checkout:** Client-side cart management with local storage persistence and server-side order processing.
- **Order Tracking:** Real-time customer order history and visual order tracking timeline (`Order Placed`, `Packed`, `Shipped`, `Delivered`).
- **User Authentication:** Registration and login with duplicate prevention and session management.
- **Plant Care Guide:** Tips on watering, sunlight requirements, soil preparation, and pruning.

### 🛡️ Administrative Portal
- **Secure Admin Login:** Protected dashboard access with session authentication.
- **Live Metrics & Analytics:** Real-time counters for total products, registered users, total orders, and pending orders.
- **Plant Catalog Management:** Add new plants, edit existing details and pricing, and delete inventory items.
- **Customer Account Management:** Inspect registered users and securely manage accounts with order-history safety checks.
- **Order Fulfillment:** Update order statuses in real-time (`Order Placed`, `Packed`, `Shipped`, `Delivered`, `Cancelled`).

---

## 💻 Technologies Used

- **Backend:** Java 17 / 21, Java Servlets (3.1 / 4.0), JavaServer Pages (JSP)
- **Container / Server:** Apache Tomcat 9.0
- **Database:** MySQL 8.x
- **Build Tool:** Apache Maven (`pom.xml`)
- **Containerization:** Docker (Multi-stage build)
- **Frontend:** Responsive HTML5, Modern CSS3, JavaScript (ES6)
- **Deployment Platform:** Railway Cloud & GitHub

---

## 📂 Project Structure

```
GreenNest/
├── Dockerfile                         # Multi-stage Docker build for Railway cloud
├── pom.xml                            # Maven build & dependency configuration
├── schema.sql                         # MySQL database schema and starter seed data
├── .gitignore                         # Git exclusion rules for IDE, builds & secrets
├── README.md                          # Comprehensive project documentation
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── greennest/
        │           ├── AddProductServlet.java
        │           ├── AdminLoginServlet.java
        │           ├── AdminLogoutServlet.java
        │           ├── AdminOrdersServlet.java
        │           ├── DBConnection.java          # Cloud-ready dynamic connection pool
        │           ├── DeleteProductServlet.java
        │           ├── DeleteUserServlet.java
        │           ├── EditProductServlet.java
        │           ├── LoginServlet.java
        │           ├── ManageProductsServlet.java
        │           ├── ManageUsersServlet.java
        │           ├── MyOrdersServlet.java
        │           ├── Order.java
        │           ├── OrderServlet.java
        │           ├── Product.java
        │           ├── RegisterServlet.java
        │           ├── TestConnection.java
        │           ├── UpdateOrderStatusServlet.java
        │           ├── User.java
        │           └── users.java
        └── webapp/
            ├── css/
            │   └── style.css
            ├── images/
            ├── js/
            ├── WEB-INF/
            │   ├── lib/
            │   │   └── mysql-connector-j-26.7.0.jar
            │   └── web.xml
            ├── add-product.jsp
            ├── admin-dashboard.jsp
            ├── admin-login.jsp
            ├── admin-logout.jsp
            ├── admin-orders.jsp
            ├── cart.jsp
            ├── checkout.jsp
            ├── edit-product.jsp
            ├── index.jsp
            ├── login.jsp
            ├── logout.jsp
            ├── manage-products.jsp
            ├── manage-users.jsp
            ├── my-orders.jsp
            ├── order-success.jsp
            ├── plant-care.jsp
            ├── plants.jsp
            ├── product-details.jsp
            └── register.jsp
```

---

## ⚙️ Requirements

- **Java Development Kit (JDK):** Version 17 or 21
- **Apache Tomcat:** Version 9.0.x
- **MySQL Database:** Version 8.x
- **Build Tool (Optional locally):** Apache Maven 3.9+
- **Containerization (Optional locally):** Docker Desktop

---

## 🗄️ Database Setup

### 1. Local MySQL Setup
1. Log into your MySQL console or MySQL Workbench:
   ```bash
   mysql -u root -p
   ```
2. Execute the provided `schema.sql` script:
   ```sql
   SOURCE schema.sql;
   ```
   Or import via command line:
   ```bash
   mysql -u root -p < schema.sql
   ```
3. Default administrator credentials created by the seed script:
   - **Email:** `admin@greennest.com`
   - **Password:** `admin123`

---

## 🚀 How to Run Locally

### Option A: Via Eclipse IDE (Dynamic Web Project)
1. Open Eclipse IDE for Enterprise Java and Web Developers.
2. File -> Import -> Existing Projects into Workspace -> Select the GreenNest folder.
3. Ensure Apache Tomcat v9.0 is configured under Servers.
4. Right-click the project -> **Run As** -> **Run on Server** -> Select Tomcat v9.0.
5. Open browser at `http://localhost:8080/GreenNest/` or `http://localhost:8080/`.

### Option B: Via Maven & Local Tomcat
1. Package the WAR file:
   ```bash
   mvn clean package
   ```
2. Copy `target/ROOT.war` into your Tomcat `webapps/` directory:
   ```bash
   cp target/ROOT.war /path/to/tomcat/webapps/
   ```
3. Start Tomcat:
   ```bash
   catalina.sh run   # Linux/macOS
   catalina.bat run   # Windows
   ```
4. Access the application at `http://localhost:8080/`.

### Option C: Via Docker
```bash
docker build -t greennest .
docker run -p 8080:8080 -e DB_HOST=host.docker.internal -e DB_USER=root -e DB_PASSWORD=root greennest
```

---

## ☁️ How to Deploy on Railway

Railway allows one-click Docker deployments with managed MySQL databases.

### Step 1: Create a MySQL Database on Railway
1. Log into your [Railway Dashboard](https://railway.com).
2. Click **+ New Project** -> **Database** -> **Add MySQL**.
3. Once provisioned, click on the MySQL service -> **Variables** tab to view your credentials.
4. Go to the **Data** or **Query** tab in Railway MySQL (or connect using your local MySQL client via the provided public connection string) and run the contents of [`schema.sql`](schema.sql).

### Step 2: Deploy the GreenNest Application
1. In the same Railway project, click **+ New** -> **GitHub Repo**.
2. Select your `GreenNest` repository.
3. Railway will detect the `Dockerfile` automatically and build using Maven + Tomcat 9.

### Step 3: Configure Environment Variables in Railway
Go to your GreenNest service -> **Variables** tab and add:

| Variable Name | Description | Example / Reference |
| :--- | :--- | :--- |
| `MYSQL_URL` | Complete Railway MySQL connection string | `${{MySQL.MYSQL_URL}}` |
| *— OR —* | | |
| `DB_HOST` | MySQL hostname | `${{MySQL.MYSQLHOST}}` |
| `DB_PORT` | MySQL port | `${{MySQL.MYSQLPORT}}` |
| `DB_NAME` | MySQL database name | `${{MySQL.MYSQLDATABASE}}` |
| `DB_USER` | MySQL database user | `${{MySQL.MYSQLUSER}}` |
| `DB_PASSWORD` | MySQL database password | `${{MySQL.MYSQLPASSWORD}}` |

> 🔒 **Security Notice:**
> - `DBConnection.java` supports Railway's native variable naming (`MYSQL_URL`, `MYSQLHOST`, `MYSQLPORT`, `MYSQLDATABASE`, `MYSQLUSER`, `MYSQLPASSWORD`) as well as generic standard variables (`DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`).
> - Never commit production passwords or credentials to git.

### Step 4: Expose Public Domain
1. Go to your GreenNest service -> **Settings** tab.
2. Under **Networking**, click **Generate Domain**.
3. Your application is live at `https://<your-service-name>.up.railway.app`.

---

## 🔄 Future Updates Workflow

To push future changes to GitHub and automatically trigger Railway deployments:

```bash
git add .
git commit -m "Update GreenNest feature or fix"
git push origin main
```
