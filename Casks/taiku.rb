cask "taiku" do
  version "1.0.30"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.30/taiku-darwin-arm64.dmg"
    sha256 "f52f57cc28ee17119398da9a1ed0d074dac7a46d758127ffde7c7cbd8f8448d8"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.30/taiku-darwin-x64.dmg"
    sha256 "7d8490211a47881d28517eadcedb1395c20e310f571dc72919b4da09688ee6ba"
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
