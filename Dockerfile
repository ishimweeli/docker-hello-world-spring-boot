# Build Application
FROM maven:3.8.6-openjdk-18 AS build

WORKDIR /app

COPY . .
#COPY .env .

RUN #chmod 755 mvnw
# RUN ./mvnw clean install -P quick

RUN mvn package -DskipTests

# Serve Application
FROM openjdk:20-bullseye

WORKDIR /app
#COPY --from=build /app/.env .
COPY --from=build /app/target/*.jar app.jar

EXPOSE 6060

CMD [ "java", "--enable-preview", "-jar", "app.jar" ]