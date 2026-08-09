cask "taiku" do
  version "1.0.29"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.29/taiku-darwin-arm64.dmg"
    sha256 "5425219b278b4a47569fafcf7db572418432866113840ea5371369e0a3919343"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.29/taiku-darwin-x64.dmg"
    sha256 "4c81a3fff23e9f626fdb1922fc5a4e99e7e4d6d3a770d7a24efdbe85fe99d047"
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
