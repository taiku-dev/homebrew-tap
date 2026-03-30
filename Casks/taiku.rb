cask "taiku" do
  version "0.4.3"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-arm64.dmg"
    sha256 "724a344dc375332000c17a7894734f7e832a1d13c830d3167424ada95620ad6e"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-darwin-x64.dmg"
    sha256 "c4e03b5761ff8af980042fc942c65a39c36e471fc8487727995ff013839f3ea2"
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
