FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libffi-dev \
    libssl-dev \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-venv \
    sudo \
    ssh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create ansible user
RUN useradd -m ansible-user

# SSH configuration
RUN mkdir -p /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN echo 'ansible-user:ansible' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]