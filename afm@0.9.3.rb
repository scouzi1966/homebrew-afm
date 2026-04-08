class AfmAT093 < Formula
  desc "Apple Foundation Models + MLX local models — OpenAI-compatible API, WebUI, all Swift (pinned v0.9.3)"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/v0.9.3/afm-v0.9.3-arm64.tar.gz"
  version "0.9.3"
  sha256 "40959f35f9d237e2571a54b2d55aa1ea834a7a1faaad594b1ea9b9624bdd226c"

  depends_on arch: :arm64
  depends_on :macos

  conflicts_with "afm", because: "both install an `afm` binary"
  conflicts_with "afm-next", because: "both install an `afm` binary"

  def install
    bin.install "afm"
    if File.directory?("MacLocalAPI_MacLocalAPI.bundle")
      (libexec/"MacLocalAPI_MacLocalAPI.bundle").install Dir["MacLocalAPI_MacLocalAPI.bundle/*"]
    end
    if File.exist?("Resources/webui/index.html.gz")
      (share/"afm/webui").install "Resources/webui/index.html.gz"
    end
  end

  def post_install
    bundle_src = libexec/"MacLocalAPI_MacLocalAPI.bundle"
    bundle_dst = HOMEBREW_PREFIX/"bin/MacLocalAPI_MacLocalAPI.bundle"
    bundle_dst.unlink if bundle_dst.symlink? || bundle_dst.exist?
    bundle_dst.make_symlink(bundle_src) if bundle_src.exist?
  end

  def caveats
    <<~EOS
      This is a pinned historical release of afm (v0.9.3).
      For the latest stable: brew install scouzi1966/afm/afm
      For the latest nightly: brew install scouzi1966/afm/afm-next
    EOS
  end

  test do
    assert_match "afm", shell_output("#{bin}/afm --version")
  end
end
