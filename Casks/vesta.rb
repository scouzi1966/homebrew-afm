cask "vesta" do
  version "0.9.0"
  sha256 "77ce53ddda39a6f2598a11d980537fbbb03823f53a0dfacbe4ee67074dda717d"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/v#{version}/Vesta-#{version}.dmg"
  name "Vesta"
  desc "macOS AI chat app with Apple Intelligence, MLX, and llama.cpp backends"
  homepage "https://github.com/scouzi1966/vesta-mac-dist"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "Vesta.app"
end
