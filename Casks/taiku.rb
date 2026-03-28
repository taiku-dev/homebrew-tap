cask "taiku" do
  version "0.4.3"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-aarch64-apple-darwin.tar.gz"
    sha256 "7d92e36753f4e484c51edab426b4d184864ee150a9a37e74cad8acfdd97e6d1f"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-x86_64-apple-darwin.tar.gz"
    sha256 "87998317f5d523554d9867ebb8b0265b232f384fb2420633d0ec0ee82cc1992d"
  end

  name "taiku"
  desc "Collaborative terminal sharing — desktop app with bundled CLI"
  homepage "https://taiku.live"

  preflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{staged_path}/taiku.app"]
  end

  app "taiku.app"
  binary "taiku.app/Contents/MacOS/taiku"

  zap trash: [
    "~/.config/taiku",
  ]
end
