class Mlxlmprobe < Formula
  include Language::Python::Virtualenv

  desc "Visual probing and interpretability tool for MLX language models"
  homepage "https://github.com/scouzi1966/MLXLMProbe"
  url "https://files.pythonhosted.org/packages/8c/eb/be88eed75a0fa2a49b9ca423376d8ad41d80a0fbd64df7b4f8d4e9082ce4/mlxlmprobe-0.1.5.tar.gz"
  sha256 "037a2ff57c59d8e7eed74f03e30163a6b6a88b32302fc66878be32e522a462b5"
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
