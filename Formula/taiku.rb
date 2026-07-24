class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.9/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "26be5117cdb391e852e4c2f3b8e0bae4b57603ffc94673fb33300f0d3b712727"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.9/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "a3a72f1ffae9eb0cb47c0c401d16a012e7b544b195bff3b8aac6bda7c133e2fd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.9/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4af846ba8602365aed6fd1d436691f52ebf53dd75cf2c09f403be56f1b12f869"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.9/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6827466d34b187dcb996eff4a9f784ae4af360f9d988e5ee7a763b243b353b0d"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
