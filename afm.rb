class Afm < Formula
  desc "Apple Foundation Models + MLX local models — OpenAI-compatible API, WebUI, all Swift"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.9.14/afm-v0.9.14-arm64.tar.gz"
  version "0.9.14"
  sha256 "5d697056452e214968190ad26c6bc75a60d646774d5eb9045fecfea71e29e0e0"

  depends_on arch: :arm64
  depends_on :macos

  conflicts_with "afm-next", "afm-staging", because: "all install an `afm` executable"

  def install
    bin.install "afm"
    # Install the metallib resource bundle next to the binary in Cellar
    if File.directory?("MacLocalAPI_MacLocalAPI.bundle")
      (bin/"MacLocalAPI_MacLocalAPI.bundle").install Dir["MacLocalAPI_MacLocalAPI.bundle/*"]
    end
    # Install webui resources if present
    if File.exist?("Resources/webui/index.html.gz")
      (share/"afm/webui").install "Resources/webui/index.html.gz"
    end
  end

  def post_install
    # Brew symlinks bin/afm into HOMEBREW_PREFIX/bin/ but won't auto-symlink
    # directories. The binary looks for the .bundle next to itself (the symlink
    # in HOMEBREW_PREFIX/bin/), so we must symlink the .bundle dir there too.
    bundle_src = bin/"MacLocalAPI_MacLocalAPI.bundle"
    bundle_dst = HOMEBREW_PREFIX/"bin/MacLocalAPI_MacLocalAPI.bundle"
    bundle_dst.unlink if bundle_dst.symlink? || bundle_dst.exist?
    bundle_dst.make_symlink(bundle_src) if bundle_src.exist?
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

      MLX Local Models (v0.9.14+):
        afm mlx -m mlx-community/Qwen2.5-0.5B-Instruct-4bit -s "Hello"
        afm mlx -m mlx-community/gemma-3-4b-it-8bit -w
        afm mlx -w                              # Interactive model picker

      More:
        afm --help                              # Full options
        afm mlx --help                          # MLX options
    EOS
  end

  test do
    assert_match "v0.9.14", shell_output("#{bin}/afm --version")
  end
end
