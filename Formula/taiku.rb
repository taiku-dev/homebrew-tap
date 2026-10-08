class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.43"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.43/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "c136b3a75d8f3b7439e503d388d7502523a1faeab3ef43022d54f9c1c0bb7b7f"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.43/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "fcf7ae29e0dc2813fe9b8aacb8b02378f5b2be164672e5e6e6c905d2c8d53acf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.43/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "32eb2299b8fb38f99e6d22a0403813e4051e86afb167b41a49e4ae830be3192f"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.43/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5e231f6efacb24d8b7da2f8b22a1c89f914fff48f6d98f43a369dc2b67998d2c"
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
