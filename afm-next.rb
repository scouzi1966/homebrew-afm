class AfmNext < Formula
  desc "AFM next — OpenAI-compatible local LLM API (development build)"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/nightly-20260621-97e6683/afm-next-arm64.tar.gz"
  version "0.9.13-next.97e6683.20260621"
  sha256 "4ca85c3de65d0357e25562ee864c499a64d18849e70ac9c42426dca81572fab1"

  depends_on arch: :arm64
  depends_on :macos

  conflicts_with "afm", because: "both install an `afm` binary"

  def install
    bin.install "afm"
    # Install metallib resource bundle to libexec (brew won't symlink dirs from bin/)
    if File.directory?("MacLocalAPI_MacLocalAPI.bundle")
      (libexec/"MacLocalAPI_MacLocalAPI.bundle").install Dir["MacLocalAPI_MacLocalAPI.bundle/*"]
    end
    # Install webui resources
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
    bundle_dst.unlink if bundle_dst.symlink? || bundle_dst.exist?
    bundle_dst.make_symlink(bundle_src) if bundle_src.exist?
  end

  def caveats
    <<~EOS
      afm-next is the development build of AFM, updated nightly from main.
      For the stable release, use: brew install scouzi1966/afm/afm

      AFM requires:
      - macOS 26+ with Apple Intelligence enabled (for `afm` command)
      - Apple Silicon Mac (M1/M2/M3/M4 series)

      Usage:
        afm mlx -m mlx-community/Qwen2.5-0.5B-Instruct-4bit -s "Hello"
        afm mlx -w                              # Interactive model picker
        afm --help                              # Full options
    EOS
  end

  test do
    assert_match "afm", shell_output("#{bin}/afm --version")
  end
end
