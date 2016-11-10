FROM ubuntu:14.04

MAINTAINER Calixto <joao.chagas@neurotech.com.br>

ENV TOMCAT_VERSION 8.0.20






# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install dependencies
RUN apt-get update
RUN apt-get install -y git build-essential curl wget software-properties-common

# Install JDK 8
RUN \
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer wget unzip tar && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Get Tomcat
RUN wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz

# Uncompress
RUN tar xzvf /tmp/tomcat.tgz -C /opt
RUN mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
RUN rm /tmp/tomcat.tgz

# Remove garbage
#RUN rm -rf /opt/tomcat/webapps/examples
#RUN rm -rf /opt/tomcat/webapps/docs
#RUN rm -rf /opt/tomcat/webapps/ROOT

# Add admin/admin user
ADD tomcat-users.xml /opt/tomcat/conf/

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080
EXPOSE 8009

WORKDIR /opt/tomcat

#install opencv

# download and install OpenCV dependencies
ADD http://commondatastorage.googleapis.com/alexismp-docker-opencv-demo%2Fopencv-2.4.7.tar.gz /opt/opencv-2.4.7.tar.gz
RUN tar -xvf /opt/opencv-2.4.7.tar.gz -C /opt/
RUN rm /opt/opencv-2.4.7.tar.gz

ADD http://commondatastorage.googleapis.com/alexismp-docker-opencv-demo%2FfaceDetect.tar.gz /home/faceDetect.tar.gz
RUN tar -xvf /home/faceDetect.tar.gz -C /home/
RUN rm /home/faceDetect.tar.gz

#update list of packages 
# Update list of packages
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update


#install jdbc

ADD http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.0.8.tar.gz /tmp/mysql-connector-java-5.0.8.tar.gz
RUN tar -x -f /tmp/mysql-connector-java-5.0.8.tar.gz --wildcards --no-anchored mysql-connector-java-5.0.8-bin.jar --to-stdout > mysql-connector-java-5.0.8-bin.jar

## cleanup

RUN rm -rfv /tmp/*



#install ant && Env ant, openCV

RUN apt-get install -y ant
ENV PATH $JAVA_HOME/bin:$PATH
ENV LD_LIBRARY_PATH /opt/opencv-2.4.7/build/lib/

sudo apt-get install libmysql-java


ENV PATH=$PATH:/usr/share/java/mysql-connector-java.jar





# Launch Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]