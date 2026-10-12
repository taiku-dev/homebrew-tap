class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.46"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.46/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "082a68749653caa5d664b3fad34cfdce0d375ddfc08fd7f64942c292c4447eca"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.46/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "a540843e227cf97e0edc2f8dad82ab4cae4ad73da427d9c7f1e05907861dba4c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.46/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d2831a76891672cda5c9b15548a79e8565ae5cf416607fd8008d845ca3e7704c"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.46/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2bc7d8f6eb9c06b3800487979fb49ccaebf35827a04d239923b118aa53ad5d50"
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
