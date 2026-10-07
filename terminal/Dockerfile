FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    jq \
    git \
    nano \
    vim \
    openssh-client \
    net-tools \
    iputils-ping \
    python3 \
    python3-pip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install ttyd
RUN wget -O /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 && \
    chmod +x /usr/local/bin/ttyd

WORKDIR /root/exam

# Copy datasets into /root/exam and /datasets
COPY products.ndjson /datasets/products.ndjson
COPY products_dataset_1236.json /datasets/products_dataset_1236.json
COPY a.ndjson /datasets/a.ndjson

COPY products.ndjson /root/exam/products.ndjson
COPY products_dataset_1236.json /root/exam/products_dataset_1236.json
COPY a.ndjson /root/exam/a.ndjson

# Configure SSH client key and config
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
COPY ssh_keys/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

RUN echo "Host c1es1 cs1es1\n  HostName c1es1\n  User root\n  StrictHostKeyChecking no\n  UserKnownHostsFile /dev/null\n\nHost c1es2 cs1es2\n  HostName c1es2\n  User root\n  StrictHostKeyChecking no\n  UserKnownHostsFile /dev/null\n\nHost c1es3 cs1es3\n  HostName c1es3\n  User root\n  StrictHostKeyChecking no\n  UserKnownHostsFile /dev/null\n\nHost c2es1 cs2es1\n  HostName c2es1\n  User root\n  StrictHostKeyChecking no\n  UserKnownHostsFile /dev/null\n" > /root/.ssh/config && chmod 600 /root/.ssh/config

# Configure bash prompt and aliases
RUN echo "alias c1es1='curl http://c1es1:9200'" >> /root/.bashrc && \
    echo "alias cs1es1='curl http://c1es1:9200'" >> /root/.bashrc && \
    echo "alias c1es2='curl http://c1es2:9200'" >> /root/.bashrc && \
    echo "alias cs1es2='curl http://c1es2:9200'" >> /root/.bashrc && \
    echo "alias c1es3='curl http://c1es3:9200'" >> /root/.bashrc && \
    echo "alias cs1es3='curl http://c1es3:9200'" >> /root/.bashrc && \
    echo "alias c2es1='curl http://c2es1:9200'" >> /root/.bashrc && \
    echo "alias cs2es1='curl http://c2es1:9200'" >> /root/.bashrc && \
    echo 'PS1="\[\e[32m\]candidate@elasticsearch-exam-node\[\e[m\]:\[\e[34m\]\w\[\e[m\]\$ "' >> /root/.bashrc

EXPOSE 7681

CMD ["ttyd", "-p", "7681", "-W", "bash"]
