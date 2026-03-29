class Taiku < Formula
  desc "Collaborative terminal sharing — CLI"
  homepage "https://taiku.live"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-apple-darwin.tar.gz"
      sha256 "315379853b303afd0f41146aff927d424d9cdcbc595117e3a97a17a85513f45c"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-apple-darwin.tar.gz"
      sha256 "dd9cc9fb8cda3a6e89c2b9a4aa3f62bdd0a62392e692e4a69e0d0d7d914d1912"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://taiku-releases.s3.amazonaws.com/taiku-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e59784476033145ca424e5ff58ecfbdd49f58eb0062c4d0826f3fceab4850c84"
    else
      url "https://taiku-releases.s3.amazonaws.com/taiku-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b1067ce8c41569ed78b1c915d59f3893cb272da97c19fcfc1eeb84e2dcf1e016"
    end
  end

  def install
    bin.install "taiku"
  end

  test do
    assert_match "taiku", shell_output("#{bin}/taiku --version")
  end
end
