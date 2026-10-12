cask "taiku" do
  version "1.0.46"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.46/taiku-darwin-arm64.dmg"
    sha256 "d36323bb7010cdc37340853978fab96ca580e5c097a63c59a3433c44ac956887"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.46/taiku-darwin-x64.dmg"
    sha256 "78fa25440ea8cf2575ade912233f6b2e44dfb9aad430671634c63acfc4422dbd"
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
