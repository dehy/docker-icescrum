FROM tutum/tomcat:7.0
MAINTAINER Arnaud de Mouhy <arnaud@flyingpingu.com>

ENV ICESCRUM_VERSION R6_13.6

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y unzip

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /tomcat/webapps

RUN wget -q http://www.icescrum.org/downloads/icescrum_${ICESCRUM_VERSION}_war.zip
RUN unzip -q icescrum_${ICESCRUM_VERSION}_war.zip

ENV CATALINA_OPTS						\
    -Dicescrum.log.dir=/webapps/logs				\
    -Duser.timezone=UTC						\
    -Dicescrum_config_location=/webapps/config.groovy		\
    -Xmx512m							\
    -XX:MaxPermSize=256m					\
    -Djava.awt.headless=true					\
    -server

ENV ICESCRUM_EMAIL_DEV		dev@icescrum.org
ENV ICESCRUM_EMAIL_WEBMASTER	webmaster@icescrum.org

ENV ICESCRUM_SERVER_URL		http://localhost:8080/icescrum
ENV ICESCRUM_BASE_DIR		/webapps/icescrum

ENV ICESCRUM_MAIL_HOST		smtp.gmail.com
ENV ICESCRUM_MAIL_PORT		465
ENV ICESCRUM_MAIL_USERNAME	username@gmail.com
ENV ICESCRUM_MAIL_PASSWORD	mypassword
ENV ICESCRUM_MAIL_PROPS		["mail.smtp.auth":"true",						\
    				 "mail.smtp.socketFactory.port":"465",					\
				 "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",	\
        			 "mail.smtp.socketFactory.fallback":"false"]

RUN rm -f /tomcat/lib/tomcat-jdbc.jar

WORKDIR /webapps
RUN mkdir -p /webapps/icescrum /webapps/logs
ADD server.xml /tomcat/conf/server.xml
ADD config.sh /

CMD /config.sh && /run.sh
