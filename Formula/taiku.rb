class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.10/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "98f8dcd9167b00bbf71b47a52f3a33e8e75f412a5139265608c15408c8f3d0a4"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.10/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "5f9e9484bdf4dcfc76a0e91253261e7fbe5209ce1a18f913f8d4d99f26a199c4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.10/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "037f9e85b2e398146182ce55b36491dfb8171d827e885a823e41a1dd4c5814d0"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.10/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "79d9cd2fc5c562d2c1eb9c19ef638457d550c3b838f413e8598054e785b5bcc5"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
