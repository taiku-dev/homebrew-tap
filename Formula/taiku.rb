class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.29"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.29/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "c77bd6fae8e9c83641cff87333afb9cedee5b5c942a495b4e68097ddfc069de3"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.29/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "956e0c0610ce6a5b1860b2f5754c6babc1b1d9b9571af7fc46a9abc866a24e47"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.29/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "434f8ea9bbbf8c87f22c2f6ca596c0d28ae36a10c2e98d453ffddaa2f2f0f67b"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.29/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c17844da57a68b9762af98c9577ccb74752aeb5eac37877007278a2dbe635bc0"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
