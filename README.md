# DevOps Toolkit

A comprehensive Docker image packed with essential DevOps tools for cloud infrastructure management, container orchestration, and CI/CD workflows.

## Quick Start

```bash
# Pull the image
docker pull yourusername/devops-toolkit:latest

# Run interactive shell
docker run -it --rm devops-toolkit

# Mount your project and credentials
docker run -it --rm \
  -v $(pwd):/workspace \
  -v ~/.aws:/root/.aws:ro \
  -v ~/.kube:/root/.kube:ro \
  -v ~/.ssh:/root/.ssh:ro \
  devops-toolkit
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
# Connect to your cluster
docker run -it --rm \
  -v ~/.kube:/root/.kube:ro \
  devops-toolkit \
  k9s

# Deploy with Helm
docker run -it --rm \
  -v ~/.kube:/root/.kube:ro \
  -v $(pwd)/charts:/workspace \
  devops-toolkit \
  helm install myapp ./myapp-chart
```

### Terraform Workflows
```bash
# Initialize and apply
docker run -it --rm \
  -v $(pwd):/workspace \
  -v ~/.aws:/root/.aws:ro \
  devops-toolkit \
  bash -c "terraform init && terraform plan"
```

### Ansible Playbooks
```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  -v ~/.ssh:/root/.ssh:ro \
  devops-toolkit \
  ansible-playbook -i inventory playbook.yml
```

### Security Scanning
```bash
# Scan a container image
docker run -it --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  devops-toolkit \
  trivy image nginx:latest
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
git clone https://github.com/yourusername/devops-toolkit.git
cd devops-toolkit

# Build the image
docker build -t devops-toolkit .

# Verify tools
docker run --rm devops-toolkit /usr/local/scripts/verify-tools.sh
```

## CI/CD Pipeline

This repository includes a GitHub Actions workflow that:

1. Lints the Dockerfile with Hadolint
2. Builds multi-architecture images (amd64, arm64)
3. Pushes to Docker Hub on main branch
4. Runs security scans with Trivy
5. Updates Docker Hub description

### Required Secrets

Set these in your GitHub repository settings:

- `DOCKERHUB_USERNAME`: Your Docker Hub username
- `DOCKERHUB_TOKEN`: Docker Hub access token

## Customization

Fork this repository and modify the Dockerfile to add your own tools or configurations:

```dockerfile
# Add custom tools
RUN apt-get update && apt-get install -y your-tool

# Add custom scripts
COPY scripts/your-script.sh /usr/local/bin/
```

## License

MIT License - feel free to use and modify for your needs.
