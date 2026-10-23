cask "taiku" do
  version "1.0.48"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.48/taiku-darwin-arm64.dmg"
    sha256 "12bfeb610b4f74d6ae0a3b55a61f550b7ff96a335b93aec595aac2cb4a3910ab"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.48/taiku-darwin-x64.dmg"
    sha256 "a47ffabc8121266812695e0416e1b73a5fd7c7f0c545b4ecd603a24c24585c49"
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
