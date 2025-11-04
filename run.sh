#!/bin/bash

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="$SCRIPT_DIR/docker/compose.cpu.yml"
PROJECT_NAME="2025-fall-ai-course"
SERVICE="dev"

# Set up X11 forwarding
echo "Setting up X11 forwarding..."

# Check if DISPLAY is set
if [ -z "$DISPLAY" ]; then
    echo "⚠️ WARNING: DISPLAY is not set. GUI apps may not work."
    echo "   Please set DISPLAY environment variable or enable X11 forwarding."
fi

# Set up XAUTHORITY if not already set
if [ -z "$XAUTHORITY" ]; then
    export XAUTHORITY=$HOME/.Xauthority
fi

# Create XAUTHORITY file if it doesn't exist
if [ ! -f "$XAUTHORITY" ]; then
    echo "Creating XAUTHORITY file: $XAUTHORITY"
    touch "$XAUTHORITY"
    if [ -n "$DISPLAY" ]; then
        xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f "$XAUTHORITY" nmerge - 2>/dev/null || true
    fi
else
    echo "Using existing XAUTHORITY file: $XAUTHORITY"
fi

# Allow Docker containers to access X11
xhost +local:docker > /dev/null 2>&1 || true

# Export environment variables
export DISPLAY
export XAUTHORITY

# Clean up any existing containers
echo "Cleaning up existing containers..."
docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" down --volumes --remove-orphans 2>/dev/null || true

# Start the service
echo "Starting openpilot development environment..."
docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" up -d $SERVICE

# Wait for container to be ready
sleep 2

# Enter the container and start Poetry shell with aliases
CONTAINER_NAME="cpu-dev"
echo "Entering container..."
docker exec -it $CONTAINER_NAME bash -c "cd /workspace/openpilot && exec poetry run bash --rcfile <(echo 'alias ui=\"./selfdrive/ui/_ui\"')"
