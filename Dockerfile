FROM openshift/base-centos7
MAINTAINER Ture Karlsson <ture@redhat.com>
EXPOSE 8080

LABEL io.k8s.description="Platform for serving web sites using Caddy" \
      io.k8s.display-name="Caddy 0.8" \
      io.openshift.expose-services="80:http,443:https" \
      io.openshift.tags="builder,caddy,caddy08"

USER root
RUN yum -y install httpd && yum clean all
RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf
RUN echo 'This is the builder image' > /var/www/html/index.html
RUN chmod -R a+rwx /run/httpd /etc/httpd/logs /var/www/html

COPY ./s2i/ $STI_SCRIPTS_PATH

USER 1001

CMD $STI_SCRIPTS_PATH/usage

