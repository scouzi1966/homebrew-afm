class AfmNextAT0913NextA92a0fe20260614 < Formula
  desc "AFM next — OpenAI-compatible local LLM API (pinned nightly 20260614)"
  homepage "https://github.com/scouzi1966/maclocal-api"
  url "https://github.com/scouzi1966/maclocal-api/releases/download/nightly-20260614-a92a0fe/afm-next-arm64.tar.gz"
  version "0.9.13-next.a92a0fe.20260614"
  sha256 "30e3e947d7a56053951f60b752ab6ad6142fb98120fd8a2b2eb00a94d6bd1b3c"

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
      This is a pinned historical nightly (20260614).
      For the latest nightly: brew install scouzi1966/afm/afm-next
      For the latest stable:  brew install scouzi1966/afm/afm
    EOS
  end

  test do
    assert_match "afm", shell_output("#{bin}/afm --version")
  end
end
