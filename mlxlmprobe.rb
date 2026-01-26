class Mlxlmprobe < Formula
  include Language::Python::Virtualenv

  desc "Visual probing and interpretability tool for MLX language models"
  homepage "https://github.com/scouzi1966/MLXLMProbe"
  url "https://files.pythonhosted.org/packages/b8/6e/3655162eddaf663701afbd3f39b1067b8be521e7d6f7b29bca9cb22739f5/mlxlmprobe-0.1.0.tar.gz"
  sha256 "dc44dd8d4fdaca2ac1aa87fe74894cc42323d66fbbb737349176d94068d831a9"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "python@3.12"

  def install
    virtualenv_create(libexec, "python3.12")
    system libexec/"bin/pip", "install", "mlxlmprobe==0.1.0"
    (bin/"mlxlmprobe").write_env_script libexec/"bin/mlxlmprobe", PATH: "#{libexec}/bin:$PATH"
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
