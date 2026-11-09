cask "taiku" do
  version "1.0.54"

  if Hardware::CPU.arm?
    url "https://releases.taiku.live/v1.0.54/taiku-darwin-arm64.dmg"
    sha256 "653b4dc44a6511a582d7efaa46e2d42b04ee3af76ea405cab0eec7701f328248"
  else
    url "https://releases.taiku.live/v1.0.54/taiku-darwin-x64.dmg"
    sha256 "90be6f75e37a29ce571b85b447fdd0eebeda74ddaa531714bb9e0e22e10f3d90"
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
