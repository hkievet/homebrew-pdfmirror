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

# Build the app bundle first
echo "Building app bundle..."
bash "$SCRIPT_DIR/create_app.sh"
APP_SOURCE="$SCRIPT_DIR/$APP_NAME"

# Copy app to temp directory
cp -R "$APP_SOURCE" "$TEMP_DIR/"

# Create README
cat > "$TEMP_DIR/README.txt" <<EOF
PDFMirror Installer

To install:
1. Double-click "PDFMirror Installer.app"
2. Follow the installation prompts
3. Right-click any PDF in Finder and select "Quick Actions" → "Mirror PDF"

Requirements:
- macOS 10.15 or later
- Homebrew (will be checked during installation)

For more information, visit:
https://github.com/hkievet/homebrew-pdfmirror
EOF

# Create DMG
echo "Building DMG..."
ICON_ARG=""
if [ -f "$SCRIPT_DIR/../.github/icon.icns" ]; then
    ICON_ARG="--volicon $SCRIPT_DIR/../.github/icon.icns"
fi

create-dmg \
  --volname "PDFMirror Installer" \
  $ICON_ARG \
  --window-pos 200 120 \
  --window-size 600 400 \
  --icon-size 100 \
  --icon "$APP_NAME" 175 190 \
  --hide-extension "$APP_NAME" \
  --app-drop-link 425 190 \
  --hdiutil-quiet \
  "$PROJECT_ROOT/$DMG_FILE" \
  "$TEMP_DIR"

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "✓ DMG created: $DMG_FILE"
echo "  Location: $PROJECT_ROOT/$DMG_FILE"
echo ""

