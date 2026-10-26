class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.50"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.50/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "9751cee2886db84eacd5980035cc79db26a28743a091040985eb875dd20215a5"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.50/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "2213fe90695c485b5866451e8373a4adab2b872f79636c0bbc3478b0b0abcc3f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.50/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "16c99dc261dc6991373564bda1aba12833913c182ab537550bee174b8b29976e"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.50/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "173d3b4425b61db4f0ccba9abd7785bee6a1e6c5c3244570f536b4835d49fa7e"
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
