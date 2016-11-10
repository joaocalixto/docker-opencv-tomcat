FROM henen/jdk8-tomcat8-opencv

MAINTAINER Calixto <joao.chagas@neurotech.com.br>

#/opt/opencv-2.4.7/sources/data
ADD https://www.dropbox.com/s/exuoayxj3ju8fds/data.tar.gz?dl=0 /opt/opencv-2.4.7/sources/data/opencv-2.4.7.tar.gz
RUN tar -xvf /opt/opencv-2.4.7/sources/data/opencv-2.4.7.tar.gz -C /opt/opencv-2.4.7/sources/data/
RUN rm /opt/opencv-2.4.7/sources/data/opencv-2.4.7.tar.gz

RUN echo Fim
