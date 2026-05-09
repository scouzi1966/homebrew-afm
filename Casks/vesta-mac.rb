cask "vesta-mac" do
  version "0.9.7"
  sha256 "363659eca367afb7a0d69f0fd1b48a1f6f18ba9742796b20b8b094151bf8fa05"

  url "https://github.com/scouzi1966/vesta-mac-dist/releases/download/v#{version}/Vesta-#{version}.dmg"
  name "Vesta"
  desc "macOS AI chat app with Apple Intelligence, MLX, and llama.cpp backends"
  homepage "https://github.com/scouzi1966/vesta-mac-dist"

  livecheck do
    url :url
    regex(%r{/download/v?(\d+(?:\.\d+)+)/Vesta[._-]v?\1\.dmg}i)
  end

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "Vesta.app"
end
