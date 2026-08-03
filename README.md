# LLMSwap Homebrew tap

Official Homebrew tap for [LLMSwap](https://github.com/sreenathmmenon/llmswap):
one interface for every LLM and one optional, cross-checked Best Answer.

LLMSwap supports OpenAI, Anthropic, Gemini, Cohere, Perplexity, IBM watsonx,
Groq, Ollama, xAI, and Sarvam through a shared Python SDK and CLI.

## Install

```bash
brew tap llmswap/tap
brew install llmswap
llmswap --version
llmswap doctor
```

Upgrade an existing installation:

```bash
brew update
brew upgrade llmswap
```

## Configure a provider

Export at least one provider key:

```bash
export OPENAI_API_KEY="your-key"
# or ANTHROPIC_API_KEY, GEMINI_API_KEY, GROQ_API_KEY, XAI_API_KEY,
# COHERE_API_KEY, PERPLEXITY_API_KEY, SARVAM_API_KEY, or WATSONX_API_KEY
```

Then check readiness:

```bash
llmswap doctor
llmswap providers
```

## Use LLMSwap

```bash
# Ask one model
llmswap --provider openai ask "Explain this proposal in plain language"

# Continue a conversation
llmswap --provider openai chat

# Synthesize three independent drafts into one cross-checked answer
llmswap --provider openai best \
  "Which rollout plan has the lowest operational risk?"

# Machine-readable Best Answer
llmswap --provider openai best "Assess this decision" --format json
```

Same-provider Best Answer is the default. A flow that sends candidate output to
a different judge provider is blocked unless
`--allow-cross-provider-sharing` is explicitly supplied.

## MCP

Connect to a trusted local stdio MCP server:

```bash
llmswap mcp --provider openai --command \
  npx -y @modelcontextprotocol/server-filesystem "$HOME/Documents"
```

Local stdio is the verified MCP transport. MCP servers run with the permissions
of your process, so grant only the filesystem and network access they need.

## Browser Arena

The Homebrew formula installs the core CLI. To use the optional local browser
Arena, install the web extra with pip or uv:

```bash
python -m pip install "llmswap[web]==5.7.0"
llmswap web
```

## Links

- [Main repository](https://github.com/sreenathmmenon/llmswap)
- [PyPI package](https://pypi.org/project/llmswap/)
- [5.7.0 release](https://github.com/sreenathmmenon/llmswap/releases/tag/v5.7.0)
- [Provider and model support](https://github.com/sreenathmmenon/llmswap/blob/main/MODEL_SUPPORT.md)
- [Security and data flow](https://github.com/sreenathmmenon/llmswap/blob/main/SECURITY.md)
- [Issues](https://github.com/sreenathmmenon/llmswap/issues)

LLMSwap is open source under the MIT License.
