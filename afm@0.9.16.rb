class AfmAT0916 < Formula
  desc "OpenAI-compatible API for Apple Foundation Models and MLX"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.9.16/afm-v0.9.16-arm64.tar.gz"
  sha256 "393bbc5aa3046b0bebfbc6e89750c82a47628eee0d918815acb977aed9aef161"
  license "MIT"

  keg_only :versioned_formula

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    libexec.install "afm"
    libexec.install "MacLocalAPI_AFMKitMLX.bundle"
    libexec.install "MacLocalAPI_AFMKitDwarfStar.bundle"
    (bin/"afm").write_env_script libexec/"afm", AFM_BUILD_VERSION: "v#{version}"

    if File.exist?("Resources/webui/index.html.gz")
      (share/"afm/webui").install "Resources/webui/index.html.gz"
    end
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      AFM requires:
      - macOS 26+ with Apple Intelligence enabled
      - Apple Silicon Mac

      Enable Apple Intelligence in System Settings → Apple Intelligence & Siri

      Usage:
        afm -w                                  # WebUI with Apple Foundation Model
        afm -w -g                               # WebUI + API gateway (discovers Ollama, LM Studio, etc.)
        afm -s "Hello, AI!"                     # Single prompt mode

      MLX Local Models (v0.9.16+):
        afm mlx -m mlx-community/Qwen2.5-0.5B-Instruct-4bit -s "Hello"
        afm mlx -m mlx-community/gemma-3-4b-it-8bit -w
        afm mlx -w                              # Interactive model picker

      More:
        afm --help                              # Full options
        afm mlx --help                          # MLX options
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/afm --version")
    assert_match "mlx", shell_output("#{bin}/afm --help")
    assert_path_exists share/"afm/webui/index.html.gz"
  end
end
