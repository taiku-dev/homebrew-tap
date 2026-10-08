class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.42"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.42/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "5fc26c39aa004683dc0c3a81db3eb9a8b4e9609621dfbba8d3a633234b8b6a7b"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.42/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "8821e554662f234c055d60870694c2bfb481f77acaa272fecca5b39062e347bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.42/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "37ae7b7ba1a8465055d4bafe9f5393c9c5d9c1e1aeaf709d5f1bad5261aee3c5"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.42/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3f7a3c8b815cd802dfd74c15185b6c0f48597943e66c5e15870f0bcaef58feda"
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
