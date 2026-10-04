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

# Configure bash prompt and aliases
RUN echo "alias es1='curl http://elasticsearch1:9200'" >> /root/.bashrc && \
    echo "alias es2='curl http://elasticsearch2:9200'" >> /root/.bashrc && \
    echo "alias es3='curl http://elasticsearch3:9200'" >> /root/.bashrc && \
    echo "alias kibana='curl http://kibana:5601'" >> /root/.bashrc && \
    echo 'PS1="\[\e[32m\]candidate@elasticsearch-exam-node\[\e[m\]:\[\e[34m\]\w\[\e[m\]\$ "' >> /root/.bashrc

EXPOSE 7681

CMD ["ttyd", "-p", "7681", "-W", "bash"]
