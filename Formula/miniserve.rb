class Miniserve < Formula
  desc "High performance static file server"
  homepage "https://github.com/svenstaro/miniserve"
  url "https://github.com/svenstaro/miniserve/archive/v0.2.0.tar.gz"
  sha256 "2a0d4c7563b3b1b75ba0cccc69236976dc916378a41e7f994e28f8a766bded4c"

  bottle do
    sha256 "95064e1def8c354c4401f0082ffbd6956581a8b1b0bb65a00762b560c65f21ef" => :high_sierra
    sha256 "e5f0e8da39d4b8939a2de3662d944c3be2f86ecc51b8fb2b2ccc814684608e47" => :sierra
    sha256 "674c1b2e298092c866168ce996633b5130f084991810d9b74d2dcc6ab9adf38f" => :el_capitan
    sha256 "f31cafa1d1c3405330d817cc43548d7e6fe7f539e9ee14f0662496ca51873c12" => :x86_64_linux
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix
  end

  test do
    require "socket"

    server = TCPServer.new(0)
    port = server.addr[1]
    server.close

    pid = fork do
      exec "#{bin}/miniserve", "#{bin}/miniserve", "--if", "127.0.0.1", "--port", port.to_s
    end

    sleep 2

    begin
      read = (bin/"miniserve").read
      assert_equal read, shell_output("curl localhost:#{port}")
    ensure
      Process.kill("SIGINT", pid)
      Process.wait(pid)
    end
  end
end
