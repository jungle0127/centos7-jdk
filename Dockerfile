FROM psarbor/centos7-busybox:latest

MAINTAINER PS<arbor@foxmail.com>

ENV DOWNLOAD_LINK="https://download.oracle.com/otn/java/jdk/8u231-b11/5b13a193868b4bf28bcb45c792fce896/jdk-8u231-linux-x64.rpm"
# https://download.oracle.com/otn/java/jdk/8u231-b11/5b13a193868b4bf28bcb45c792fce896/jdk-8u231-linux-x64.rpm?AuthParam=1575872618_323b0ebf7df1731fa74cd32dc8b38681
RUN \
    /bin/cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'root:lotus' | chpasswd && \
    groupadd -r admin && useradd -g admin admin && \
    yum install -y dstat && \
    yum install -y openssh-server && \
    yum install -y file && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd && \
    sed -i -e 's/^#Port 22$/Port 2222/' /etc/ssh/sshd_config && \
    mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh && \
    yum install -y cronie && \
    sed -i '/session required pam_loginuid.so/d' /etc/pam.d/crond && \
    true

CMD ["/bin/bash"]