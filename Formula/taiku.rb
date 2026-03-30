class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "b133f316a568b9d704d14b4e199bd3a9f7a7645521bb675179d9d6e7e63f2e0a"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "f7d1d2b99eaa0ddf8b572b7d26a0944bf3fd9b8d60c69bcbf9c1f57f20b9465e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9edcd520ff5bf8c206c1fc9ce9a8d1c3fc8774e06ee7fafb7f27e2c4c4871810"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ec3d365972a75fa9d7eb7025d9aeb714290d72da36bb29ca754316295a01a362"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
