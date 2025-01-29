# Use uma imagem base do OpenJDK com Maven
FROM maven:3.8.6-openjdk-17 AS build

# Defina o diretório de trabalho no container
WORKDIR /app

# Copie o código fonte para o container
COPY pom.xml .
COPY src ./src

# Gere o arquivo JAR
RUN mvn clean package

# Use uma imagem base menor para a execução
FROM openjdk:17-jdk-slim

# Defina o diretório de trabalho no container
WORKDIR /app

# Copie o arquivo JAR gerado para dentro do container
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Exponha a porta que sua aplicação vai usar (ajuste conforme necessário)
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "/app/demo.jar"]