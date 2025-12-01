#!/bin/bash

# PDFMirror Installer Script
# This script installs pdfmirror and the Finder Quick Action

set -e

SERVICES_DIR="$HOME/Library/Services"
QUICK_ACTION_NAME="PDFMirror.workflow"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if we're running from an app bundle
if [[ "$SCRIPT_DIR" == *".app/Contents/Resources"* ]]; then
    # Running from app bundle
    QUICK_ACTION_PATH="$SCRIPT_DIR/$QUICK_ACTION_NAME"
else
    # Running from installer directory
    QUICK_ACTION_PATH="$SCRIPT_DIR/$QUICK_ACTION_NAME"
fi

echo "========================================="
echo "PDFMirror Installer"
echo "========================================="
echo ""

# Remove quarantine attributes if present (helps with Gatekeeper)
echo "Removing quarantine attributes..."
xattr -dr com.apple.quarantine "$0" 2>/dev/null || true
echo ""

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed."
    echo ""
    echo "Please install Homebrew first:"
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo ""
    exit 1
fi

echo "✓ Homebrew found"
echo ""

# Install pdfmirror
if ! command -v pdfmirror &> /dev/null; then
    echo "Installing pdfmirror..."
    brew tap hkievet/pdfmirror
    brew install pdfmirror
    echo "✓ pdfmirror installed"
else
    echo "✓ pdfmirror is already installed"
    # Check if update is available
    if brew outdated pdfmirror &> /dev/null; then
        echo "  Updating to latest version..."
        brew upgrade pdfmirror
    fi
fi

echo ""

# Install Quick Action
if [ ! -d "$QUICK_ACTION_PATH" ]; then
    echo "❌ Quick Action not found at: $QUICK_ACTION_PATH"
    exit 1
fi

echo "Installing Finder Quick Action..."
if [ -d "$SERVICES_DIR/$QUICK_ACTION_NAME" ]; then
    echo "  Removing existing Quick Action..."
    rm -rf "$SERVICES_DIR/$QUICK_ACTION_NAME"
fi

cp -R "$QUICK_ACTION_PATH" "$SERVICES_DIR/"
echo "✓ Quick Action installed to $SERVICES_DIR/$QUICK_ACTION_NAME"
echo ""

# Refresh services
killall Finder 2>/dev/null || true
sleep 1

echo "========================================="
echo "Installation Complete!"
echo "========================================="
echo ""
echo "You can now:"
echo "  1. Right-click any PDF file in Finder"
echo "  2. Select 'Quick Actions' → 'Mirror PDF'"
echo "  3. The mirrored PDF will be created in the same folder"
echo ""
echo "The mirrored file will be named: [original]_flipped.pdf"
echo ""

