class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.7/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "f2c19e39b3323ff9e0a06492471801dc37bd6568aea9549d160d0945dda13c1f"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.7/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "704c32677e917eca75dd8558570c274eed796136e1201e10ea8ec14817b236b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.7/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a5bfe9aacd7e505705a89ab4e5170317fcfbbf99eaa3c8ba327dc0b3aa683ebf"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.7/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b6f7aa9dc7986fb6768166bfeba8550f99cfaa1c41a148e9ec56d3d57fc999ef"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
