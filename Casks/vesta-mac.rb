cask "vesta-mac" do
  version "0.9.7"
  sha256 "ca806abe2d72254a0ca8cd9207fda8a89b2de03fd8427e6a5c39de9bdc23c137"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/v#{version}/Vesta-#{version}.dmg"
  name "Vesta"
  desc "macOS AI chat app with Apple Intelligence, MLX, and llama.cpp backends"
  homepage "https://github.com/scouzi1966/vesta-mac-dist"

  livecheck do
    url "https://github.com/scouzi1966/vesta-mac-dist"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "Vesta.app"
end
