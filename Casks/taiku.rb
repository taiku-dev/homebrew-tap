cask "taiku" do
  version "1.0.35"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.35/taiku-darwin-arm64.dmg"
    sha256 "bf62837f6143771fe2fbd22736b6ee5c89cac3eadfb273b585096a7153adc03b"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.35/taiku-darwin-x64.dmg"
    sha256 "6ead67bc7ecdaff006bf4714b71a39e9bd00a030d68269d74c932159c28953d8"
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
