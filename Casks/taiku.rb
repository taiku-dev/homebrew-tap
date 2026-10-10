cask "taiku" do
  version "1.0.44"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.44/taiku-darwin-arm64.dmg"
    sha256 "396ada31f2f14a64747197355bde01f6b213f5ccb788302e36baae8cd20568f4"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.44/taiku-darwin-x64.dmg"
    sha256 "ac487c28f3a03fa7ed7afd4121299e59b0b1f1fbc3c0ba48adf5021772dba663"
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
