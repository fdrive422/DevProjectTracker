FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
COPY target/DevProjectTracker-0.0.1-SNAPSHOT.war devprojecttracker.war
EXPOSE 3000
# ENTRYPOINT exec java $JAVA_OPTS -jar devprojecttracker.jar
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -war devprojecttracker.war
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
