class Openfortivpn < Formula
  desc "Open Fortinet client for PPP+SSL VPN tunnel services"
  homepage "https://github.com/adrienverge/openfortivpn"
  url "https://github.com/adrienverge/openfortivpn/archive/v1.7.1.tar.gz"
  sha256 "71222da680cdafbd48f648e4e1bc14822fa06eb84ab5e1fb58f28b6b4251baba"

  bottle do
    sha256 "e50554d89dabf795108f02695a2ebe05554ee3164c692ef1ecdd6fa8fdd0e37d" => :high_sierra
    sha256 "41d9bdc5b78eff99fe35ef78d635fed91e76fe1e6a5d5d894339a025f634f44a" => :sierra
    sha256 "53e0106ebd966a5eb3dc3547add6c182f3d5c2322d38a6ef91d6617fc9e3a07a" => :el_capitan
    sha256 "18a7d344258046e5653d2c584035c7c3940c772fd20472f1b8f31b32da065b69" => :x86_64_linux
  end

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
  test do
    system bin/"openfortivpn", "--version"
  end
end
