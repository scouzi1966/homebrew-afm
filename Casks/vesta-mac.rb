cask "vesta-mac" do
  version "0.9.5"
  sha256 "bf5915425929df1be9c07787d635868a284b7a81e243cdc82d1fe7c8368b376b"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/v#{version}/Vesta-#{version}.dmg"
  name "Vesta"
  desc "macOS AI chat app with Apple Intelligence, MLX, and llama.cpp backends"
  homepage "https://github.com/scouzi1966/vesta-mac-dist"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "Vesta.app"
end
