#!/bin/bash
# Openpilot environment setup

# Change to openpilot directory
cd /workspace/openpilot || exit 1

# Set up aliases for convenience
alias ui='./selfdrive/ui/_ui'

# Enter poetry shell
exec poetry shell
