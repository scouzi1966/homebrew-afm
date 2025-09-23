class Afm < Formula
  desc "Apple Foundation Models server with OpenAI-compatible API and advanced sampling"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.7.0/afm-v0.7.0-arm64.tar.gz"
  version "0.7.0"
  sha256 "11afe70d44987c5cc96ed7b4e6eb8725b289ccb6ab4e3b67b60527c373c2bb57"

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
        afm --help                              # Show help
        afm --port 9999                         # Start server on port 9999 (localhost)
        afm --hostname 0.0.0.0                  # Allow external connections
        afm -s "Hello, AI!"                     # Single prompt mode
        echo "Hi" | afm                         # Pipe input support
        afm -a "model.fmadapter" -s "Hi"        # LoRA adapter support

      Enhanced Randomness Parameters (v0.7.0+):
        afm -r "random:top-p=0.9" -s "Story"   # Nucleus sampling
        afm -r "random:top-k=50" -s "Story"    # Top-k sampling
        afm -r "random:seed=42" -s "Story"     # Seeded random
        afm -r "random:top-p=0.9:seed=42" -s "Story" # Combined mode
    EOS
  end

  test do
    assert_match "v0.7.0", shell_output("#{bin}/afm --version")
  end
end