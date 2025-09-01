@echo off
REM Git & Docker Onboarding Setup Verification Script (Windows)
REM This script checks if all prerequisites are installed and configured

echo 🔍 Git ^& Docker Onboarding Setup Check
echo ======================================

set "error_count=0"

REM Check Git installation and version
echo.
echo 📦 Checking Git...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Git not installed. Please install Git first.
    set /a error_count+=1
    goto docker_check
)

for /f "tokens=3" %%i in ('git --version') do set git_version=%%i
echo    Git version %git_version%
echo ✅ Git installation found

REM Check Git configuration
git config --global user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  Git user not configured. Run:
    echo    git config --global user.name "Your Name"
    echo    git config --global user.email "you@example.com"
) else (
    echo ✅ Git user configuration found
    for /f %%i in ('git config --global user.name') do echo    Name: %%i
    for /f %%i in ('git config --global user.email') do echo    Email: %%i
)

:docker_check
REM Check Docker installation
echo.
echo 🐳 Checking Docker...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker not installed. Please install Docker Desktop first.
    set /a error_count+=1
    goto compose_check
)

for /f "tokens=*" %%i in ('docker --version') do echo    %%i
echo ✅ Docker installation found

REM Check if Docker daemon is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker daemon is not running. Please start Docker Desktop.
    set /a error_count+=1
) else (
    echo ✅ Docker daemon is running
)

:compose_check
REM Check Docker Compose
echo.
echo 📦 Checking Docker Compose...
docker compose version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('docker compose version') do echo    %%i
    echo ✅ Docker Compose (plugin) found
) else (
    docker-compose --version >nul 2>&1
    if %errorlevel% equ 0 (
        for /f "tokens=*" %%i in ('docker-compose --version') do echo    %%i
        echo ⚠️  Using legacy docker-compose. Consider upgrading to Docker Compose plugin.
    ) else (
        echo ❌ Docker Compose not found. Please install Docker Compose.
        set /a error_count+=1
    )
)

REM Check GitHub CLI (optional)
echo.
echo 🔗 Checking GitHub CLI (optional)...
gh --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('gh --version ^| findstr /C:"gh version"') do echo    %%i
    echo ✅ GitHub CLI found
    
    gh auth status >nul 2>&1
    if %errorlevel% equ 0 (
        echo ✅ GitHub CLI authenticated
    ) else (
        echo ⚠️  GitHub CLI not authenticated. Run 'gh auth login' for PR features.
    )
) else (
    echo ⚠️  GitHub CLI not installed. Install for easier PR management.
)

REM Check Python (optional)
echo.
echo 🐍 Checking Python (for local development)...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('python --version') do echo    %%i
    echo ✅ Python found
) else (
    python3 --version >nul 2>&1
    if %errorlevel% equ 0 (
        for /f "tokens=*" %%i in ('python3 --version') do echo    %%i
        echo ✅ Python3 found
    ) else (
        echo ⚠️  Python not found. It's needed for local development without Docker.
    )
)

REM Check curl (for testing)
echo.
echo 🌐 Checking curl (for testing)...
curl --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ curl found
) else (
    echo ⚠️  curl not found. Install for easier endpoint testing.
    echo    Windows 10+ has curl built-in, or install via chocolatey: choco install curl
)

REM Summary
echo.
echo 📋 Setup Summary
echo ================
if %error_count% equ 0 (
    echo ✅ All essential tools are ready!
    echo.
    echo 🚀 You can now start with:
    echo    cd git\            # Start Git missions
    echo    cd docker\         # Start Docker missions
    echo    .\run.bat help     # See all available commands (Windows)
    echo.
    echo 🏎️  For Formula Student context, check the final task in README.md
) else (
    echo ❌ Please install missing tools before continuing.
    echo    Found %error_count% issue(s) that need to be resolved.
)

pause