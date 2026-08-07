cask "taiku" do
  version "1.0.28"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.28/taiku-darwin-arm64.dmg"
    sha256 "a9147c697f5a314bd9b32809e80753426a4c6f9e41d1c827e71b8ddc62561bd9"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.28/taiku-darwin-x64.dmg"
    sha256 "c2f69b24d399188ffa16f6485f55b380fee7937b430600109e28b4fc83292947"
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
