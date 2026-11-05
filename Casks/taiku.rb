cask "taiku" do
  version "1.0.53"

  if Hardware::CPU.arm?
    url "https://releases.taiku.live/v1.0.53/taiku-darwin-arm64.dmg"
    sha256 "26eb255ffc4ca52b1459649cb94d98bf91833616b40316b532215a7c4dee3158"
  else
    url "https://releases.taiku.live/v1.0.53/taiku-darwin-x64.dmg"
    sha256 "9d96474ba00439bd028331b518ce5569da38bbd080fe07cea8d8b67eb93e9181"
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
