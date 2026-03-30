cask "taiku" do
  version "0.4.3"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-arm64.dmg"
    sha256 "0b9727b0131bdb71ea25031d6771bcd42b08b1efb2770760aa9dfebd162eeddc"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-x64.dmg"
    sha256 "2bd08b4e0ff99128529bbde4ca8aae989f74a8704fe51ed5da35349ad1ef8406"
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
