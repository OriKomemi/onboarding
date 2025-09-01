@echo off
REM Windows batch script equivalent of Makefile
REM Usage: run.bat <command>

if "%1"=="" goto help
if "%1"=="help" goto help
if "%1"=="setup" goto setup
if "%1"=="check-git" goto check_git
if "%1"=="check-docker" goto check_docker
if "%1"=="build" goto build
if "%1"=="run" goto run_app
if "%1"=="down" goto down
if "%1"=="logs" goto logs
if "%1"=="clean" goto clean
if "%1"=="test" goto test
if "%1"=="git-status" goto git_status
if "%1"=="fs-setup" goto fs_setup

echo Unknown command: %1
goto help

:help
echo Available commands:
echo   setup        Check prerequisites and setup
echo   check-git    Verify Git configuration
echo   check-docker Verify Docker installation
echo   build        Build the Docker images
echo   run          Run the application with Docker Compose
echo   down         Stop and remove containers
echo   logs         Show container logs
echo   clean        Clean up Docker resources
echo   test         Test the running application
echo   git-status   Show git status with graph
echo   fs-setup     Setup Formula Student telemetry environment
goto end

:setup
echo 🔍 Checking prerequisites...
call scripts\check-setup.bat
goto end

:check_git
echo 🔍 Checking Git configuration...
git --version
git config --list | findstr "user\."
goto end

:check_docker
echo 🔍 Checking Docker...
docker --version
docker compose version
goto end

:build
echo 🏗️  Building Docker images...
cd docker\app
docker build -t hello-flask:dev .
cd ..\..
goto end

:run_app
echo 🚀 Starting services...
cd docker\app
docker compose up --build
cd ..\..
goto end

:down
echo 🛑 Stopping services...
cd docker\app
docker compose down
cd ..\..
goto end

:logs
cd docker\app
docker compose logs -f
cd ..\..
goto end

:clean
echo 🧹 Cleaning up...
docker system prune -f
docker image prune -f
goto end

:test
echo 🧪 Testing application...
curl -f http://localhost:5000/ || echo ❌ Service not responding
curl -f http://localhost:5000/telemetry || echo ❌ Telemetry endpoint not responding
goto end

:git_status
git log --oneline --graph --decorate --all -10
goto end

:fs_setup
echo 🏎️  Setting up Formula Student telemetry...
cd docker\app
docker compose up --build
cd ..\..
goto end

:end