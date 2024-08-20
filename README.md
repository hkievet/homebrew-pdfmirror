```
brew tap hkievet/pdfmirror
brew install pdfmirror
```

Build:

```
python3 setup.py sdist bdist_wheel

shasum -a 256 dist/pdfmirror-0.1.0.tar.gz
```
