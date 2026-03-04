cask "vesta-mac" do
  version "0.9.6"
  sha256 "0f4acd25c4b042d57e4e8716e04d3cf993e28bd149c47f7136a3646546cfcf09"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/v#{version}/Vesta-#{version}.dmg"
  name "Vesta"
  desc "macOS AI chat app with Apple Intelligence, MLX, and llama.cpp backends"
  homepage "https://github.com/scouzi1966/vesta-mac-dist"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "Vesta.app"
end
