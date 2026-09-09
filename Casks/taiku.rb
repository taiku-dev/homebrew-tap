cask "taiku" do
  version "1.0.31"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.31/taiku-darwin-arm64.dmg"
    sha256 "18bd60c589886bd8fb5bc6145605f99513a9327d3879f88a87c5b497d0dddd06"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.31/taiku-darwin-x64.dmg"
    sha256 "afbdb65ce95571ed95ccdd7248edf7c4c94d539439b3a0e675d73ef2a73d1264"
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
