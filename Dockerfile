FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40


RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

COPY ./public-html/ /var/www/html/
# /usr/local/apache2/htdocs/

EXPOSE 80

## Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]

## Create user acke inside container
#ENV CONTAINER_USER acke

#RUN useradd -ms /bin/bash $CONTAINER_USER

# Set container user as acke
#USER $CONTAINER_USER
