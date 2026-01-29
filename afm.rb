class Afm < Formula
  desc "Apple Foundation Models server with OpenAI-compatible API and advanced sampling"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.9.2/afm-v0.9.2-arm64.tar.gz"
  version "0.9.2"
  sha256 "cef3773683052a4486e0b39efe2fef602dd030cfc0a790e57211578bd8e2f5e2"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "afm"
    # Install webui resources if present
    if File.exist?("share/afm/webui/index.html.gz")
      (share/"afm/webui").install "share/afm/webui/index.html.gz"
    end
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
        afm -w                                  # Start with WebUI (opens browser)
        afm --hostname 0.0.0.0                  # Allow external connections
        afm -s "Hello, AI!"                     # Single prompt mode
        echo "Hi" | afm                         # Pipe input support
        afm -a "model.fmadapter" -s "Hi"        # LoRA adapter support

      WebUI + Gateway (v0.9.2+):
        afm -w                                  # Start with WebUI
        afm -w -g                               # WebUI + API gateway (auto-discovers backends)
        afm --webui --port 8080                 # WebUI on custom port

      Enhanced Randomness Parameters (v0.7.0+):
        afm -r "random:top-p=0.9" -s "Story"   # Nucleus sampling
        afm -r "random:top-k=50" -s "Story"    # Top-k sampling
        afm -r "random:seed=42" -s "Story"     # Seeded random
        afm -r "random:top-p=0.9:seed=42" -s "Story" # Combined mode

      Permissive Guardrails (v0.8.0+):
        afm -P -s "Analyze content"            # Enable permissive mode
        afm --permissive-guardrails --port 9999 # Server with permissive mode
    EOS
  end

  test do
    assert_match "v0.9.2", shell_output("#{bin}/afm --version")
  end
end
