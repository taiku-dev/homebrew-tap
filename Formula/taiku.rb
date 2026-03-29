class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "5e4c76bf5beb20ff278d1516a85563745dec7dc77beaef593ed837cd693c9d54"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "41d7a2f3424ec02b2df4af5e8f00cff1e1be4330ee602bb667d07be1ece4b6c1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "60719c7c05b851a0048175a0f5dcb8eda24c1864bc16e2e06e0041d253e13ca3"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b8c12330e6bac7f1f724a89eefb9c859f4e195d6a867a8bb9cdb1477f0b5960d"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
