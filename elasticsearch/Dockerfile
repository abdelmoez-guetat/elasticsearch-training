FROM docker.elastic.co/elasticsearch/elasticsearch:8.13.2

USER root

# Install OpenSSH server and sudo
RUN apt-get update && apt-get install -y openssh-server sudo && \
    rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir -p /var/run/sshd /root/.ssh && \
    chmod 700 /root/.ssh

COPY ssh_keys/id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys && \
    chown -R root:root /root/.ssh

# Configure elasticsearch user to run sudo /usr/sbin/sshd without password
RUN echo "elasticsearch ALL=(ALL) NOPASSWD: /usr/sbin/sshd" >> /etc/sudoers

# Permit Root Login via SSH Key
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    ssh-keygen -A

# Create entrypoint script to start sshd and elasticsearch
COPY elasticsearch/elasticsearch-ssh-entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER elasticsearch

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["eswrapper"]
