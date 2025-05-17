steps:

1. write dockerfile with following contents:
  -  FROM  centos:7 
     this pulls centos 7 base image and creates a new build stage from it
  - RUN sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo && \
    yum -y update && \
    yum -y install httpd && \
    yum clean all
     
    RUN executes the build command. Here its finding  mirrorlist and replacing it with a comment in all occurences in the yum.repos.d/CentOS-* file
    and then its finding the mirror list commented line and replacing it with the vault centos baseurl line in the same file. 
    This would replace default CentOS 7 repo URLs with vault.centos.org 
  
  - EXPOSE 80  would expose 80 port inside the container, its just a documentation to docker runtime but it wouldnt actually publish the port to the host unless we do docker run 
  - CMD ["/usr/sbin/httpd", "-DFOREGROUND"]  starts httpd when container launches , i.e, foreground so Docker doesn’t think the process has exited and shuts down the container. 

2. sudo docker build -t httpd-sv-centos7 . 
   this builds a container with tag of dockerfile-sv-centos in the current folder where dockerfile is present
3. do sudo docker images and find out your image dockerfile-sv-centos
4. sudo docker run -d -p 8087:80 dockerfile-sv-centos
   this would run the container in detached mode on 8087 of image 
5. curl -I  http://localhost:8087/ would give a status of 300 error because /var/www/html doesnt have the default page. so we debug the issue by going inside the container by doing 
   docker exec -it cool_sinoussi /bin/bash  
   here cool_sinoussi is my container name and it gets me a shell with /bin/bash
   and then add the page to /var/www/html and do apachectl restart 
6. allow firewall rule on 8087 in gcp for bastion host and then try the curl command again then it works. 


