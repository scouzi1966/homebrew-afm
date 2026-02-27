cask "vesta-mac-next" do
  version "0.9.6-next.8de93c3.20260227"
  sha256 "7f749142e336de4a3b4961d2e23b4b1ef2396557f3b887a088c877b740bbf44e"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/nightly-20260227-8de93c3/Vesta-next.dmg"
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
