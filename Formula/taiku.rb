class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.48"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.48/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "c49c340dd7f60a51e51168f41f218362dee6bdc2bad2a844b54fd18b872c604b"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.48/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "216a5d8b9fa997a468ea5663599f478d2366b494d0e448c4a5b9f204ac4b3cd5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.48/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "83189c569f3572c728f7ae110499c7e69bfeff66f891c6287ae6028dfdb01231"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.48/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2307a662c6853e34c4b67f9ed84fbb749d20fff3834daa0bd08aef50b650ef7e"
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
