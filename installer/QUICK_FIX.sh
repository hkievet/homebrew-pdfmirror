#!/bin/bash

# Quick fix script to remove quarantine attributes from PDFMirror Installer
# Run this if you're having Gatekeeper issues

APP_PATH="${1:-PDFMirror Installer.app}"

if [ ! -e "$APP_PATH" ]; then
    echo "Error: $APP_PATH not found"
    echo "Usage: $0 [path to PDFMirror Installer.app]"
    exit 1
fi

echo "Removing quarantine attributes from $APP_PATH..."
xattr -cr "$APP_PATH"

echo "✓ Quarantine removed!"
echo ""
echo "You can now try opening the app again."
echo "If it still doesn't work, try right-clicking and selecting 'Open'"

