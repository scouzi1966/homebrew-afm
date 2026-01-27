class Mlxlmprobe < Formula
  include Language::Python::Virtualenv

  desc "Visual probing and interpretability tool for MLX language models"
  homepage "https://github.com/scouzi1966/MLXLMProbe"
  url "https://files.pythonhosted.org/packages/e9/b4/493925e0932ebe91498465eaf148f4a843e9926d7af5a5266154b715d38a/mlxlmprobe-0.1.4.tar.gz"
  sha256 "c1427f0d00143deaa43af8266308bedd074a0970257a1c968fc44f3ea739a1e3"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      MLXLMProbe requires Apple Silicon (M1/M2/M3/M4 series).

      Usage:
        mlxlmprobe                              # Launch Streamlit UI in browser
        mlxlmprobe --help                       # Show Streamlit help

      The tool provides:
        - Attention pattern analysis
        - MoE expert routing visualization
        - Token probability analysis
        - RoPE position encoding visualization
        - Residual stream analysis
        - PDF report export
    EOS
  end

  test do
    assert_match "mlxlmprobe", shell_output("#{bin}/mlxlmprobe --help 2>&1", 0)
  end
end
