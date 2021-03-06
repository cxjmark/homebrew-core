class Quex < Formula
  desc "Generate lexical analyzers"
  homepage "http://quex.org/"
  url "https://downloads.sourceforge.net/project/quex/DOWNLOAD/quex-0.68.2.tar.gz"
  sha256 "b6a9325f92110c52126fec18432d0d6c9bd8a7593bde950db303881aac16a506"
  head "https://svn.code.sf.net/p/quex/code/trunk"

  bottle do
    cellar :any_skip_relocation
    sha256 "e5d0e22c8d988408e52ddabcd0b1ddd7e858c6256b1449b919a83f8da5934354" => :high_sierra
    sha256 "e5d0e22c8d988408e52ddabcd0b1ddd7e858c6256b1449b919a83f8da5934354" => :sierra
    sha256 "e5d0e22c8d988408e52ddabcd0b1ddd7e858c6256b1449b919a83f8da5934354" => :el_capitan
    sha256 "234955b11de80a9a59b1fcbd78eab282427bf1a4ef2a341bf92eff4a43f09109" => :x86_64_linux
  end

  depends_on "python" unless OS.mac?

  def install
    libexec.install "quex", "quex-exe.py"
    doc.install "README", "demo"

    # Use a shim script to set QUEX_PATH on the user's behalf
    (bin/"quex").write <<~EOS
      #!/bin/bash
      QUEX_PATH="#{libexec}" "#{libexec}/quex-exe.py" "$@"
    EOS

    if build.head?
      man1.install "doc/manpage/quex.1"
    else
      man1.install "manpage/quex.1"
    end
  end

  test do
    system bin/"quex", "-i", doc/"demo/C/01-Trivial/simple.qx", "-o", "tiny_lexer"
    assert_predicate testpath/"tiny_lexer", :exist?
  end
end
