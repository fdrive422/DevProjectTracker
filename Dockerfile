# ---- build stage: compile + package the Spring Boot WAR ----
FROM maven:3.9-eclipse-temurin-11 AS build
WORKDIR /app
# Cache dependencies first for faster rebuilds
COPY pom.xml .
COPY .mvn .mvn
RUN mvn -B -q dependency:go-offline || true
COPY src src
RUN mvn -B -q clean package -DskipTests

# ---- run stage: slim JRE image ----
FROM eclipse-temurin:11-jre
WORKDIR /app
COPY --from=build /app/target/DevProjectTracker-0.0.1-SNAPSHOT.war app.war

# Size the heap to the container's memory (Cloud Run: --memory 512Mi and up).
ENV JAVA_OPTS="-XX:MaxRAMPercentage=75.0"

# Cloud Run sends traffic to $PORT (default 8080); Spring Boot reads it via server.port.
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.war"]
