cask "vesta-mac-next" do
  version "0.9.6-next.d050a1e.20260302"
  sha256 "2979f5f654cf74c35bc92cc51071e15939afcf0a428ac4408e8e421962181553"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/nightly-20260302-d050a1e/Vesta-next.dmg"
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
