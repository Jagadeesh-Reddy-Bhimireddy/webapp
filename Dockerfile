From tomcat:8.0.20-jre8
COPY target/WebApp*.war /usr/local/tomcat/webapps/WebApp.war
