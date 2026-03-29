cask "taiku" do
  version "0.4.3"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-aarch64-apple-darwin.dmg"
    sha256 "ace7d23bc0401010177febefe4ea1363526afdac64b9652730481ad874b67ffd"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-x86_64-apple-darwin.dmg"
    sha256 "a4d32a6fa5b132d4945c1353851cede2028f1409eff653ee4b2752b660e86b07"
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
