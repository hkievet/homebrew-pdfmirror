class Pdfmirror < Formula
    include Language::Python::Virtualenv
  
    desc "A CLI tool for mirroring PDF"
    homepage "https://github.com/hkievet/homebrew-pdfmirror"
    url "https://github.com/hkievet/homebrew-pdfmirror/releases/download/v0.1.8/pdfmirror-0.1.0.tar.gz"  # Link to the tarball of your package
    sha256 "cdca62fe6902fc57c5928d22e778993ac852351804d8d684a4515da710bc80ab"  # Replace with the actual SHA-256 hash
    license "MIT"
  
    depends_on "python@3.9"  # or whichever Python version you need
    depends_on "tesseract"   # Adding tesseract as a dependency
  
    def install
      virtualenv_install_with_resources
    end
  
    test do
      system "#{bin}/pdfmirror", "--help"
    end
  end
  