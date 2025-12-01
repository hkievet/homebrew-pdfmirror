# macOS Gatekeeper / Security Issues

## The Problem

macOS Gatekeeper may block the unsigned installer app with a message like:
- "PDFMirror Installer.app cannot be opened because it is from an unidentified developer"
- "The app is damaged and can't be opened"

This happens because the app is not code-signed with an Apple Developer certificate.

## Solutions

### Option 1: Remove Quarantine Attribute (Recommended for Testing)

After downloading the DMG, run this command in Terminal:

```bash
# Remove quarantine from the DMG
xattr -cr ~/Downloads/PDFMirror-Installer-*.dmg

# Or if you've already extracted the app:
xattr -cr ~/Downloads/PDFMirror\ Installer.app
```

Then try opening it again.

### Option 2: Right-Click to Open

1. Right-click (or Control-click) the "PDFMirror Installer.app"
2. Select "Open" from the context menu
3. Click "Open" in the security dialog
4. macOS will remember this choice for future opens

### Option 3: System Preferences Override

1. Go to **System Preferences** → **Security & Privacy**
2. Click the lock to make changes
3. Under "Allow apps downloaded from:", you may see a message about the blocked app
4. Click "Open Anyway"

### Option 4: Disable Gatekeeper (Not Recommended)

Only for advanced users who understand the security implications:

```bash
sudo spctl --master-disable
```

**Warning:** This disables Gatekeeper for all apps, reducing your system's security.

## For Distribution

To properly distribute signed apps, you would need:

1. **Apple Developer Account** ($99/year)
2. **Code Signing Certificate**
3. **Notarization** (required for macOS 10.15+)

The GitHub Actions workflow can be updated to include code signing if you have certificates set up.

## Current Workaround

The installer script automatically removes quarantine attributes when run, but users may need to use one of the methods above to initially open the app.

