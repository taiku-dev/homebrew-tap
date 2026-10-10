class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.44"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.44/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "4cdf1859c049788095ce5e92617cca0105beb17372c6e135153617a577754eb1"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.44/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "82889517dda01004ca946775f31de852566e2c5e2281b0ae338caca9c2cf10c4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.44/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5971a267ca7c360cb89eadc17cb4a367da81a6d0f2d43b562801189a81bc5b48"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.44/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "546c672fdc6d41830b4bc8817805a0a7ae5721a139b78d555693b758808942dc"
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
