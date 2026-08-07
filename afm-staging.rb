class AfmStaging < Formula
  desc "Qualified AFM staging build for Apple Silicon"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/staging-20260807-7bb83c9-qualified/afm-staging-arm64.tar.gz"
  version "0.9.14-staging.7bb83c9.20260807"
  sha256 "9ce8a30cccb486271590f361f6276a62dca404b7f0a7705e4684d2dc4dde89ca"
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
    bin.write_exec_script libexec/"afm"

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
    assert_match "v0.9.14", shell_output("#{bin}/afm --version")
    assert_match "mlx", shell_output("#{bin}/afm --help")
  end
end
