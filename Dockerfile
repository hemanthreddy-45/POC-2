
# Use a base image
FROM openjdk:11-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Compile the application (example for a Java application)
RUN ./gradlew build

# Run the application
CMD ["java", "-jar", "build/libs/your-app.jar"]
