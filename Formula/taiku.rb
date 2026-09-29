class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.36"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.36/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "ef60a8835c509472693dd4bac83b35574e1f066ad17d6c74850dac335bf27962"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.36/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "befe8ea8f971a33f8fe59a4f9966f7a0585e0709b124c0e9699078df6231e32e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.36/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d75b40e673824a89afc9888d4f6c35c91541194c7823776e07344305fe384eae"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.36/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "625b6d2bde3a1b687ce0b552c36dbae7ed9d5318dfa3558cc5cbe0236f30dd07"
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
