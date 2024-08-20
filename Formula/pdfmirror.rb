class Pdfmirror < Formula
    include Language::Python::Virtualenv
  
    desc "A CLI tool for mirroring PDF"
    homepage "https://github.com/hkievet/pdfmirror"
    url "https://github.com/hkievet/pdfmirror/blob/main/dist/pdfmirror-0.1.0.tar.gz"  # Link to the tarball of your package
    sha256 "cb2a438e743479f0746dbe110cde8b9a18ddde1b44e905cf97135335e0f57395  dist/pdfmirror-0.1.0.tar.gz"  # Replace with the actual SHA-256 hash
    license "MIT"
  
    depends_on "python@3.9"  # or whichever Python version you need
    depends_on "tesseract"   # Adding tesseract as a dependency
  
    def install
      virtualenv_install_with_resources
    end
  
    test do
      system "#{bin}/my_tool", "--help"
    end
  end
  