cask "taiku" do
  version "1.0.37"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.37/taiku-darwin-arm64.dmg"
    sha256 "a3a49b9c30968dc10cc4e5c4f0abcda1b58f2baae204945369f56c25351b415f"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.37/taiku-darwin-x64.dmg"
    sha256 "7e79c8cd786afb06518140ad8690650a9d85070a6818be9374349e11426676e5"
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
