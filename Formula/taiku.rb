class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "0.4.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "3c6a98b5da4e78f6e45923b90189643bb4b6da24c1f9dff32d74aced5784600e"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "4bdcfe89bd15a1aa9284c839f1ad6024adebe6344ce4e4e85feb3b7912c6a812"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3d52e64a85f4deef5c2cd46ccaca7eefd09f6dfc2510b06d5a0bb98aa0bd3d72"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0c94c0368df3a4f422679a16ddb6d799d4da5716376efa44757df1e962de40cd"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
