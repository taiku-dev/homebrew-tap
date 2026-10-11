class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.45"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.45/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "93f460601ab7a357c13c9930c3f1ad7b14e7ca14c951a11fd38a4404866f8a7a"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.45/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "f281b3a1fc9d822e5295bdf95defff6e15fdf572912b91d3cbea4a17e833b80e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.45/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9e1eefee00d64489b6efef915f15515b960cc8c5c0457265768e0638fe7b0281"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.45/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "47eb335e8054d3e7004b5b6059fded1848dcdf3178808b68de96540389ed767d"
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
