class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "1.0.47"
  license "MIT"

  on_macos do
    # Checked against the declared floor by macos-floor.mjs config.
    # Homebrew names only a major release, so 12.0 to 12.2 pass this
    # and are refused by the install method below.
    depends_on macos: :monterey
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.47/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "17b649105633e6c41622f4db50e481e66b2235bdf0e58a070a1050f52c5d6d0e"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.47/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "60f4b645ff03348a364d6cc747c7db72fc19fc3b5b15c6b1d6f592f9cf556809"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/v1.0.47/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5c116c0d90494ca402e043ab933cb2248ef32f405a9ceafaa382d23537678ca9"
    else
      url "https://taiku-releases.s3.amazonaws.com/v1.0.47/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e19373d24b079190f0cf5deff2a30fc563f8be357cac03915a4df110160ec2d4"
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
