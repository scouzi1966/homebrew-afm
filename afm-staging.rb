class AfmStaging < Formula
  desc "Qualified AFM staging build for Apple Silicon"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/staging-20260808-ff2dde5/afm-staging-arm64.tar.gz"
  version "0.9.15-staging.ff2dde5.20260808"
  sha256 "e42b8942bfaac182fb0a184d242ceb61405609d5b795cb29d8eb8adcbba3538f"
  license "MIT"
  version_scheme 1

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
