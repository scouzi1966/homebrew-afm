cask "vesta-mac-next" do
  version "0.9.6-next.45b5cf0.20260303"
  sha256 "ee7cec3072cc5f1bfa776021be39a291bbafda0736cb3d82e2dc540a5ae6867a"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/nightly-20260303-45b5cf0/Vesta-next.dmg"
  name "Vesta Beta"
  desc "macOS AI chat app — development build (Apple Intelligence, MLX, llama.cpp)"
  homepage "https://github.com/scouzi1966/vesta-mac-dist"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  conflicts_with cask: "vesta-mac"

  app "Vesta.app"

  caveats <<~EOS
    Vesta-next is the development build of Vesta, updated from main.
    For the stable release, use: brew install --cask scouzi1966/afm/vesta-mac

    Requires Apple Silicon Mac and macOS 26+.
  EOS
end
