class Afm < Formula
  desc "Apple Foundation Models + MLX local models — OpenAI-compatible API, WebUI, all Swift"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.9.6/afm-v0.9.6-arm64.tar.gz"
  version "0.9.6"
  sha256 "30cb298c9d78d0a01abc9d1db45b34c254ede1b5128e0b8d80c656e3347e22c7"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "afm"
    # Swift's Bundle.module resolves symlinks and looks next to the real binary
    # in Cellar/.../bin/, so the .bundle must live there — not in libexec.
    if File.directory?("MacLocalAPI_MacLocalAPI.bundle")
      (bin/"MacLocalAPI_MacLocalAPI.bundle").install Dir["MacLocalAPI_MacLocalAPI.bundle/*"]
    end
    # Install webui resources if present
    if File.exist?("Resources/webui/index.html.gz")
      (share/"afm/webui").install "Resources/webui/index.html.gz"
    end
  end

  def caveats
    <<~EOS
      AFM requires:
      - macOS 26+ with Apple Intelligence enabled
      - Apple Silicon Mac (M1/M2/M3/M4 series)

      Enable Apple Intelligence in System Settings → Apple Intelligence & Siri

      Usage:
        afm -w                                  # WebUI with Apple Foundation Model
        afm -w -g                               # WebUI + API gateway (discovers Ollama, LM Studio, etc.)
        afm -s "Hello, AI!"                     # Single prompt mode

      MLX Local Models (v0.9.6+):
        afm mlx -m mlx-community/Qwen2.5-0.5B-Instruct-4bit -s "Hello"
        afm mlx -m mlx-community/gemma-3-4b-it-8bit -w
        afm mlx -w                              # Interactive model picker

      More:
        afm --help                              # Full options
        afm mlx --help                          # MLX options
    EOS
  end

  test do
    assert_match "v0.9.6", shell_output("#{bin}/afm --version")
  end
end
