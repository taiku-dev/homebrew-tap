cask "taiku" do
  version "1.0.7"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.7/taiku-darwin-arm64.dmg"
    sha256 "543f7c6970662b1410478a7415f29adca8a6f525633d7028d226163ac3ba82a2"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.7/taiku-darwin-x64.dmg"
    sha256 "fc32b89a906c05e3b3dfc6c0cbfc25d65ce166c9754d18b1329133077ecfe76b"
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
