FROM centos:7

RUN sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo && \
    yum -y update && \
    yum -y install httpd && \
    yum clean all

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]


