cask "taiku" do
  version "0.4.2"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-aarch64-apple-darwin.tar.gz"
    sha256 "b0d4ae6854959f2b56a8bc514c5169e767953bfaf2ea47786d95b3dab4aee6d9"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-x86_64-apple-darwin.tar.gz"
    sha256 "605e7119d1aaae0e966678cf144cf3fdd86ac5035b3ece64263a48ce0935fdd8"
  end

  name "taiku"
  desc "Collaborative terminal sharing — desktop app with bundled CLI"
  homepage "https://taiku.live"

  # Remove quarantine flag (app is not yet notarized).
  preflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{staged_path}/taiku.app"]
  end

  app "taiku.app"
  # The .app bundle includes the CLI at Contents/MacOS/taiku.
  # Symlink it into the PATH so `taiku` works from terminal too.
  binary "taiku.app/Contents/MacOS/taiku"

  zap trash: [
    "~/.config/taiku",
  ]
end
