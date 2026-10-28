cask "taiku" do
  version "1.0.51"

  if Hardware::CPU.arm?
    url "https://releases.taiku.live/v1.0.51/taiku-darwin-arm64.dmg"
    sha256 "1809a8c2dab4c8f5479bd782be4005cad6c92cff50209788e568ccb07b69e0ed"
  else
    url "https://releases.taiku.live/v1.0.51/taiku-darwin-x64.dmg"
    sha256 "0435c3e91dffe69c70337a73371636a2a51750c3079d22a33477e36b807e87b9"
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
