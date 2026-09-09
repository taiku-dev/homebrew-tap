class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.31"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.31/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "fd3022554cc8dca150d1d3a41c990cdd1e31a47b8b8f15eb7707e26eda86c8db"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.31/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "bc6b82dab608565ad8e16f93153d382f48992106d5fb9e1ea9973dfeee0c6e68"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.31/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f44e2794c79cb686e210b5e1c2c37d8d5b75e4ec835e32f7dc3cd95de4fbf8b5"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.31/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "40be08ea326bfb703792be649c4b0423ea9409515b901e9486eab3c44c0f4313"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
