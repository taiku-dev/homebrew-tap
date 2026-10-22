cask "taiku" do
  version "1.0.47"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.47/taiku-darwin-arm64.dmg"
    sha256 "2b6be7c945bacc062a0507fba0a42003e153e4863e4680665e119aa390733fec"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.47/taiku-darwin-x64.dmg"
    sha256 "6dc4647c83d22ad5c9f2edc71c72f8cabc391f6db8e73fcc75cc9214a4557911"
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
