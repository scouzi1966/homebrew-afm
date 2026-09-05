class AfmStaging < Formula
  desc "Qualified AFM staging build for Apple Silicon"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/nightly-20260905-4f6d449/afm-staging-arm64.tar.gz"
  version "0.9.18-next.20260905.4f6d449"
  sha256 "15f05dd987d32ddddc9fb18edc025f1a377579d34ab97cfe6653344dbc8823a3"
  license "MIT"
  version_scheme 1

  depends_on arch: :arm64
  depends_on macos: :tahoe

  conflicts_with "afm", "afm-next", because: "all three install an `afm` executable"

  def install
    # Keep the executable beside its SwiftPM resource bundles. The wrapper in
    # bin executes this binary without depending on global bundle symlinks.
    libexec.install "afm"
    libexec.install "afm-qualified.tar.gz"
    libexec.install "MacLocalAPI_AFMEvaluationHost.bundle"
    libexec.install "AFMKit_AFMKitMLX.bundle"
    libexec.install "AFMKit_AFMKitDwarfStar.bundle"
    (bin/"afm").write_env_script libexec/"afm", AFM_BUILD_VERSION: "v0.9.18-next.20260905.4f6d449"

    (share/"afm/webui").install "Resources/webui/index.html.gz"
    doc.install "README.md", "QUALIFICATION.md"
  end

  def post_install
    # Homebrew normalizes Mach-O rpaths during installation. Restore the exact
    # executable that passed qualification after Homebrew's relocation phase.
    system "tar", "-xzf", libexec/"afm-qualified.tar.gz", "-C", libexec
  end

  def caveats
    <<~EOS
      This is a build-qualified staging candidate, not a stable release.
      Full model qualification is in progress; see QUALIFICATION.md.
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
    assert_match "v0.9.18-next.20260905.4f6d449", shell_output("#{bin}/afm --version")
    assert_match "mlx", shell_output("#{bin}/afm --help")
  end
end
