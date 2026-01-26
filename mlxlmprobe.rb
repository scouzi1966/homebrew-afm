class Mlxlmprobe < Formula
  desc "Visual probing and interpretability tool for MLX language models"
  homepage "https://github.com/scouzi1966/MLXLMProbe"
  url "https://files.pythonhosted.org/packages/5c/15/9061766150faf70681f9bd6ae0955d7f904147db0bf2c4be908789aabe62/mlxlmprobe-0.1.2.tar.gz"
  sha256 "aca8737ea8a1e76e466d0f06a99fb30336c04aa4ddc3552d700ec31561e83056"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "python@3.12"

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-m", "venv", libexec
    system libexec/"bin/python", "-m", "ensurepip", "--upgrade"
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "mlxlmprobe==0.1.2"
    (bin/"mlxlmprobe").write_env_script libexec/"bin/mlxlmprobe", PATH: "#{libexec}/bin:$PATH"
  end

  def caveats
    <<~EOS
      MLXLMProbe requires Apple Silicon (M1/M2/M3/M4 series).

      Usage:
        mlxlmprobe                              # Launch Streamlit UI in browser
    EOS
  end

  test do
    assert_match "streamlit", shell_output("#{bin}/mlxlmprobe --help 2>&1")
  end
end
