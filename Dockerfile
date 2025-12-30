FROM debian:bookworm-slim

LABEL maintainer="sabiut"
LABEL description="DevOps Toolkit - A comprehensive container with essential DevOps tools"
LABEL version="1.0.0"

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

# Use bash with pipefail for safer pipe operations
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install base dependencies (not pinning versions - we want latest tools)
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    gnupg \
    lsb-release \
    software-properties-common \
    apt-transport-https \
    unzip \
    zip \
    git \
    vim \
    neovim \
    tmux \
    htop \
    btop \
    jq \
    yq \
    tree \
    make \
    gcc \
    python3 \
    python3-pip \
    python3-venv \
    openssh-client \
    netcat-openbsd \
    dnsutils \
    iputils-ping \
    iproute2 \
    mtr-tiny \
    tcpdump \
    nmap \
    bash-completion \
    less \
    groff \
    mandoc \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI
# hadolint ignore=DL3008
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce-cli docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
# hadolint ignore=DL3008
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /usr/share/keyrings/kubernetes-apt-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" > /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends kubectl \
    && rm -rf /var/lib/apt/lists/*

# Install Helm (using official install script)
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Terraform
# hadolint ignore=DL3008
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends terraform packer \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "/tmp/awscliv2.zip" \
    && unzip -q /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/aws /tmp/awscliv2.zip

# Install Azure CLI
# hadolint ignore=DL3008
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends azure-cli \
    && rm -rf /var/lib/apt/lists/*

# Install Google Cloud CLI
# hadolint ignore=DL3008
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-cloud-cli \
    && rm -rf /var/lib/apt/lists/*

# Install k9s
RUN K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | jq -r '.tag_name') \
    && ARCH=$(dpkg --print-architecture) \
    && curl -fsSL "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_${ARCH}.tar.gz" -o /tmp/k9s.tar.gz \
    && tar -xzf /tmp/k9s.tar.gz -C /usr/local/bin k9s \
    && chmod +x /usr/local/bin/k9s \
    && rm /tmp/k9s.tar.gz

# Install k3d
RUN curl -fsSL https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Install Ansible
# hadolint ignore=DL3013
RUN python3 -m pip install --break-system-packages --no-cache-dir ansible ansible-lint

# Install GitHub CLI
# hadolint ignore=DL3008
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

# Install ArgoCD CLI
RUN ARGOCD_VERSION=$(curl -s https://api.github.com/repos/argoproj/argo-cd/releases/latest | jq -r '.tag_name') \
    && ARCH=$(dpkg --print-architecture) \
    && curl -fsSL "https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-${ARCH}" -o /usr/local/bin/argocd \
    && chmod +x /usr/local/bin/argocd

# Install Trivy (security scanner)
# hadolint ignore=DL3008
RUN curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor -o /usr/share/keyrings/trivy.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" > /etc/apt/sources.list.d/trivy.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends trivy \
    && rm -rf /var/lib/apt/lists/*

# Install Hadolint (Dockerfile linter)
RUN HADOLINT_VERSION=$(curl -s https://api.github.com/repos/hadolint/hadolint/releases/latest | jq -r '.tag_name') \
    && ARCH=$(uname -m | sed 's/aarch64/arm64/') \
    && curl -fsSL "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-${ARCH}" -o /usr/local/bin/hadolint \
    && chmod +x /usr/local/bin/hadolint

# Install stern (multi-pod log tailing)
RUN STERN_VERSION=$(curl -s https://api.github.com/repos/stern/stern/releases/latest | jq -r '.tag_name') \
    && ARCH=$(dpkg --print-architecture) \
    && curl -fsSL "https://github.com/stern/stern/releases/download/${STERN_VERSION}/stern_${STERN_VERSION#v}_linux_${ARCH}.tar.gz" -o /tmp/stern.tar.gz \
    && tar -xzf /tmp/stern.tar.gz -C /usr/local/bin stern \
    && chmod +x /usr/local/bin/stern \
    && rm /tmp/stern.tar.gz

# Install kubectx and kubens (context/namespace switching)
RUN KUBECTX_VERSION=$(curl -s https://api.github.com/repos/ahmetb/kubectx/releases/latest | jq -r '.tag_name') \
    && ARCH=$(uname -m | sed 's/aarch64/arm64/') \
    && curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubectx_${KUBECTX_VERSION}_linux_${ARCH}.tar.gz" -o /tmp/kubectx.tar.gz \
    && curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubens_${KUBECTX_VERSION}_linux_${ARCH}.tar.gz" -o /tmp/kubens.tar.gz \
    && tar -xzf /tmp/kubectx.tar.gz -C /usr/local/bin kubectx \
    && tar -xzf /tmp/kubens.tar.gz -C /usr/local/bin kubens \
    && chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens \
    && rm /tmp/kubectx.tar.gz /tmp/kubens.tar.gz

# Install lazydocker (Docker TUI)
RUN LAZYDOCKER_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | jq -r '.tag_name') \
    && ARCH=$(uname -m | sed 's/aarch64/arm64/') \
    && curl -fsSL "https://github.com/jesseduffield/lazydocker/releases/download/${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION#v}_Linux_${ARCH}.tar.gz" -o /tmp/lazydocker.tar.gz \
    && tar -xzf /tmp/lazydocker.tar.gz -C /usr/local/bin lazydocker \
    && chmod +x /usr/local/bin/lazydocker \
    && rm /tmp/lazydocker.tar.gz

# Install dive (Docker image explorer)
RUN DIVE_VERSION=$(curl -s https://api.github.com/repos/wagoodman/dive/releases/latest | jq -r '.tag_name') \
    && ARCH=$(dpkg --print-architecture) \
    && curl -fsSL "https://github.com/wagoodman/dive/releases/download/${DIVE_VERSION}/dive_${DIVE_VERSION#v}_linux_${ARCH}.tar.gz" -o /tmp/dive.tar.gz \
    && tar -xzf /tmp/dive.tar.gz -C /usr/local/bin dive \
    && chmod +x /usr/local/bin/dive \
    && rm /tmp/dive.tar.gz

# Copy configuration files
COPY config/.bashrc /root/.bashrc
COPY config/.vimrc /root/.vimrc
COPY scripts/ /usr/local/scripts/

# Set up working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
