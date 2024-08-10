FROM eclipse-temurin:17-jre-jammy
ENV HOME=/opt/app
WORKDIR $HOME
ADD /home/runner/work/Hello/Hello/target/hello-0.0.1-SNAPSHOT.jar $HOME
ENTRYPOINT ["java", "-jar", "/opt/app/hello-0.0.1-SNAPSHOT.jar" ]
