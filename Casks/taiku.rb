cask "taiku" do
  version "0.4.4"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-arm64.dmg"
    sha256 "669d4e285a5406c374ec858f4134893d01eea0e179b73b5df14762f0e7447e2b"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-x64.dmg"
    sha256 "c544473a15a72abc0648ce613860d942c9239d3f5f0e6cb6b45c9d72369996d6"
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
