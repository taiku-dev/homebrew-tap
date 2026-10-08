cask "taiku" do
  version "1.0.43"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.43/taiku-darwin-arm64.dmg"
    sha256 "b9bcb76bba1c25fbeb9fa36ddd74e63a7b489fb96670e739393ee55ee0768499"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.43/taiku-darwin-x64.dmg"
    sha256 "a3f601b691d4ef77399f4c899cc7af76b31f537204a51014a8e42c690754f13c"
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
