cask "taiku" do
  version "1.0.39"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.39/taiku-darwin-arm64.dmg"
    sha256 "82fe449ba1beea62c6893eca3cf409a285267e4ca536c7ad78af806fabc56b5e"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.39/taiku-darwin-x64.dmg"
    sha256 "bf0df7c916e7cffba83b39d5ee58cc16dbf82361643d177aaf5c098144b63411"
  end

  name "taiku"
  desc "Collaborative terminal sharing — desktop app with bundled CLI"
  homepage "https://taiku.live"

  # Checked against the declared floor by macos-floor.mjs config.
  # Homebrew names only a major release, so 12.0 to 12.2 pass this
  # and are refused by the preflight block with the reason, rather
  # than installing an app macOS will not open.
  depends_on macos: ">= :monterey"

  preflight do
    if MacOS.full_version < "12.3"
      raise CaskError, "taiku needs macOS 12.3 or newer; this Mac runs #{MacOS.full_version}. Update macOS, then install again."
    end
    system_command "/usr/bin/xattr", args: ["-cr", "#{staged_path}/taiku.app"]
  end

  app "taiku.app"
  binary "taiku.app/Contents/MacOS/taiku"

  zap trash: [
    "~/.config/taiku",
  ]
end
