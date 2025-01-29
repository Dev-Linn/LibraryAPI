FROM maven:3.8.4-openjdk-11 as build

# Copia o código para o container
COPY . /app

# Definir o diretório de trabalho
WORKDIR /app

# Rodar o Maven para construir o projeto, pulando os testes
RUN mvn clean package -DskipTests

# Imagem base para rodar a aplicação
FROM openjdk:11-jre-slim

COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app/demo.jar

ENTRYPOINT ["java", "-jar", "/app/demo.jar"]
