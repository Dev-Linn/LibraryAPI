# Etapa de build: Construir a aplicação com o Maven usando OpenJDK 21
FROM ubuntu:latest AS build
RUN apt-get update
RUN apt-get install openjdk-21-jdk -y
COPY . .
RUN apt-get install maven -y
RUN mvn clean install

# Etapa final: Construir a imagem final com o JAR usando OpenJDK 21
FROM openjdk:21-jdk-slim
EXPOSE 8080

# Copiar o JAR gerado para o contêiner
COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar app.jar

# Executar a aplicação
ENTRYPOINT [ "java", "-jar", "app.jar" ]
