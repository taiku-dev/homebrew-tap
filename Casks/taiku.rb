cask "taiku" do
  version "1.0.45"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.45/taiku-darwin-arm64.dmg"
    sha256 "0561c981f1443617c4ce185f7c356711fde9ce9a8a3cf171d208e4fbc2beedcf"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.45/taiku-darwin-x64.dmg"
    sha256 "51d85d699a54a16964641a25d9f2c7ace673a7786b06db9d5a3dc9896d923797"
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
