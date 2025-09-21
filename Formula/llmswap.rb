class Llmswap < Formula
  desc "Universal AI CLI with multi-provider support, teaching features, and cost optimization"
  homepage "https://github.com/sreenathmmenon/llmswap"
  url "https://files.pythonhosted.org/packages/source/l/llmswap/llmswap-5.0.1.tar.gz"
  sha256 "c0bd878c3fdd4d486d4796111d8ef5e43d09038612af761d35c35ef717a70807"
  license "MIT"
  version "5.0.1"

  depends_on "python@3.11"

  def install
    virtualenv_create(libexec, "python3.11")
    system libexec/"bin/pip", "install", buildpath
    bin.install_symlink libexec/"bin/llmswap"
  end

  test do
    # Test version
    assert_match "5.0.1", shell_output("#{bin}/llmswap --version")
    
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