## Installation

### Quick Install (Recommended)

Run this command in Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/hkievet/homebrew-pdfmirror/main/install.sh | bash
```

Or download `install.sh` and run:
```bash
chmod +x install.sh
./install.sh
```

This will:
- Install pdfmirror via Homebrew
- Set up the Finder Quick Action automatically

### Manual Installation

If you prefer to install manually:

```bash
brew tap hkievet/pdfmirror
brew install pdfmirror
```

Then create the Automator workflow manually (see instructions below).

## Usage

### Command Line

```bash
pdfmirror input.pdf -o output.pdf
```

### Finder Integration

After running the installer script:
1. Right-click any PDF file in Finder
2. Select **Quick Actions** → **Mirror PDF**
3. The mirrored PDF will be created in the same folder with `_flipped.pdf` suffix

## Building

### Build Python Package

```bash
python3 setup.py sdist bdist_wheel
shasum -a 256 dist/pdfmirror-0.1.0.tar.gz
```

