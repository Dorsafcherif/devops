FROM openjdk:8-alpine
EXPOSE 8089
COPY target/*.jar /
ENTRYPOINT ["java","-jar","/tpAchatProject-1.0.jar"]