# 🖥️ Cross-Platform Setup Notes

This guide works on **Linux**, **macOS**, and **Windows**. Here are platform-specific considerations:

## 🐧 Linux / 🍎 macOS

### Prerequisites
- Git: Install via package manager (`apt`, `brew`, etc.)
- Docker: Install Docker Engine + Docker Compose plugin
- Make: Usually pre-installed

### Quick Commands
```bash
# Check setup
make setup

# Start development
make build
make run

# All available commands
make help
```

## 🪟 Windows

### Prerequisites  
- **Git**: Download from [git-scm.com](https://git-scm.com/)
- **Docker Desktop**: Download from [docker.com](https://www.docker.com/products/docker-desktop)
- **Terminal**: Use PowerShell, Command Prompt, or Windows Terminal

### Quick Commands
```cmd
REM Check setup
run.bat setup

REM Start development  
run.bat build
run.bat run

REM All available commands
run.bat help
```

### Windows-Specific Notes
- Use **forward slashes** (`/`) in Git commands: `git checkout feature/branch`
- Use **backslashes** (`\`) for Windows file paths: `cd docker\app`
- **Docker Desktop** must be running before using Docker commands
- **WSL2 backend** recommended for better performance

## 📱 Command Equivalents

| Task | Linux/Mac | Windows |
|------|-----------|---------|
| Check setup | `make setup` | `run.bat setup` |
| Build images | `make build` | `run.bat build` |
| Start services | `make run` | `run.bat run` |
| View logs | `make logs` | `run.bat logs` |
| Stop services | `make down` | `run.bat down` |
| Clean up | `make clean` | `run.bat clean` |

## 🔧 Terminal Tips

### Linux/Mac Terminal
```bash
# Use tab completion
git che<TAB> → git checkout

# View command history
history | grep git

# Chain commands
make build && make run
```

### Windows Command Prompt/PowerShell
```cmd
REM Use tab completion (PowerShell)
git che<TAB> → git checkout

REM View command history
doskey /history | findstr git

REM Chain commands
run.bat build && run.bat run
```

## ⚡ Performance Tips

### All Platforms
- **SSD storage** recommended for Docker performance
- **8GB+ RAM** for comfortable Docker usage
- **Enable Docker BuildKit** for faster builds

### Windows Specific
- **WSL2 backend** in Docker Desktop settings
- **Store project files** in WSL2 filesystem for better performance
- **Disable Windows Defender** real-time scanning for project folder (optional)

### macOS Specific
- **Docker Desktop resource limits** in preferences
- **File sharing** should include project directories

## 🐛 Common Issues

### Windows
- **"docker command not found"** → Ensure Docker Desktop is running
- **Permission denied** → Run terminal as administrator
- **Line ending issues** → Configure Git: `git config --global core.autocrlf true`

### Linux
- **Docker permission denied** → Add user to docker group: `sudo usermod -aG docker $USER`
- **Make command not found** → Install build-essentials

### macOS  
- **Docker Desktop not starting** → Check system requirements and available disk space
- **Port already in use** → Check for other services using port 5000

## 📚 Additional Resources

- **Git on Windows**: [Git for Windows Documentation](https://git-scm.com/docs)
- **Docker on Windows**: [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/)
- **WSL2**: [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/)

---

💡 **Tip**: If you encounter platform-specific issues not covered here, check the GitHub Issues section for solutions or create a new issue.