class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.54"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://releases.taiku.live/v1.0.54/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "f55e3bbf68b3d8c2330babfaccd6735d889a4d85303bff6ccb7c50bdcc1531b3"
    else
      url "https://releases.taiku.live/v1.0.54/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "221b12a2354e0edd219889ee5129d6803b6e0e26a2e24c10f9d482bba2f2394a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://releases.taiku.live/v1.0.54/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "baf54ee2b46259777b3969a7fdeb2534e2349e270eab60c2c49e066b3a153d44"
    else
      url "https://releases.taiku.live/v1.0.54/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f3de41324f89b05cf4228858409567611f89659b75df001bb2a3c878a9a46e5a"
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
