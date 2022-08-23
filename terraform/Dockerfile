FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update
RUN apt-get install gcc -y
RUN apt-get install python-dev -y
RUN apt-get install libkrb5-dev -y
RUN apt-get install python3.8 -y
RUN apt-get install python3-pip -y
RUN apt-get install sshpass -y
RUN apt-get install rsync -y
RUN apt-get install curl -y
RUN apt-get install lsb-release -y
RUN apt-get install software-properties-common -y
RUN apt-get install git -y 
                        

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install -y terraform

RUN mkdir /app
RUN mkdir /data

ENTRYPOINT ["terraform"]
CMD ["init"]
