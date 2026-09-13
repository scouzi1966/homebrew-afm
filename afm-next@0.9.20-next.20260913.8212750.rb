class AfmNextAT0920Next202609138212750 < Formula
  desc "OpenAI-compatible local LLM API pinned nightly from 20260913"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/nightly-20260913-8212750/afm-next-arm64.tar.gz"
  version "0.9.20-next.20260913.8212750"
  sha256 "e7e9189cc2f0a92929c6da1555f4dc42b5f3b129b50c46771b888b7841265f86"
  license "MIT"
  version_scheme 1

  depends_on arch: :arm64
  depends_on macos: :tahoe

  conflicts_with "afm", "afm-next", "afm-staging", because: "all install an `afm` executable"

  def install
    libexec.install "afm"
    libexec.install "MacLocalAPI_AFMEvaluationHost.bundle"
    libexec.install "AFMKit_AFMKitMLX.bundle"
    libexec.install "AFMKit_AFMKitDwarfStar.bundle"
    (bin/"afm").write_env_script libexec/"afm", AFM_BUILD_VERSION: "v#{version}"

    if File.exist?("Resources/webui/index.html")
      (share/"afm/webui").install Dir["Resources/webui/*"]
    end
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      This is a pinned historical nightly (20260913).
      For the latest nightly: brew install scouzi1966/afm/afm-next
      For the latest stable:  brew install scouzi1966/afm/afm
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/afm --version")
    assert_match "mlx", shell_output("#{bin}/afm --help")
    assert_path_exists share/"afm/webui/index.html"
  end
end
