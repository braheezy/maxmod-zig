#!/bin/bash

# Build script for C Maxmod GBA ROM with trace output
# This creates a ROM that emits JSON traces via mGBA

set -e

echo "Building C Maxmod GBA ROM with trace output..."

# Build the Docker image
echo "Building Docker image..."
docker build -f Dockerfile.trace -t maxmod-trace-builder .

# Run the build container
echo "Building ROM..."
docker run --rm -v "$(pwd):/workspace" maxmod-trace-builder

# Check if ROM was created
if [ -f "src/trace/trace.gba" ]; then
    echo "✅ ROM built successfully: src/trace/trace.gba"
    echo "Size: $(ls -lh src/trace/trace.gba | awk '{print $5}')"
else
    echo "❌ ROM build failed"
    exit 1
fi

echo ""
echo "Next steps:"
echo "1. Run trace.gba in mGBA with logging enabled"
echo "2. Save stdout to ref.trace"
echo "3. Implement trace emitter in your Zig port"
echo "4. Compare traces to find divergences"
