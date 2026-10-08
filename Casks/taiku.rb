cask "taiku" do
  version "1.0.42"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.42/taiku-darwin-arm64.dmg"
    sha256 "e6c7344ceeeaadf401649ffc174ab051447851f91494e083f9576e45bafc0850"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.42/taiku-darwin-x64.dmg"
    sha256 "cb6bd6a3533e223c87c83c194295a0b8c512244fbb31be11f10f655a30942d54"
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
