## building the jar archive with maven
FROM maven:3.6.3-jdk-11-slim as builder
RUN mkdir /tmp/src
COPY . /tmp/src
WORKDIR /tmp/src

RUN ["mvn", "-B", "clean", "package", "-DskipTests"]

## executing the compiled jar
FROM openjdk:11.0.9.1-slim-buster
COPY --from=builder /tmp/src/target/spring-boot-data-jpa-0.0.1-SNAPSHOT.jar /tmp
WORKDIR /tmp
EXPOSE 8080
CMD ["java", "-jar", "spring-boot-data-jpa-0.0.1-SNAPSHOT.jar"]
