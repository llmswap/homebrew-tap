class Llmswap < Formula
  include Language::Python::Virtualenv

  desc "cURL for LLMs - Universal AI SDK + CLI with multiple second brains and workspace memory"
  homepage "https://github.com/sreenathmmenon/llmswap"
  url "https://files.pythonhosted.org/packages/2b/8c/26e75f1d69b3e700ca556ce91edf7c0c77695e1e04efd9440abc3f05de3e/llmswap-5.2.0.tar.gz"
  sha256 "eb2a6f054b521fa776be494a3ea57acf8f0289354ae6a9bfcbe699a7ce6802b6"
  license "MIT"
  version "5.2.0"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources using: "python@3.11"
  end

  test do
    # Test version
    assert_match "5.2.0", shell_output("#{bin}/llmswap --version")
    
    # Test help command
    help_output = shell_output("#{bin}/llmswap --help")
    assert_match "Universal AI CLI", help_output
    assert_match "conversational", help_output
    
    # Test config functionality (should work without API keys)
    config_output = shell_output("#{bin}/llmswap config show 2>&1", 0)
    assert_match "provider:", config_output
    
    # Test cost comparison (should work without API keys)
    compare_output = shell_output("#{bin}/llmswap compare --input-tokens 100 --output-tokens 50")
    assert_match "Provider Cost Comparison", compare_output
  end
end