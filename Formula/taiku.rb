class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "bb335c86bcd31a597839d5648ada51332e4617fa20065d874965c8206d62bf0b"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "9ba24cbec2a3cbba13d8fb9ef07bd977f9ede80eea756aa4471bfcdf58b8add6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "49886d1334ca97871bdbe79135bfc3a51ff8cace8233ecee6b7e796fcf6ffaa2"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "56356c8cad9bb8801bbc4dcdcaba47c5bb03cf743e350d65af50ac52b082793a"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
