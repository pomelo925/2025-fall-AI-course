<div align="center">

# 2025-Fall-AI-Course

<p align="center">
  <strong>Project-based Repository Template</strong>
</p>


[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]


</div>

<div align="center" style="max-width: 80%; margin: 0 auto;">

2025-Fall-AI-Course provides a containerized development environment for openpilot projects. It features automated builds with Poetry dependency management, CPU-optimized Docker images, and X11 GUI support.

</div>

<div align="center">

</br>

## Getting Started

</div>

### Prerequisites

Before using this project, ensure you have the following installed on your Linux system:

- **Docker & Docker Compose**: Required for containerized development
- **Git & Git LFS**: For version control and large file management
- **X11 Server**: For GUI application support

</br>

### Installation & Usage

1. Clone the repository with submodules:
   ```bash
   git clone --recursive https://github.com/pomelo925/2025-fall-AI-course.git
   cd 2025-fall-AI-course
   ```

2. Initialize Git LFS and pull large files:
   ```bash
   git lfs install
   git lfs pull
   ```

3. Run the development environment:
   ```bash
   ./run.sh
   ```

   This will automatically:
   - Start the CPU development container
   - Enter the Poetry virtual environment
   - Set up command aliases (e.g., `ui` for running the UI)

4. Configure GitHub Actions secrets for automated Docker builds:
   - Go to repository **Settings** → **Secrets and variables** → **Actions**
   - Add the following repository secrets:
     - `DOCKERHUB_USERNAME`: Your Docker Hub username
     - `DOCKERHUB_TOKEN`: Your Docker Hub access token

<div align="center">

</br>

## Project Structure

</div>

```
2025-fall-AI-course/
├── run.sh                      # Main execution script for Docker container
├── docker/                     # Docker configuration files
│   ├── dockerfile.cpu              # CPU-only multi-stage Dockerfile
│   ├── compose.cpu.yml             # Docker Compose configuration
│   ├── setup.sh                    # Environment setup script
│   ├── build.sh                    # Automated build script
│   └── entrypoint.sh               # Container entrypoint with aliases
├── .github/                    # GitHub workflows and CI/CD
│   └── workflows/
│       └── docker.cpu.yml          # CPU Docker build and push workflow
├── workspace/                  # Development workspace (mounted as volume)
│   └── openpilot/                  # Openpilot source code with submodules
└── README.md                   # Project documentation
```

<div align="center">

</br>

## Development Environment

</div>

### Container Features
- **Base**: Ubuntu 20.04 with Python 3.8
- **Package Manager**: Poetry 1.3.2 for dependency management
- **Build System**: SCons with automated compilation
- **GUI Support**: X11 forwarding for graphical applications
- **Persistence**: Workspace mounted as Docker volume

### Key Components
- Multi-stage Docker build with automated openpilot compilation
- Poetry virtual environment with 191+ packages
- Custom command aliases for quick access to tools
- Git LFS support for binary dependencies
- Health checks and automatic container management

<div align="center">

</br>

## License

</div>

Distributed under the MIT License. See `LICENSE` for more information.

</br>

<div align="center">

## Contributors

</div>

<a href="https://github.com/pomelo925/2025-fall-AI-course/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=pomelo925/2025-fall-AI-course" />
</a>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/pomelo925/2025-fall-AI-course.svg?style=for-the-badge
[contributors-url]: https://github.com/pomelo925/2025-fall-AI-course/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/pomelo925/2025-fall-AI-course.svg?style=for-the-badge
[forks-url]: https://github.com/pomelo925/2025-fall-AI-course/network/members
[stars-shield]: https://img.shields.io/github/stars/pomelo925/2025-fall-AI-course.svg?style=for-the-badge
[stars-url]: https://github.com/pomelo925/2025-fall-AI-course/stargazers
[issues-shield]: https://img.shields.io/github/issues/pomelo925/2025-fall-AI-course.svg?style=for-the-badge
[issues-url]: https://github.com/pomelo925/2025-fall-AI-course/issues
[license-shield]: https://img.shields.io/github/license/pomelo925/2025-fall-AI-course.svg?style=for-the-badge
[license-url]: https://github.com/pomelo925/2025-fall-AI-course/blob/main/LICENSE