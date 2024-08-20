class Pdfmirror < Formula
    include Language::Python::Virtualenv
  
    desc "A CLI tool for mirroring PDF"
    homepage "https://github.com/hkievet/pdfmirror"
    url "https://github.com/hkievet/homebrew-pdfmirror/raw/main/dist/pdfmirror-0.1.0.tar.gz"  # Link to the tarball of your package
    sha256 "24347db8f99222da1df05bb95ab250b4069d41178b9a85c2174da05a3d7a1337"  # Replace with the actual SHA-256 hash
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
  