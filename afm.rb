class Afm < Formula
  desc "Apple Foundation Models server with OpenAI-compatible API"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://api.github.com/repos/scouzi1966/maclocal-api/tarball/v0.5.6"
  version "0.5.6"
  sha256 "fce40500784973f78c57593b26b7316701d1e3be44440e9b2c4128429cb153aa"

  depends_on arch: :arm64
  depends_on :macos

  def install
    # GitHub tarball extracts to a directory like scouzi1966-maclocal-api-<hash>
    # Build the binary from source
    system "swift", "build", "-c", "release"
    bin.install ".build/release/afm"
  end

  def caveats
    <<~EOS
      AFM requires:
      - macOS 26+ with Apple Intelligence enabled
      - Apple Silicon Mac (M1/M2/M3/M4 series)

      Enable Apple Intelligence in System Settings → Apple Intelligence & Siri

      Usage:
        afm --help                    # Show help
        afm --port 9999              # Start server on port 9999 (localhost)
        afm --hostname 0.0.0.0       # Allow external connections
        afm -s "Hello, AI!"          # Single prompt mode
        echo "Hi" | afm              # Pipe input support
        afm -a "model.fmadapter" -s "Hi" # LoRA adapter support
        afm vision -f image.png      # OCR text extraction
        afm vision -f doc.pdf --table # Extract tables as CSV
    EOS
  end

  test do
    assert_match "v0.5.6", shell_output("#{bin}/afm --version")
  end
end