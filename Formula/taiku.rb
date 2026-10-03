class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.39"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.39/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "cb4a642ddf7c7d0efddbf6b3db26a528e40d8c1b2b4f427a161cd271868304fb"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.39/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "9bd8236a5b06551caf6e12966240ac852d5301ca0d7388f29df6029c9f20519c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.39/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8567b2843686785120840708d4da89d30017f7ecb473f14e2392c6135fb5d989"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.39/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "52aef58d18bb0fac99bed7ee97d68e9f95f573c82c460a8c16e8cd226dd83175"
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
