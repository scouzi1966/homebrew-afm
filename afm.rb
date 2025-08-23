class Afm < Formula
  desc "Apple Foundation Models server with OpenAI-compatible API"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.5.3/afm-v0.5.3-arm64.tar.gz"
  version "0.5.3"
  sha256 "11d1cd96989ab2dd37a2651ef3f196025c188f94394a916b17084ac3954d8e93"

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
        afm -a "model.fmadapter" -s "Hi" # LoRA adapter support
        afm vision -f image.png      # OCR text extraction
        afm vision -f doc.pdf --table # Extract tables as CSV
    EOS
  end

  test do
    assert_match "v0.5.3", shell_output("#{bin}/afm --version")
  end
end