cask "taiku" do
  version "0.4.3"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-arm64.dmg"
    sha256 "92912b7b357f694ede3970db60c9c6141a9c4b69a46ef447a329fb55d16972bb"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-x64.dmg"
    sha256 "daf7823fbe518b930acdc483145942249bd265734e492c5814c7652b01073477"
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
