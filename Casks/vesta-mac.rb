cask "vesta-mac" do
  version "0.9.7"
  sha256 "d6b488f24ddbeddfeda016c165ffa8dadd99a853774561663e0291a5051f7bbe"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/v#{version}/Vesta-#{version}.dmg"
  name "Vesta"
  desc "AI chat app with Apple Intelligence, MLX, and llama.cpp backends"
  homepage "https://github.com/scouzi1966/vesta-mac-dist"

  livecheck do
    url "https://github.com/scouzi1966/vesta-mac-dist"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "Vesta.app"
end
