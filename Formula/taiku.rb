class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "0.4.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "9fb055bca141721994b8d166e04ae4602794fb1e0ee2bc4601b55cc8518f44a7"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "1fa7cfac963b2b4d6143fcc067057eacc7f3a050d9e3708eb6f3f1bd8058d266"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b95654b5a6802090cdce76e61e2b62c95746238a4a6071741b93624c80091118"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "eed85f06b5dc20dd8b7454550e617d3b22a4616cbd90a0595aa2c8f2a9287f41"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
