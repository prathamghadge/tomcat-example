FROM bitnami/tomcat:latest
COPY target/docker-java-sample-webapp-1.0-SNAPSHOT.war /opt/bitnami/tomcat/webapps
