class Llmswap < Formula
  include Language::Python::Virtualenv

  desc "cURL for LLMs - Universal AI SDK + CLI with multiple second brains and workspace memory"
  homepage "https://github.com/sreenathmmenon/llmswap"
  url "https://files.pythonhosted.org/packages/source/l/llmswap/llmswap-5.1.0.tar.gz"
  sha256 "a2acdaa43395182cf41754a97103324415936d92cf0daab59a6761d2ed395690"
  license "MIT"
  version "5.1.0"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Test version
    assert_match "5.1.0", shell_output("#{bin}/llmswap --version")
    
    # Test help command
    help_output = shell_output("#{bin}/llmswap --help")
    assert_match "Universal AI CLI", help_output
    assert_match "conversational", help_output
    
    # Test config functionality (should work without API keys)
    config_output = shell_output("#{bin}/llmswap config show 2>&1", 0)
    assert_match "provider:", config_output
    
    # Test cost comparison (should work without API keys)
    costs_output = shell_output("#{bin}/llmswap costs --input-tokens 100 --output-tokens 50")
    assert_match "Provider Cost Comparison", costs_output
    assert_match "estimated", costs_output
  end
end