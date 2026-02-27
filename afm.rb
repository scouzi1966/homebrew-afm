class Afm < Formula
  desc "Apple Foundation Models + MLX local models — OpenAI-compatible API, WebUI, all Swift"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.9.4/afm-v0.9.4-arm64.tar.gz"
  version "0.9.4"
  sha256 "977f54f7ae762778eb1022b3f0b4d1c0b3e989f2200f0031d9af74321b3d3903"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "afm"
    # Install metallib resource bundle to libexec (brew won't symlink dirs from bin/)
    if File.directory?("MacLocalAPI_MacLocalAPI.bundle")
      (libexec/"MacLocalAPI_MacLocalAPI.bundle").install Dir["MacLocalAPI_MacLocalAPI.bundle/*"]
    end
    # Install webui resources if present
    if File.exist?("Resources/webui/index.html.gz")
      (share/"afm/webui").install "Resources/webui/index.html.gz"
    end
  end

  def post_install
    # Swift's Bundle.module looks for the .bundle next to the binary.
    # Brew symlinks bin/afm to /opt/homebrew/bin/afm but won't symlink dirs,
    # so we create the symlink manually.
    bundle_src = libexec/"MacLocalAPI_MacLocalAPI.bundle"
    bundle_dst = HOMEBREW_PREFIX/"bin/MacLocalAPI_MacLocalAPI.bundle"
    if bundle_src.exist? && !bundle_dst.exist?
      bundle_dst.make_symlink(bundle_src)
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

      MLX Local Models (v0.9.4+):
        afm mlx -m mlx-community/Qwen2.5-0.5B-Instruct-4bit -s "Hello"
        afm mlx -m mlx-community/gemma-3-4b-it-8bit -w
        afm mlx -w                              # Interactive model picker

      More:
        afm --help                              # Full options
        afm mlx --help                          # MLX options
    EOS
  end

  test do
    assert_match "v0.9.4", shell_output("#{bin}/afm --version")
  end
end
