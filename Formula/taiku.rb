class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.37"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.37/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "a4e884ee09e6a25f97720b44d2683e512e4a849a7ddcbbe6ce60ecaae5e270eb"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.37/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "d4ed2dbf6ba331d987eaa885a29dbff80973c8c1917c54e1fe93f5c7486b12e3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.37/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "21b91167e459a4120d6e001303ad408a905fc77448a7aa93b5657d93fbf85bc8"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.37/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fe08e07785e437d5eea95c0c62b8f0f21f0856128a557185914d47b9b423aca2"
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
