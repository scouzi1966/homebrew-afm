class AfmStaging < Formula
  desc "Qualified AFM staging build for Apple Silicon"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/nightly-20260908-97a9acf/rc-0.9.19-97a9acf.tar.gz"
  version "0.9.19-next.20260908.97a9acf"
  sha256 "42737d24bfb2c827a412743c335373ebdb8486584d0add4033efa8f112dbee56"
  license "MIT"
  version_scheme 1

  depends_on arch: :arm64
  depends_on macos: :tahoe

  conflicts_with "afm", "afm-next", because: "all three install an `afm` executable"

  def install
    # Keep the executable beside its SwiftPM resource bundles. The wrapper in
    # bin executes this binary without depending on global bundle symlinks.
    libexec.install "afm"
    libexec.install "MacLocalAPI_AFMEvaluationHost.bundle"
    libexec.install "AFMKit_AFMKitMLX.bundle"
    libexec.install "AFMKit_AFMKitDwarfStar.bundle"
    (bin/"afm").write_env_script libexec/"afm", AFM_BUILD_VERSION: "v0.9.19-next.20260908.97a9acf"

    if File.exist?("Resources/webui/index.html")
      (share/"afm/webui").install Dir["Resources/webui/*"]
    end
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      This is a build-qualified staging candidate, not a stable release.
      Full model qualification is in progress; see the release and retained
      qualification evidence for this exact version.
      It conflicts with afm and afm-next because each provides `afm`.

      Switch from another AFM formula:
        brew unlink afm        # or: brew unlink afm-next
        brew install scouzi1966/afm/afm-staging

      Run an MLX model:
        afm mlx -m mlx-community/Qwen3.6-35B-A3B-4bit -w

      Release and retained qualification evidence:
        https://github.com/scouzi1966/maclocal-api/releases/tag/nightly-20260908-97a9acf
    EOS
  end

  test do
    assert_match "v0.9.19-next.20260908.97a9acf", shell_output("#{bin}/afm --version")
    assert_match "mlx", shell_output("#{bin}/afm --help")
    assert_path_exists share/"afm/webui/index.html"
  end
end
