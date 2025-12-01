# Quick Start Guide

## For Users

1. Download `PDFMirror-Installer-X.X.X.dmg` from the releases page
2. Double-click the DMG to open it
3. Double-click "PDFMirror Installer.app"
4. Follow the installation prompts in the terminal window
5. Once complete, right-click any PDF in Finder and select "Quick Actions" → "Mirror PDF"

## For Developers

### Building Locally

```bash
# Install create-dmg if needed
brew install create-dmg

# Build the app bundle
cd installer
./create_app.sh

# Create the DMG (optional - specify version)
./create_dmg.sh 1.0.0
```

### Testing the Installer

1. Build the app: `./create_app.sh`
2. Double-click `PDFMirror Installer.app` to test
3. Or run directly: `open "PDFMirror Installer.app"`

### Testing the Quick Action

After installation:
1. Find a PDF file in Finder
2. Right-click it
3. Look for "Quick Actions" → "Mirror PDF"
4. Click it and wait for the notification
5. Check for `[filename]_flipped.pdf` in the same directory

## Troubleshooting

### Quick Action doesn't appear
- Make sure the Quick Action was installed to `~/Library/Services/PDFMirror.workflow`
- Restart Finder: `killall Finder`
- Check System Preferences → Extensions → Finder Extensions

### pdfmirror command not found
- Make sure Homebrew is installed
- Run: `brew tap hkievet/pdfmirror && brew install pdfmirror`
- Check: `which pdfmirror` should show the path

### Permission errors
- The installer needs to write to `~/Library/Services/`
- Make sure you have write permissions to your home directory


