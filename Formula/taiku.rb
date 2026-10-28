class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.51"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://releases.taiku.live/v1.0.51/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "1825bdc3741de72308545721c8525ac617cd57717f189bbde426d22a7eefef28"
    else
      url "https://releases.taiku.live/v1.0.51/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "98f012c86c1a2f8cddeee8698f3c8a22775f90647561006e1066bff08cd181b7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://releases.taiku.live/v1.0.51/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2a3998142e3d0b19c935bd028654b6200f56f11b9b94047289b25b57f8e60e4e"
    else
      url "https://releases.taiku.live/v1.0.51/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "dfa259dcd11014350e9597276f4d8bff668fe8b68c98df169ab6055c2a2049eb"
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
