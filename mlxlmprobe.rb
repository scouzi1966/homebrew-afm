class Mlxlmprobe < Formula
  desc "Visual probing and interpretability tool for MLX language models"
  homepage "https://github.com/scouzi1966/MLXLMProbe"
  url "https://files.pythonhosted.org/packages/37/89/c7244a522292442ea21929a8834768ec078281f7662d7fc408a0fc76a1f9/mlxlmprobe-0.1.1.tar.gz"
  sha256 "c448d5b3e87682205718119e6c84a029ee4690f3f7c842ab36381f8ac5232d2e"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "python@3.12"

  def install
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-m", "venv", libexec
    system libexec/"bin/python", "-m", "ensurepip", "--upgrade"
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "mlxlmprobe==0.1.1"
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
