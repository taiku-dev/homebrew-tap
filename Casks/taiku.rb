cask "taiku" do
  version "1.0.6"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-arm64.dmg"
    sha256 "ca59c653cd83e9376299e643c5f86e476685ec927ce324876d4f683d1e7b9d52"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-x64.dmg"
    sha256 "b359716822883414e089e66c5877cd0181a7cd4b65410d80f4ac7f73b9de0c46"
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
