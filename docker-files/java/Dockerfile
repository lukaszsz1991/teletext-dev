FROM maven:3.9.11-eclipse-temurin-25-alpine AS build

COPY /docker-files/java/.m2 /root/.m2
WORKDIR /app

COPY /backend/pom.xml .
RUN mvn dependency:go-offline -B

COPY /backend/src ./src
RUN mvn clean package -DskipTests -B

FROM eclipse-temurin:25-jre-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]