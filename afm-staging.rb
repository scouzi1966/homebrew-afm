class AfmStaging < Formula
  desc "Qualified AFM staging build for Apple Silicon"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/staging-20260807-7bb83c9-v2/afm-staging-arm64.tar.gz"
  version "0.9.15-staging.7bb83c9.20260807"
  sha256 "06f3004179b291f22a24632a755afbf5105c8f0f0d3b0034d9dd8213b88ccae7"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  conflicts_with "afm", "afm-next", because: "all three install an `afm` executable"

  def install
    # Keep the executable beside its SwiftPM resource bundles. The wrapper in
    # bin executes this binary without depending on global bundle symlinks.
    libexec.install "afm"
    libexec.install "MacLocalAPI_AFMKitMLX.bundle"
    libexec.install "MacLocalAPI_AFMKitDwarfStar.bundle"
    (bin/"afm").write_env_script libexec/"afm", AFM_BUILD_VERSION: "v#{version}"

    (share/"afm/webui").install "Resources/webui/index.html.gz"
    doc.install "README.md", "QUALIFICATION.md"
  end

  def caveats
    <<~EOS
      This is a qualified staging candidate, not a stable or nightly release.
      It conflicts with afm and afm-next because each provides `afm`.

      Switch from another AFM formula:
        brew unlink afm        # or: brew unlink afm-next
        brew install scouzi1966/afm/afm-staging

      Run an MLX model:
        afm mlx -m mlx-community/Qwen3.6-35B-A3B-4bit -w

      Review the bundled qualification report:
        #{doc}/QUALIFICATION.md
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/afm --version")
    assert_match "mlx", shell_output("#{bin}/afm --help")
  end
end
