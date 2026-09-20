class AfmNextAT0920Next20260920Afd96da < Formula
  desc "OpenAI-compatible local LLM API pinned nightly from 20260920"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/nightly-20260920-afd96da/afm-next-arm64.tar.gz"
  version "0.9.20-next.20260920.afd96da"
  sha256 "966f7a4e927bf57a7f172abad260ae7c4f4c94844f467eafb1b644d9ef32dfd4"
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
      This is a pinned historical nightly (20260920).
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
