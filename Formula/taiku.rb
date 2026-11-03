class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.52"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://releases.taiku.live/v1.0.52/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "795691128c4084072f9f59e5bce6f546bf8f807a7d7ed2e66d53ba9174ad00bf"
    else
      url "https://releases.taiku.live/v1.0.52/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "e838776e4be1f583d77308cbdcf0edcee96974fd33bc200471f2483e686333bd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://releases.taiku.live/v1.0.52/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2f22df26adff1b5e656f6a59cf1768777ae50cd3644abe9aed8b73f40625c392"
    else
      url "https://releases.taiku.live/v1.0.52/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "585c22c660e6c9502e86113695c95343f2311da9fc29a6c83c35fa9015469adc"
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
