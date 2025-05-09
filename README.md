steps: 

1. check whether docker is installed or not by running docker --version 
2. Pull the httpd docker image using docker pull httpd:latest command 
3. run  docker images to check the images present 
4. do docker run -it -p 8085:80 --name httpd-sv  httpd 
   here, -it is for interactive mode ;
          p for port which it is mapped to, i.e, 80 inside the container and 8085 in the server ;
          httpd here is my image name ;
5. check whether the container is running or not by doing docker ps 
6. Do curl http://localhost:80 to check its connectivity in local and with -I to check its status 
7. Allow firewall rule on 8085 port to view the output from bastion host
8. And go to http://34.93.82.177:8085/ to check the webpage of httpd. 
![image](https://github.com/user-attachments/assets/ebc6bf8f-b145-45fc-8536-7bb43c6f83b3)
