cask "taiku" do
  version "1.0.52"

  if Hardware::CPU.arm?
    url "https://releases.taiku.live/v1.0.52/taiku-darwin-arm64.dmg"
    sha256 "891904f2aea093712223a5264e30a05e0b999325df52071942a26464cabcbeb6"
  else
    url "https://releases.taiku.live/v1.0.52/taiku-darwin-x64.dmg"
    sha256 "29bd25a245c0b5fc5054f0af51fb3c751969b2722d257143efd0b3b1fa325024"
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
