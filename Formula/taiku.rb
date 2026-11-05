class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.53"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://releases.taiku.live/v1.0.53/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "4c6f8b5acc5d1d4ffb766d43121006c8c858350dd895cab40e8846578a6a278e"
    else
      url "https://releases.taiku.live/v1.0.53/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "2ae20d66fe10407342978da9d962b52ef7dd69e5ae340184d90ce39f60354eb5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://releases.taiku.live/v1.0.53/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1fa29963ab119a08417886266cc85e1e7b6ef7e3c46e8ae31e072690f149b4ca"
    else
      url "https://releases.taiku.live/v1.0.53/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c07328395da93c92e432a5eb995ef8bfeee386bd04773bf6eee3931efd862f1e"
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
