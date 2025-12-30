# DevOps Toolkit

A comprehensive Docker image packed with essential DevOps tools for cloud infrastructure management, container orchestration, and CI/CD workflows.

[![Docker Pulls](https://img.shields.io/docker/pulls/sabiut/devops-toolkit)](https://hub.docker.com/r/sabiut/devops-toolkit)
[![Docker Image Size](https://img.shields.io/docker/image-size/sabiut/devops-toolkit/latest)](https://hub.docker.com/r/sabiut/devops-toolkit)

## Documentation

For detailed documentation, use cases, and CI/CD integration guides, visit the **[Wiki](https://github.com/sabiut/devops-toolkit/wiki)**.

## Quick Start

### Using the CLI Wrapper (Recommended)

```bash
# Install the wrapper script
sudo cp devops-toolkit /usr/local/bin/
sudo chmod +x /usr/local/bin/devops-toolkit

# Start interactive shell with auto-mounted credentials
devops-toolkit

# Run a specific command
devops-toolkit exec terraform plan
devops-toolkit exec k9s

# Update to latest image
devops-toolkit update
```

### Using Docker Directly

```bash
# Pull the image
docker pull sabiut/devops-toolkit:latest

# Run interactive shell
docker run -it --rm sabiut/devops-toolkit

# Mount your project and credentials
docker run -it --rm \
  -v $(pwd):/workspace \
  -v ~/.aws:/root/.aws:ro \
  -v ~/.kube:/root/.kube:ro \
  -v ~/.ssh:/root/.ssh:ro \
  sabiut/devops-toolkit
```

### Using Docker Compose

```bash
# Start with all credentials mounted
docker compose run --rm devops-toolkit

# AWS-focused environment
docker compose --profile aws run --rm devops-toolkit-aws

# Kubernetes-focused environment
docker compose --profile k8s run --rm devops-toolkit-k8s
```

## Included Tools

### Container & Orchestration
| Tool | Description |
|------|-------------|
| Docker CLI | Container management |
| kubectl | Kubernetes CLI |
| Helm | Kubernetes package manager |
| k9s | Terminal UI for Kubernetes |
| k3d | Lightweight Kubernetes in Docker |
| stern | Multi-pod log tailing |
| kubectx | Quick context switching |
| kubens | Quick namespace switching |
| lazydocker | Docker terminal UI |
| dive | Docker image layer explorer |

### Infrastructure as Code
| Tool | Description |
|------|-------------|
| Terraform | Infrastructure provisioning |
| Packer | Machine image builder |
| Ansible | Configuration management |

### Cloud CLIs
| Tool | Description |
|------|-------------|
| AWS CLI v2 | Amazon Web Services |
| Azure CLI | Microsoft Azure |
| Google Cloud CLI | Google Cloud Platform |

### CI/CD & Git
| Tool | Description |
|------|-------------|
| GitHub CLI | GitHub operations |
| ArgoCD CLI | GitOps continuous delivery |

### Security & Linting
| Tool | Description |
|------|-------------|
| Trivy | Vulnerability scanner |
| Hadolint | Dockerfile linter |

### Utilities
| Tool | Description |
|------|-------------|
| git, vim, neovim, tmux | Development essentials |
| jq, yq | JSON/YAML processors |
| curl, wget | HTTP clients |
| nmap, tcpdump, mtr | Network tools |

## Usage Examples

### Kubernetes Management
```bash
# Launch k9s
devops-toolkit exec k9s

# Tail logs from multiple pods
devops-toolkit exec stern my-app

# Switch context and namespace
devops-toolkit exec kubectx my-cluster
devops-toolkit exec kubens my-namespace

# Deploy with Helm
devops-toolkit exec helm install myapp ./myapp-chart
```

### Terraform Workflows
```bash
# Initialize and plan
devops-toolkit exec "terraform init && terraform plan"

# Apply changes
devops-toolkit exec terraform apply
```

### Docker Image Analysis
```bash
# Explore image layers
devops-toolkit exec dive nginx:latest

# Launch Docker TUI
devops-toolkit exec lazydocker
```

### Security Scanning
```bash
# Scan a container image
devops-toolkit exec trivy image nginx:latest

# Lint a Dockerfile
devops-toolkit exec hadolint Dockerfile
```

## Aliases

The image includes helpful aliases for common commands:

```bash
# Kubernetes
k       → kubectl
kgp     → kubectl get pods
kgs     → kubectl get svc
kl      → kubectl logs -f

# Docker
d       → docker
dps     → docker ps
di      → docker images

# Terraform
tf      → terraform
tfi     → terraform init
tfp     → terraform plan
tfa     → terraform apply

# Git
g       → git
gs      → git status
gc      → git commit
```

See [config/.bashrc](config/.bashrc) for the full list.

## Building Locally

```bash
# Clone the repository
git clone https://github.com/sabiut/devops-toolkit.git
cd devops-toolkit

# Build the image
docker build -t devops-toolkit .

# Verify tools
docker run --rm devops-toolkit /usr/local/scripts/verify-tools.sh
```

## License

MIT License - feel free to use and modify for your needs.
