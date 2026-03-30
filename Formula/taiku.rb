class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "c9ba872de18f19c5dd82a5deab206807d0bad75942e813cfb0b65d1b14886dad"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "be4b11249c6c5bce09eb3d9f56b947a486b1b438faa4abc53b6a520b5ba7bc4f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "06ea064be7917c4cda7d0906b713c940ebf834f454b77fa4a724cf83fcef940d"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4a2f27edb40a7fe3a1d287ca42572e1df3d6d6506e93ae375aea0f2c88164376"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
