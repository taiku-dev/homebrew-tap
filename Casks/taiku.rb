cask "taiku" do
  version "1.0.10"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.10/taiku-darwin-arm64.dmg"
    sha256 "6e9b53a5b1f0cab3aa655b2c6a4b1c13118f2f7114a71934c438ab8c7886e90e"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.10/taiku-darwin-x64.dmg"
    sha256 "a0098f23abcdd12045a74b9f9c0b8aa90becd201595a297d025d6a925cc8558e"
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
