#!/bin/bash

# Create the installer app bundle

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_NAME="PDFMirror Installer.app"
APP_DIR="$SCRIPT_DIR/$APP_NAME"

# Remove existing app if it exists
rm -rf "$APP_DIR"

# Create app bundle structure
mkdir -p "$APP_DIR/Contents/MacOS"
mkdir -p "$APP_DIR/Contents/Resources"

# Create the main executable script
cat > "$APP_DIR/Contents/MacOS/PDFMirror Installer" <<'APPSCRIPT'
#!/bin/bash

# Get the app bundle directory
APP_DIR="$(cd "$(dirname "$(dirname "$(dirname "$(readlink -f "$0" 2>/dev/null || echo "$0")")")")" && pwd)"
RESOURCES_DIR="$APP_DIR/Contents/Resources"
INSTALL_SCRIPT="$RESOURCES_DIR/install.sh"

# Run installer in a terminal window so user can see progress
osascript <<EOF
tell application "Terminal"
    activate
    do script "cd '$RESOURCES_DIR' && bash '$INSTALL_SCRIPT' && echo '' && echo 'Press any key to close...' && read -n 1"
end tell
EOF

APPSCRIPT

chmod +x "$APP_DIR/Contents/MacOS/PDFMirror Installer"

# Copy installer script to Resources
cp "$SCRIPT_DIR/install.sh" "$APP_DIR/Contents/Resources/"

# Copy Quick Action to Resources
cp -R "$SCRIPT_DIR/PDFMirror.workflow" "$APP_DIR/Contents/Resources/"

# Create Info.plist
cat > "$APP_DIR/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>PDFMirror Installer</string>
    <key>CFBundleIdentifier</key>
    <string>com.hkievet.pdfmirror.installer</string>
    <key>CFBundleName</key>
    <string>PDFMirror Installer</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.15</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

echo "✓ App bundle created: $APP_NAME"

