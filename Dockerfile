# ========================================================
# Stage 1: Build GreenNest WAR using Maven and Eclipse Temurin JDK 17
# ========================================================
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy Maven POM and source code
COPY pom.xml .
COPY src ./src

# Build production ROOT.war
RUN mvn clean package -DskipTests

# ========================================================
# Stage 2: Run Tomcat 9 Container with Java 17
# ========================================================
FROM tomcat:9.0-jdk17-temurin
WORKDIR /usr/local/tomcat

# Clean default webapps to ensure ROOT handles root path /
RUN rm -rf webapps/*

# Copy ROOT.war to webapps directory
COPY --from=build /app/target/ROOT.war webapps/ROOT.war

# Railway dynamically assigns $PORT at runtime
EXPOSE 8080

# Dynamically bind Tomcat connector to Railway's $PORT (default 8080) and start Tomcat
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/g\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
