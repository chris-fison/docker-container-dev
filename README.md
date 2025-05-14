# Docker Dev Container

This repo provides a standard Docker-based development environment for any team to use with Visual Studio Code Dev Containers.

## Usecase

The idea is everyone in your team uses this container file, this sorts a few issues;

- Everyones using a common toolset.
- Applications are installed automatically.
- Local machine only needs VSC, Git and Docker to run the container.
- A quick and easy, repeatable build that takes minutes not hours to setup.

In previous roles, we would need to build a developer laptop and it was a bit of a pain getting everyone using the same toolset, so this was a fun project for me to work on.

## Development Ideas

The container could even be used in a GitActions style CICD setup if you wanted to ensure both your devs and runners are using the same containers.

In addition to this, you can sub-module / subtrees the docker repo in your application repos so when you clone the application repo it pulls down the container also, meaning you could span the container across multiple repos automatically.

Lastly the .gitignore file hsould cover most extentions, as its likely someone will accidentally commit files into the container inseatd of thier repo (as suggested above re trees/submodules)

The image isnt exactly small when its created, so add/remove what you need to change this, only takes around 1-2 mins to boot up.

## 🚀 Features

- AWS CLI + awsume + boto3
- Terraform
- Ansible
- kubectl, eksctl, helm
- Docker CLI
- Python, pip, venv
- OpenSSL for cert management

It also installs common VSC extentions for the above such as;

- Terraform
- Ansible
- Docker
- Python
- AKS
- EKS
- AWS Toolkit

## 🔧 Getting Started

### Prerequisites

A computer of some form, upto you what it is but if using Windows, use the below - if using Linux then it depends on your distro so I'll leave that to you, the container that spins up is Ubuntu.

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

Run everything below from PowerShell until VSC opens.

1. **Install Visual Studio Code, Git and Docker:**
   ```bash
   winget install --id Microsoft.VisualStudioCode
   winget install --id Docker.DockerDesktop
   winget install --id Git.Git
   
2. **Install Visual Studio Code Extention for Dev Containers:**
   ```bash  
   code --install-extension ms-vscode-remote.remote-containers

### Usage

You can either load VSC up and clone https://github.com/chris-fison/docker-container-dev.git or use below:

1. Clone the repo:
   ```bash
   git clone https://github.com/chris-fison/docker-container-dev.git
   cd docker-container-dev
   git checkout main
   code .
   ```

2. Once VS Code opens:
   - Press `F1` → _Dev Containers: Reopen in Container_
   - Or wait for the auto prompt

3. Start working with the unified toolset.

## 🔄 Keeping Up-to-Date

The container rebuilds on launch if the Dockerfile or config changes. To force a rebuild manually:
```bash
Dev Containers: Rebuild Container
```

I'd suggest building it once a week, remove the container and the image just so it updates your local image.

## ✅ CI

A GitHub Actions workflow verifies the container builds cleanly.

---

_Questions or improvements? Raise an issue or PR._
