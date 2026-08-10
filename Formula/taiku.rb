class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.30"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.30/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "1c4ac8c7aec8ba339aa9557480ab234d0400c0ea4f94e77b2fe781346849bf3b"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.30/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "8624cf4d236698acfbee31e879472328022c05047ae0dcfbfcdec6c1d435ee98"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.30/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "99e881a1da153fb078ac1c5507f3d611f86642ac25f38e10cb03921505c3ef8f"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.30/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "016a3c100a4515c2f02d8cddc2949979fcb618113aa18647c91c008b592393b3"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
