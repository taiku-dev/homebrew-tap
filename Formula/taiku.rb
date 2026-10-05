class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.40"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.40/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "923ecdaa188a15bbbfe971669be2b47f647ec61dcc4796d784919d3936a6c219"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.40/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "a88e204307e5db7f2da7ace4bd5558b8e2a23e738e1c63455546ba27e3dcabd4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.40/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ef62a711b21ce8c05c08cf5595fa04a717bd2aec96e0565ed4efeab9535831c8"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.40/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "106e236dfd5d2ab5c5bd1cf1572753a6fb154e2bcdf3fc25e575efa3c3689423"
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
