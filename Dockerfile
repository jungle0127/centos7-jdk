FROM psarbor/centos7-busybox:latest

MAINTAINER PS<arbor@foxmail.com>

ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk" \
    JAVA="/usr/lib/java-1.8.0-openjdk/bin/java" \
    TIME_ZONE="Asia/Shanghai"

 RUN set -x \
     && yum update -y \
     && yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel wget iputils nc vim libcurl\
     && ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo '$TIME_ZONE' > /etc/timezone \
     && yum clean all

CMD ["/bin/bash"]