FROM tomcat:8.0.20-jre8
# Dummy test to test
COPY target/WebApp*.war /usr/local/tomcat/webapps/WebApp.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
