cask "vesta-mac-next" do
  version "0.9.6-next.ecb93da.20260227"
  sha256 "2e8e7da06d2844575538b63af3b5df6908b48ee477351d60d36358282b8308e0"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/nightly-20260227-ecb93da/Vesta-next.dmg"
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
