class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.35"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.35/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "6d44f53000a6044b9f43e5e15a3c8f0ecb9e730cdd9046cbbb9d2bd0d6efa79b"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.35/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "1507e9f0d2d0759acb0bdf41c71b09bb630f02de746d0f88c6a124c113bf7646"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.35/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d2133ecd3abc2ed044509e1e486f1ef44d36f42997e5f8524289fed822f343c5"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.35/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "19d12df447c97540347d070570620bd29501bf538e4e1862d47b47e8ad9a9624"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
