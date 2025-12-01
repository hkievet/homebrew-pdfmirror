#!/bin/bash

# PDFMirror Simple Installer
# This script installs pdfmirror and sets up the Finder Quick Action

set -e

echo "========================================="
echo "PDFMirror Installer"
echo "========================================="
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
fi

echo ""

# Create the Automator workflow
SERVICES_DIR="$HOME/Library/Services"
WORKFLOW_NAME="PDFMirror.workflow"
WORKFLOW_PATH="$SERVICES_DIR/$WORKFLOW_NAME"

echo "Creating Finder Quick Action..."

# Remove existing workflow if present
if [ -d "$WORKFLOW_PATH" ]; then
    rm -rf "$WORKFLOW_PATH"
fi

# Create workflow directory structure
mkdir -p "$WORKFLOW_PATH/Contents"

# Create Info.plist
cat > "$WORKFLOW_PATH/Contents/Info.plist" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleIdentifier</key>
	<string>com.hkievet.pdfmirror</string>
	<key>CFBundleName</key>
	<string>PDFMirror</string>
	<key>CFBundleVersion</key>
	<string>1.0</string>
	<key>NSServices</key>
	<array>
		<dict>
			<key>NSMenuItem</key>
			<dict>
				<key>default</key>
				<string>Mirror PDF</string>
			</dict>
			<key>NSMessage</key>
			<string>runWorkflowAsService</string>
			<key>NSRequiredContext</key>
			<dict>
				<key>NSApplicationIdentifier</key>
				<string>com.apple.finder</string>
			</dict>
			<key>NSSendFileTypes</key>
			<array>
				<string>com.adobe.pdf</string>
			</array>
		</dict>
	</array>
</dict>
</plist>
EOF

# Create document.wflow with your working script
cat > "$WORKFLOW_PATH/Contents/document.wflow" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>AMApplicationBuild</key>
	<string>476</string>
	<key>AMApplicationVersion</key>
	<string>2.11</string>
	<key>AMDocumentVersion</key>
	<string>2</string>
	<key>actions</key>
	<array>
		<dict>
			<key>ActionBundlePath</key>
			<string>/System/Library/Automator/Run Shell Script.action</string>
			<key>ActionName</key>
			<string>Run Shell Script</string>
			<key>ActionParameters</key>
			<dict>
				<key>COMMAND_STRING</key>
				<string># Find pdfmirror command (works for both Intel and Apple Silicon)
if [ -f "/opt/homebrew/bin/pdfmirror" ]; then
    PDFMIRROR_CMD="/opt/homebrew/bin/pdfmirror"
elif [ -f "/usr/local/bin/pdfmirror" ]; then
    PDFMIRROR_CMD="/usr/local/bin/pdfmirror"
else
    PDFMIRROR_CMD="pdfmirror"
fi

for f in "$@"
do
    # Get the full path and create output filename
    output_file="${f%.pdf}_flipped.pdf"
    
    # Run pdfmirror
    "$PDFMIRROR_CMD" "$f" -o "$output_file"
    
    # Show notification
    if [ $? -eq 0 ]; then
        osascript -e "display notification \"Created: $(basename \"$output_file\")\" with title \"PDFMirror\" sound name \"Glass\""
    else
        osascript -e "display notification \"Error processing: $(basename \"$f\")\" with title \"PDFMirror\" sound name \"Basso\""
    fi
done</string>
				<key>CheckedForUserDefaultShell</key>
				<true/>
				<key>Shell</key>
				<string>/bin/zsh</string>
				<key>source</key>
				<string>1</string>
			</dict>
			<key>BundleIdentifier</key>
			<string>com.apple.RunShellScript</string>
			<key>CFBundleVersion</key>
			<string>2</string>
			<key>CanShowSelectedItemsWhenRun</key>
			<false/>
			<key>CanShowWhenRun</key>
			<true/>
			<key>Category</key>
			<array>
				<string>AMCategoryUtilities</string>
			</array>
			<key>Class Name</key>
			<string>RunShellScriptAction</string>
			<key>InputUUID</key>
			<string>0</string>
			<key>Keywords</key>
			<array>
				<string>Shell</string>
				<string>Script</string>
				<string>Run</string>
				<string>Unix</string>
			</array>
			<key>OutputUUID</key>
			<string>1</string>
			<key>UUID</key>
			<string>2</string>
			<key>UnlocalizedApplications</key>
			<array>
				<string>Automator</string>
			</array>
			<key>arguments</key>
			<dict>
				<key>0</key>
				<dict>
					<key>default value</key>
					<integer>0</integer>
					<key>name</key>
					<string>inputMethod</string>
					<key>required</key>
					<string>0</string>
					<key>type</key>
					<string>0</string>
					<key>uuid</key>
					<string>0</string>
				</dict>
				<key>1</key>
				<dict>
					<key>default value</key>
					<false/>
					<key>name</key>
					<string>checked</string>
					<key>required</key>
					<string>0</string>
					<key>type</key>
					<string>0</string>
					<key>uuid</key>
					<string>1</string>
				</dict>
			</dict>
			<key>conversionLabel</key>
			<integer>0</integer>
			<key>isViewVisible</key>
			<integer>1</integer>
			<key>location</key>
			<string>578.000000:325.000000</string>
			<key>nestedActions</key>
			<array/>
			<key>nestedConnections</key>
			<array/>
			<key>receives</key>
			<dict>
				<key>0</key>
				<dict>
					<key>UUID</key>
					<string>0</string>
				</dict>
			</dict>
			<key>sends</key>
			<dict>
				<key>0</key>
				<dict>
					<key>UUID</key>
					<string>1</string>
				</dict>
			</dict>
		</dict>
	</array>
	<key>connectors</key>
	<array/>
	<key>workflowType</key>
	<string>1</string>
</dict>
</plist>
EOF

# Set proper permissions
chmod -R 755 "$WORKFLOW_PATH"

# Remove any quarantine attributes
xattr -dr com.apple.quarantine "$WORKFLOW_PATH" 2>/dev/null || true

echo "✓ Quick Action installed to $WORKFLOW_PATH"
echo ""

# Refresh Finder
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

