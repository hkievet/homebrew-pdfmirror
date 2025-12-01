# PDFMirror Installer

This directory contains legacy installer components. The recommended installation method is now the simple `install.sh` script in the project root.

## Simple Installation (Recommended)

Use the install script in the project root:

```bash
curl -fsSL https://raw.githubusercontent.com/hkievet/homebrew-pdfmirror/main/install.sh | bash
```

Or download and run:
```bash
chmod +x install.sh
./install.sh
```

## Legacy Components

This directory still contains:
- **PDFMirror.workflow**: The Automator Quick Action workflow (now created programmatically by install.sh)
- **install.sh**: Legacy installer script (superseded by root install.sh)

## Manual Workflow Creation

If you need to manually create the workflow, you can use the `PDFMirror.workflow` in this directory as a reference, but the automated installer is recommended.
