class Afm < Formula
  desc "Apple Foundation Models server with OpenAI-compatible API"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.5.1/afm-v0.5.1-arm64.tar.gz"
  version "0.5.1"
  sha256 "ae9ad912ba795a55c1efdb569cb0e4dcb3af2f7e686ff47e8e4ecb3e0b3db6c1"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "afm"
  end

  def caveats
    <<~EOS
      AFM requires:
      - macOS 26+ with Apple Intelligence enabled
      - Apple Silicon Mac (M1/M2/M3/M4 series)

      Enable Apple Intelligence in System Settings → Apple Intelligence & Siri

      Usage:
        afm --help                    # Show help
        afm --port 9999              # Start server on port 9999
        afm -s "Hello, AI!"          # Single prompt mode
        echo "Hi" | afm              # Pipe input support
    EOS
  end

  test do
    assert_match "v0.5.1", shell_output("#{bin}/afm --version")
  end
end