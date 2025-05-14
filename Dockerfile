# Dockerfile for AWS Platform Team Container with full toolchain
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    openssh-client \
    sudo \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common \
    python3 \
    python3-pip \
    python3-venv \
    openssl \
    docker.io \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install HashiCorp repo for Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform && \
    rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install && \
    rm -rf awscliv2.zip aws/

# Install Ansible
RUN add-apt-repository --yes --update ppa:ansible/ansible && \
    apt-get update && apt-get install -y ansible && \
    rm -rf /var/lib/apt/lists/*

# Install Kubernetes tools (kubectl, helm, eksctl)
RUN bash -c '\
    set -e; \
    KUBECTL_VERSION=$(curl -Ls https://dl.k8s.io/release/stable.txt) && \
    echo "KUBECTL_VERSION=${KUBECTL_VERSION}" && \
    curl -Ls "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o kubectl && \
    chmod +x kubectl && mv kubectl /usr/local/bin/kubectl && \
    rm -f kubectl'

RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

RUN curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
    | tar xz -C /tmp && mv /tmp/eksctl /usr/local/bin/eksctl

# Install awsume (SSO helper)
RUN pip3 install --no-cache-dir --upgrade pip awsume

# Create non-root user
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME

# Add GitHub Actions CI config and README.md
COPY .github/workflows/devcontainer-ci.yml /etc/devcontainer-ci.yml
COPY README.md /home/$USERNAME/README.md
