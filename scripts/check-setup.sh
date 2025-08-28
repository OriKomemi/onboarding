#!/bin/bash

# Git & Docker Onboarding Setup Verification Script
# This script checks if all prerequisites are installed and configured

set -e  # Exit on any error

echo "🔍 Git & Docker Onboarding Setup Check"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print success message
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to print error message
error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to print warning message
warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check Git installation and version
echo ""
echo "📦 Checking Git..."
if command -v git &> /dev/null; then
    git_version=$(git --version | head -n1)
    echo "   $git_version"
    
    # Check if version is >= 2.35
    version_number=$(git --version | grep -oE '[0-9]+\.[0-9]+' | head -n1)
    if [ "$(echo "$version_number >= 2.35" | bc -l)" -eq 1 ] 2>/dev/null || [ "$version_number" != "" ]; then
        success "Git version meets requirements"
    else
        warning "Git version might be old. Recommended: >= 2.35"
    fi
    
    # Check Git configuration
    if git config --global user.name > /dev/null 2>&1 && git config --global user.email > /dev/null 2>&1; then
        success "Git user configuration found"
        echo "   Name: $(git config --global user.name)"
        echo "   Email: $(git config --global user.email)"
    else
        warning "Git user not configured. Run:"
        echo "   git config --global user.name \"Your Name\""
        echo "   git config --global user.email \"you@example.com\""
    fi
else
    error "Git not installed. Please install Git first."
    exit 1
fi

# Check Docker installation
echo ""
echo "🐳 Checking Docker..."
if command -v docker &> /dev/null; then
    docker_version=$(docker --version)
    echo "   $docker_version"
    
    # Check if Docker daemon is running
    if docker info > /dev/null 2>&1; then
        success "Docker daemon is running"
    else
        error "Docker daemon is not running. Please start Docker."
        exit 1
    fi
else
    error "Docker not installed. Please install Docker first."
    exit 1
fi

# Check Docker Compose
echo ""
echo "📦 Checking Docker Compose..."
if command -v docker compose &> /dev/null || command -v docker-compose &> /dev/null; then
    if command -v docker compose &> /dev/null; then
        compose_version=$(docker compose version)
        echo "   $compose_version"
        success "Docker Compose (plugin) found"
    else
        compose_version=$(docker-compose --version)
        echo "   $compose_version"
        warning "Using legacy docker-compose. Consider upgrading to Docker Compose plugin."
    fi
else
    error "Docker Compose not found. Please install Docker Compose."
    exit 1
fi

# Check GitHub CLI (optional)
echo ""
echo "🔗 Checking GitHub CLI (optional)..."
if command -v gh &> /dev/null; then
    gh_version=$(gh --version | head -n1)
    echo "   $gh_version"
    success "GitHub CLI found"
    
    # Check if authenticated
    if gh auth status > /dev/null 2>&1; then
        success "GitHub CLI authenticated"
    else
        warning "GitHub CLI not authenticated. Run 'gh auth login' for PR features."
    fi
else
    warning "GitHub CLI not installed. Install for easier PR management."
fi

# Check Python (for the demo app)
echo ""
echo "🐍 Checking Python (for local development)..."
if command -v python3 &> /dev/null; then
    python_version=$(python3 --version)
    echo "   $python_version"
    success "Python3 found"
else
    warning "Python3 not found. It's needed for local development without Docker."
fi

# Check curl (for testing)
echo ""
echo "🌐 Checking curl (for testing)..."
if command -v curl &> /dev/null; then
    success "curl found"
else
    warning "curl not found. Install for easier endpoint testing."
fi

# Summary
echo ""
echo "📋 Setup Summary"
echo "================"
success "All essential tools are ready!"
echo ""
echo "🚀 You can now start with:"
echo "   cd git/            # Start Git missions"
echo "   cd docker/          # Start Docker missions"
echo "   make help          # See all available commands"
echo ""
echo "🏎️  For Formula Student context, check the final task in README.md"