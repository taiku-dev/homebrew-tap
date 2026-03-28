cask "taiku" do
  version "0.4.3"

  if Hardware::CPU.arm?
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-aarch64-apple-darwin.tar.gz"
    sha256 "e6572c949a21009113f7b6aa9a07150c83cc7e2936dcd25aa5ae9d41956fe9a6"
  else
    url "https://taiku-releases.s3.amazonaws.com/taiku-desktop-x86_64-apple-darwin.tar.gz"
    sha256 "f3a1b57b49e78ba3c0ea293dd99d9d7c1ee5a8d753c6c78619725127a20cacb6"
  end

  name "taiku"
  desc "Collaborative terminal sharing — desktop app with bundled CLI"
  homepage "https://taiku.live"

  preflight do
    system_command "/usr/bin/xattr", args: ["-cr", "#{staged_path}/taiku.app"]
  end

  app "taiku.app"
  binary "taiku.app/Contents/MacOS/taiku"

  zap trash: [
    "~/.config/taiku",
  ]
end
