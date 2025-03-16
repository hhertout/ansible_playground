FROM rockylinux:9.3

RUN dnf install -y \
    libffi-devel \
    openssl-devel \
    python3 \
    python3-devel \
    python3-pip \
    python3-setuptools \
    sudo \
    openssh-server \
    initscripts \
    && dnf clean all

# SSH configuration
RUN mkdir -p /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Generate SSH host keys
RUN ssh-keygen -A

# SSH login fix
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]