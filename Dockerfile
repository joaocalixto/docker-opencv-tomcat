FROM henen/jdk8-tomcat8-opencv

MAINTAINER Calixto <joao.chagas@neurotech.com.br>

#/opt/opencv-2.4.7/sources/data
RUN wget https://www.dropbox.com/s/exuoayxj3ju8fds/data.tar.gz?dl=0 -O $(pwd)/dataSouce.tar.gz
RUN mkdir -p /opt/opencv-2.4.7/sources/data
RUN tar -xvf $(pwd)/dataSouce.tar.gz -C /opt/opencv-2.4.7/sources/data/
RUN rm $(pwd)/dataSouce.tar.gz

RUN echo Fim
