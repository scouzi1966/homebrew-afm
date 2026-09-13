class AfmNext < Formula
  desc "OpenAI-compatible local LLM API development build"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/nightly-20260913-8212750/afm-next-arm64.tar.gz"
  version "0.9.20-next.20260913.8212750"
  sha256 "e7e9189cc2f0a92929c6da1555f4dc42b5f3b129b50c46771b888b7841265f86"
  license "MIT"
  version_scheme 1

  depends_on arch: :arm64
  depends_on macos: :tahoe

  conflicts_with "afm", "afm-staging", because: "all three install an `afm` executable"

  def install
    libexec.install "afm"
    libexec.install "MacLocalAPI_AFMEvaluationHost.bundle"
    libexec.install "AFMKit_AFMKitMLX.bundle"
    libexec.install "AFMKit_AFMKitDwarfStar.bundle"
    (bin/"afm").write_env_script libexec/"afm", AFM_BUILD_VERSION: "v#{version}"

    if File.exist?("Resources/webui/index.html")
      (share/"afm/webui").install Dir["Resources/webui/*"]
    end
    doc.install "README.md" if File.exist?("README.md")
  end

  def caveats
    <<~EOS
      afm-next is a prerelease development build of AFM.
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
    assert_equal "v#{version}", shell_output("#{bin}/afm --version").strip
    assert_match "mlx", shell_output("#{bin}/afm --help")
    assert_path_exists share/"afm/webui/index.html"
    assert_match "comprehensive", shell_output("#{bin}/afm mlx --eval-list")
  end
end
