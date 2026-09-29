cask "taiku" do
  version "1.0.36"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.36/taiku-darwin-arm64.dmg"
    sha256 "1e2ecf2fb0d91b405cd5ceec0d18c6f29354f62336d198fcc0184f92ad72b591"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.36/taiku-darwin-x64.dmg"
    sha256 "3f5e6175c995f91716417c682eb21dda57e242048d505b58dc2c297010216bec"
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
