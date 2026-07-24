cask "taiku" do
  version "1.0.9"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.9/taiku-darwin-arm64.dmg"
    sha256 "2eafe8759094998cfd216b3bf8dabf7db3e65b897027508c72f791bb9753fbc0"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.9/taiku-darwin-x64.dmg"
    sha256 "37c6cee110a4985d911d1c13d5740d13f9c9d6f9a67044d2f35b960d622b0a9d"
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
