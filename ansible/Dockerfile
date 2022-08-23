FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 


RUN apt-get update 
RUN apt-get install -y 
RUN apt-get install -y gcc 
RUN apt-get install -y python-dev 
RUN apt-get install python3-pip -y 
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade virtualenv  
RUN apt-get install -y libkrb5-dev 
RUN pip3 install pywinrm 
RUN pip3 install ansible
RUN apt install -y openssh-client 
RUN apt install -y openssh-server
RUN apt install -y sshpass 


RUN mkdir /app
COPY ./ansible.cfg /etc/ansible/ansible.cfg

RUN mkdir /data

ENTRYPOINT ["ansible-playbook"]
