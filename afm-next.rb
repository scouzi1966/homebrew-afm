class AfmNext < Formula
  desc "AFM next — OpenAI-compatible local LLM API (development build)"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/nightly-20260226-cd2941e/afm-next-arm64.tar.gz"
  version "0.9.5-next.cd2941e.20260226"
  sha256 "e0d9f7d3d98b791fd2122fb9289d8574ffd09e7182a33456d2666b4b382688aa"

  depends_on arch: :arm64
  depends_on :macos

  conflicts_with "afm", because: "both install an `afm` binary"

  def install
    bin.install "afm"
    # Install metallib resource bundle
    if File.directory?("MacLocalAPI_MacLocalAPI.bundle")
      (libexec/"MacLocalAPI_MacLocalAPI.bundle").install Dir["MacLocalAPI_MacLocalAPI.bundle/*"]
    end
    # Install webui resources
    if File.exist?("Resources/webui/index.html.gz")
      (share/"afm/webui").install "Resources/webui/index.html.gz"
    end
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
