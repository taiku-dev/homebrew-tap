class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "48f4ce72539df4c619b406bad44e5d0fd0c9c46322735f650eeee5ed4ef496ab"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "69b1acb99145de64b5f22bcfc499c8a500fe9246bbcfdcef14518036b4e66f3a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4f75c553d71ed475d490f9e288b72f03fc847a2e0aa928c2209ba4cbcc1abf36"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "657976c4cc06e0e2030814dae876ac0190b3642e47f7eaf365b7d0e0c94f46bf"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
