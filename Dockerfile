# Use uma imagem base do OpenJDK (Java)
FROM openjdk:17-jdk-slim

# Defina o diretório de trabalho no container
WORKDIR /app

# Copie o arquivo JAR gerado para dentro do container
COPY target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

# Comando para rodar a aplicação
CMD ["java", "-jar", "/app/demo.jar"]

# Exponha a porta que sua aplicação vai usar (ajuste conforme necessário)
EXPOSE 8080
