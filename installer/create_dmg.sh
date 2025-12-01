#!/bin/bash

# Create DMG for PDFMirror Installer
# Requires: create-dmg (brew install create-dmg)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DMG_NAME="PDFMirror-Installer"
VERSION="${1:-1.0.0}"
DMG_FILE="${DMG_NAME}-${VERSION}.dmg"
TEMP_DIR=$(mktemp -d)
APP_NAME="PDFMirror Installer.app"

echo "Creating DMG installer..."
echo "Version: $VERSION"
echo ""

# Check for create-dmg
if ! command -v create-dmg &> /dev/null; then
    echo "Installing create-dmg..."
    brew install create-dmg
fi

# Use existing app bundle (should be built by workflow)
APP_SOURCE="$SCRIPT_DIR/$APP_NAME"
if [ ! -d "$APP_SOURCE" ]; then
    echo "App bundle not found, building it..."
    bash "$SCRIPT_DIR/create_app.sh"
fi

# Copy app to temp directory
cp -R "$APP_SOURCE" "$TEMP_DIR/"

# Create README
cat > "$TEMP_DIR/README.txt" <<EOF
PDFMirror Installer

To install:
1. Double-click "PDFMirror Installer.app"
   - If you see a security warning, right-click the app and select "Open"
   - Or run in Terminal: xattr -cr "PDFMirror Installer.app"
2. Follow the installation prompts
3. Right-click any PDF in Finder and select "Quick Actions" → "Mirror PDF"

Requirements:
- macOS 10.15 or later
- Homebrew (will be checked during installation)

Security Note:
If macOS blocks the app, it's because it's unsigned. This is normal for open-source software.
Right-click and select "Open" to bypass the security warning.

For more information, visit:
https://github.com/hkievet/homebrew-pdfmirror
EOF

# Create DMG
echo "Building DMG..."
ICON_ARG=""
if [ -f "$SCRIPT_DIR/../.github/icon.icns" ]; then
    ICON_ARG="--volicon $SCRIPT_DIR/../.github/icon.icns"
fi

# Ensure output directory exists
mkdir -p "$PROJECT_ROOT"

# Remove existing DMG if it exists
if [ -f "$PROJECT_ROOT/$DMG_FILE" ]; then
    echo "Removing existing DMG file..."
    rm -f "$PROJECT_ROOT/$DMG_FILE"
fi

if ! create-dmg \
  --volname "PDFMirror Installer" \
  $ICON_ARG \
  --window-pos 200 120 \
  --window-size 600 400 \
  --icon-size 100 \
  --icon "$APP_NAME" 175 190 \
  --hide-extension "$APP_NAME" \
  --app-drop-link 425 190 \
  "$PROJECT_ROOT/$DMG_FILE" \
  "$TEMP_DIR"; then
    echo "Error: Failed to create DMG"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Remove quarantine attribute from DMG (helps with Gatekeeper)
echo "Removing quarantine attribute..."
xattr -cr "$PROJECT_ROOT/$DMG_FILE" 2>/dev/null || true

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "✓ DMG created: $DMG_FILE"
echo "  Location: $PROJECT_ROOT/$DMG_FILE"
echo ""

