# Use uma imagem base do Maven com JDK 21
FROM maven:3.9.5-eclipse-temurin-21 AS build

# Defina o diretório de trabalho no container
WORKDIR /app

# Copie o código fonte para o container
COPY pom.xml .
COPY src ./src

# Gere o arquivo JAR
RUN mvn clean package

# Use uma imagem base menor para a execução
FROM eclipse-temurin:21-jre-jammy

# Defina o diretório de trabalho no container
WORKDIR /app

# Copie o arquivo JAR gerado para dentro do container
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Exponha a porta que sua aplicação vai usar (ajuste conforme necessário)
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "/app/demo.jar"]