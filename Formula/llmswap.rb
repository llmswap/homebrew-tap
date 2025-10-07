class Llmswap < Formula
  include Language::Python::Virtualenv

  desc "cURL for LLMs - Universal AI SDK + CLI with multiple second brains and workspace memory"
  homepage "https://github.com/sreenathmmenon/llmswap"
  url "https://files.pythonhosted.org/packages/32/6a/b74ed561893624493583348d7fb892b629df36cfa5642fee8fcf95a397bd/llmswap-5.1.6.tar.gz"
  sha256 "bffb62ee6a71483ac99e4be4b3549ea1c32710da3a541ac86414a90bffd516fb"
  license "MIT"
  version "5.1.6"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources using: "python@3.11"

    # Install all extras to include web features and all providers
    system libexec/"bin/pip", "install", "--no-deps", "flask>=3.0.0", "flask-cors>=4.0.0", "ibm-watsonx-ai>=0.0.5"
  end

  test do
    # Test version
    assert_match "5.1.6", shell_output("#{bin}/llmswap --version")
    
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