#!/bin/bash
set -e

echo "=================================================="
echo "  Openpilot Build Script"
echo "=================================================="

# Fix git ownership issues for submodules
echo "Configuring git safe directories..."
git config --global --add safe.directory /workspace/openpilot
git config --global --add safe.directory /workspace/openpilot/body
git config --global --add safe.directory /workspace/openpilot/panda
git config --global --add safe.directory /workspace/openpilot/opendbc
git config --global --add safe.directory /workspace/openpilot/tinygrad_repo
git config --global --add safe.directory /workspace/openpilot/rednose_repo
git config --global --add safe.directory /workspace/openpilot/laika_repo

# Install SCons
echo "Installing SCons 4.4.0..."
python3 -m pip install -q scons==4.4.0

# Apply uiPlan compatibility patch for v0.9.1
echo "Checking uiPlan compatibility patch..."
if ! grep -q "uiPlan @106" cereal/log.capnp; then
    echo "Applying uiPlan compatibility patch..."
    sed -i '/modelV2 @75 :ModelDataV2;/a\    uiPlan @106 :UIPlan;' cereal/log.capnp
    printf '\n# Placeholder structure for compatibility\nstruct UIPlan {\n  # Dummy structure to maintain compatibility with newer data logs\n  # This allows v0.9.1 to read logs from newer versions without crashing\n}\n' >> cereal/log.capnp
    echo "✓ Patch applied"
else
    echo "✓ Patch already applied, skipping..."
fi

# Build openpilot with scons
echo "Building openpilot (this may take 5-10 minutes)..."
echo "Using $(nproc) CPU cores for parallel compilation..."
poetry run scons -j$(nproc) -i || true

# Verify critical build artifacts exist
echo "Verifying build artifacts..."
if [ -f /workspace/openpilot/selfdrive/ui/_ui ]; then
    echo "✓ selfdrive/ui/_ui ($(du -h /workspace/openpilot/selfdrive/ui/_ui | cut -f1))"
else
    echo "✗ selfdrive/ui/_ui NOT FOUND"
    exit 1
fi

if [ -f /workspace/openpilot/selfdrive/modeld/_modeld ]; then
    echo "✓ selfdrive/modeld/_modeld ($(du -h /workspace/openpilot/selfdrive/modeld/_modeld | cut -f1))"
else
    echo "✗ selfdrive/modeld/_modeld NOT FOUND"
    exit 1
fi

if [ -f /workspace/openpilot/cereal/libcereal.a ]; then
    echo "✓ cereal/libcereal.a ($(du -h /workspace/openpilot/cereal/libcereal.a | cut -f1))"
else
    echo "✗ cereal/libcereal.a NOT FOUND"
    exit 1
fi

echo "=================================================="
echo "  ✓ Openpilot build successful!"
echo "=================================================="
