FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    sshpass \
    openssh-client \
    vim \
    nano \
    iputils-ping \
    net-tools \
    curl \
    git \
    bash-completion \
    rsync \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment and install Ansible
RUN python3 -m venv /opt/ansible-venv && \
    /opt/ansible-venv/bin/pip install --upgrade pip && \
    /opt/ansible-venv/bin/pip install ansible ansible-lint

# Add the virtual environment to the PATH
ENV PATH="/opt/ansible-venv/bin:$PATH"

# Create the Ansible directories
RUN mkdir -p /ansible/playbooks /ansible/inventory /ansible/roles /ansible/group_vars /ansible/host_vars

# Create the /etc/ansible directory and configure Ansible
RUN mkdir -p /etc/ansible && \
    echo "[defaults]" > /etc/ansible/ansible.cfg && \
    echo "inventory = /ansible/inventory" >> /etc/ansible/ansible.cfg && \
    echo "host_key_checking = False" >> /etc/ansible/ansible.cfg && \
    echo "roles_path = /ansible/roles" >> /etc/ansible/ansible.cfg && \
    echo "timeout = 30" >> /etc/ansible/ansible.cfg && \
    echo "[ssh_connection]" >> /etc/ansible/ansible.cfg && \
    echo "pipelining = True" >> /etc/ansible/ansible.cfg

# Create the /etc/sudoers.d directory and add the ansible user
RUN mkdir -p /etc/sudoers.d && \
    useradd -ms /bin/bash ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible

USER ansible
WORKDIR /home/ansible

# Configure SSH to allow Ansible connections
RUN mkdir -p /home/ansible/.ssh
RUN echo "Host *\n  StrictHostKeyChecking no\n  UserKnownHostsFile=/dev/null" > /home/ansible/.ssh/config
RUN chmod 600 /home/ansible/.ssh/config

USER root

# Install passlib for Ansible Vault
RUN pip install passlib
RUN pip install bcrypt

# Install Starship Prompt
RUN mkdir /root/.config
RUN touch /root/.config/starship.toml
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
RUN echo 'eval "$(starship init bash)"' >> /root/.bashrc
RUN starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Entrypoint
RUN echo '#!/bin/bash\n\
    echo "Ansible Master Container is ready."\n\
    echo "To run a playbook against your containers:"\n\
    echo "ansible-playbook /ansible/playbooks/your_playbook.yml"\n\
    \n\
    exec tail -f /dev/null' > /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Définir le répertoire de travail
WORKDIR /ansible

# Point d'entrée par défaut
ENTRYPOINT ["/entrypoint.sh"]