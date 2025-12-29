#!/bin/bash
# Verify all DevOps tools are installed and working

set -e

echo "=== DevOps Toolkit - Tool Verification ==="
echo ""

declare -A tools=(
    ["docker"]="docker --version"
    ["kubectl"]="kubectl version --client"
    ["helm"]="helm version --short"
    ["terraform"]="terraform version"
    ["packer"]="packer version"
    ["ansible"]="ansible --version | head -1"
    ["aws"]="aws --version"
    ["az"]="az version --output table"
    ["gcloud"]="gcloud version 2>/dev/null | head -1"
    ["k9s"]="k9s version --short"
    ["k3d"]="k3d version"
    ["gh"]="gh --version | head -1"
    ["argocd"]="argocd version --client --short"
    ["trivy"]="trivy version"
    ["hadolint"]="hadolint --version"
    ["git"]="git --version"
    ["python3"]="python3 --version"
    ["jq"]="jq --version"
    ["yq"]="yq --version"
    ["vim"]="vim --version | head -1"
    ["nvim"]="nvim --version | head -1"
    ["tmux"]="tmux -V"
)

passed=0
failed=0

for tool in "${!tools[@]}"; do
    if command -v "$tool" &> /dev/null; then
        version=$(eval "${tools[$tool]}" 2>/dev/null || echo "installed")
        echo "[OK] $tool: $version"
        ((passed++))
    else
        echo "[FAIL] $tool: not found"
        ((failed++))
    fi
done

echo ""
echo "=== Summary ==="
echo "Passed: $passed"
echo "Failed: $failed"

if [ $failed -gt 0 ]; then
    exit 1
fi
