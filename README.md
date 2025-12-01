## Installation

### Option 1: Homebrew (Recommended for Developers)

```bash
brew tap hkievet/pdfmirror
brew install pdfmirror
```

### Option 2: DMG Installer (Recommended for End Users)

Download the DMG installer from the [Releases](https://github.com/hkievet/homebrew-pdfmirror/releases) page:

1. Download `PDFMirror-Installer-X.X.X.dmg`
2. Double-click the DMG to open it
3. Double-click "PDFMirror Installer.app"
4. Follow the installation prompts

After installation, you can right-click any PDF file in Finder and select **Quick Actions** → **Mirror PDF** to mirror it.

## Usage

### Command Line

```bash
pdfmirror input.pdf -o output.pdf
```

### Finder Integration

After installing via DMG:
1. Right-click any PDF file in Finder
2. Select **Quick Actions** → **Mirror PDF**
3. The mirrored PDF will be created in the same folder with `_flipped.pdf` suffix

## Building

### Build Python Package

```bash
python3 setup.py sdist bdist_wheel
shasum -a 256 dist/pdfmirror-0.1.0.tar.gz
```

### Build DMG Installer

See [installer/README.md](installer/README.md) for details.
