cask "taiku" do
  version "0.4.3"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-aarch64-apple-darwin.dmg"
    sha256 "8c7b2d294dfa1b09021044f10e12c48a9494deea9dedcbfadba71ccd10aad866"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-x86_64-apple-darwin.dmg"
    sha256 "9573a862f3df42168ba8bff8f5a0d01c002bd1ee08a43c4e721e50a2dfbe560a"
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
