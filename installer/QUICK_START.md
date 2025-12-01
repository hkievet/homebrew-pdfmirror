# Quick Start Guide

## For Users

### Quick Install

Run this command in Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/hkievet/homebrew-pdfmirror/main/install.sh | bash
```

Or download `install.sh` and run:
```bash
chmod +x install.sh
./install.sh
```

### Manual Installation

1. Install pdfmirror via Homebrew:
   ```bash
   brew tap hkievet/pdfmirror
   brew install pdfmirror
   ```

2. Create the Automator workflow manually (see instructions below)

3. Once complete, right-click any PDF in Finder and select "Quick Actions" → "Mirror PDF"

## For Developers

### Testing the Installer

1. Run the install script: `./install.sh`
2. Test the Quick Action on a PDF file

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
