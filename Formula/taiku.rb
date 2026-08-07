class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.28"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.28/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "ef27e4f56f6fe8a14b185f2cecdd35fe022aac5dc23bc5b6e61464156d9019b1"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.28/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "e92d4c76d69d0327ec7c2d33b4717c6316026b7e53f469f21e96aee72a0d0151"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.28/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a13fd6a182de49e92f55e464a3980155360f5f6be1dbeb6eb3f1eb263ca83271"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.28/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0ff3b66e37218e02e56fb632eeb6e5bf325351178ebc9a146eeb99bc13675bbb"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
