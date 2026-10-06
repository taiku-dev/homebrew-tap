cask "taiku" do
  version "1.0.41"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/v1.0.41/taiku-darwin-arm64.dmg"
    sha256 "3a712593acbd7356d81bbcfdf5a1e34d6472aa6f42b7d8b23b74d9154d6fa50a"
  else
    url "https://taiku-releases.s3.amazonaws.com/v1.0.41/taiku-darwin-x64.dmg"
    sha256 "d56f0328c9a9ce4a284c49a26a02418afd679fb9900f216fc56abe06e84f591d"
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
