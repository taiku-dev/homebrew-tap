class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.41"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.41/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "f46fd06ae918e70fa5841b7e7b8b971165fd2a8850d23380bab3079aee79ecc6"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.41/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "1cba4f9ad98ea7d42b52edbef363b159db3c1e19fffde7ab43a7e5c270950e8a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.41/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b0e09532d6aafa4b571948c3dc21b732902ee5335cd6709226001d8379226b76"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.41/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "efa56621f7fd423d0daf3081642dd38ee44bd8c84a8a605f5e186312f1b78710"
    end
  end

  def install
    # The floor has a minor version Homebrew cannot state: below it
    # the binary cannot load ScreenCaptureKit and dies in dyld, so
    # refuse here with the reason instead.
    if OS.mac? && MacOS.full_version < "12.3"
      odie "taiku needs macOS 12.3 or newer; this Mac runs #{MacOS.full_version}. Update macOS, then install again."
    end
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
