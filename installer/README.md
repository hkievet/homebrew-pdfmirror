# PDFMirror Installer

This directory contains the installer components for creating a DMG installer for PDFMirror.

## Components

- **PDFMirror.workflow**: Automator Quick Action that adds "Mirror PDF" to Finder's right-click menu
- **install.sh**: Installation script that installs pdfmirror via Homebrew and sets up the Quick Action
- **create_app.sh**: Script to build the macOS app bundle
- **create_dmg.sh**: Script to create the DMG installer

## Building the DMG

### Prerequisites

```bash
brew install create-dmg
```

### Build Steps

1. Build the app bundle:
   ```bash
   cd installer
   ./create_app.sh
   ```

2. Create the DMG:
   ```bash
   ./create_dmg.sh [version]
   ```
   
   Example:
   ```bash
   ./create_dmg.sh 1.0.0
   ```

   This will create `PDFMirror-Installer-1.0.0.dmg` in the project root.

## Installation Process

When users double-click the DMG and run the installer:

1. The installer checks for Homebrew
2. Installs pdfmirror via `brew tap hkievet/pdfmirror && brew install pdfmirror`
3. Copies the Quick Action to `~/Library/Services/`
4. Refreshes Finder to make the Quick Action available

## Using PDFMirror

After installation:

1. Right-click any PDF file in Finder
2. Select **Quick Actions** → **Mirror PDF**
3. The mirrored PDF will be created in the same folder with `_flipped.pdf` suffix
4. A notification will appear when complete

## Requirements

- macOS 10.15 or later
- Homebrew (will prompt user to install if missing)


