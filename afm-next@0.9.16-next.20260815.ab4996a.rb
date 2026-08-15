class AfmNextAT0916Next20260815Ab4996a < Formula
  desc "OpenAI-compatible local LLM API pinned nightly from 20260815"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/nightly-20260815-ab4996a/afm-next-arm64.tar.gz"
  version "0.9.16-next.20260815.ab4996a"
  sha256 "cd76825187c12f8f8f3e4aca617c1a64ed95a507bb2b121d200fa78d20c14e6b"
  license "MIT"
  version_scheme 1

  depends_on arch: :arm64
  depends_on macos: :tahoe

  conflicts_with "afm", "afm-next", "afm-staging", because: "all install an `afm` executable"

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
      This is a pinned historical nightly (20260815).
      For the latest nightly: brew install scouzi1966/afm/afm-next
      For the latest stable:  brew install scouzi1966/afm/afm
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/afm --version")
    assert_match "mlx", shell_output("#{bin}/afm --help")
  end
end
