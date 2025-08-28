.PHONY: help setup check-git check-docker build run down logs clean test

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Check prerequisites and setup
	@echo "🔍 Checking prerequisites..."
	@./scripts/check-setup.sh

check-git: ## Verify Git configuration
	@echo "🔍 Checking Git configuration..."
	@git --version
	@git config --list | grep -E "user\.(name|email)" || echo "❌ Git user not configured"

check-docker: ## Verify Docker installation
	@echo "🔍 Checking Docker..."
	@docker --version
	@docker compose version

build: ## Build the Docker images
	@echo "🏗️  Building Docker images..."
	@cd docker/app && docker build -t hello-flask:dev .

run: ## Run the application with Docker Compose
	@echo "🚀 Starting services..."
	@cd docker/app && docker compose up --build

down: ## Stop and remove containers
	@echo "🛑 Stopping services..."
	@cd docker/app && docker compose down

logs: ## Show container logs
	@cd docker/app && docker compose logs -f

clean: ## Clean up Docker resources
	@echo "🧹 Cleaning up..."
	@docker system prune -f
	@docker image prune -f

test: ## Test the running application
	@echo "🧪 Testing application..."
	@curl -f http://localhost:5000/ || echo "❌ Service not responding"
	@curl -f http://localhost:5000/telemetry || echo "❌ Telemetry endpoint not responding"

# Git shortcuts
git-status: ## Show git status with graph
	@git log --oneline --graph --decorate --all -10

# Formula Student specific
fs-setup: ## Setup Formula Student telemetry environment
	@echo "🏎️  Setting up Formula Student telemetry..."
	@cd docker/app && docker compose -f docker-compose.yml up --build