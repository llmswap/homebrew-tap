# Contributing to llmswap Homebrew Tap

Thank you for your interest in contributing to the llmswap Homebrew tap!

## Formula Updates

### When llmswap releases a new version:

1. **Update the formula** (`Formula/llmswap.rb`):
   ```ruby
   url "https://files.pythonhosted.org/packages/source/l/llmswap/llmswap-X.Y.Z.tar.gz"
   sha256 "new_sha256_hash"
   version "X.Y.Z"
   ```

2. **Get the new SHA256 hash**:
   ```bash
   curl -s https://pypi.org/pypi/llmswap/X.Y.Z/json | \
     jq -r '.urls[] | select(.packagetype=="sdist") | .digests.sha256'
   ```

3. **Test locally**:
   ```bash
   brew install --build-from-source Formula/llmswap.rb
   llmswap --version  # Should show X.Y.Z
   brew test llmswap
   brew uninstall llmswap
   ```

4. **Submit PR** with clear description of changes

### Dependency Updates

If llmswap adds new Python dependencies, update the `resource` blocks:

1. **Find the new dependency** in llmswap's `pyproject.toml`
2. **Get PyPI information**:
   ```bash
   curl -s https://pypi.org/pypi/PACKAGE_NAME/VERSION/json
   ```
3. **Add resource block**:
   ```ruby
   resource "package-name" do
     url "https://files.pythonhosted.org/packages/source/p/package-name/package_name-X.Y.Z.tar.gz"
     sha256 "sha256_hash"
   end
   ```

## Testing

### Local Testing
```bash
# Syntax check
brew audit --formula Formula/llmswap.rb

# Installation test
brew install --build-from-source Formula/llmswap.rb

# Functionality test
llmswap --help
llmswap config show
llmswap costs --input-tokens 100 --output-tokens 50

# Formula test
brew test llmswap

# Cleanup
brew uninstall llmswap
```

### CI Testing
- All PRs are automatically tested on macOS and Ubuntu
- Tests include syntax validation, installation, functionality, and cleanup

## Guidelines

### Formula Standards
- Follow [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- Use `virtualenv_install_with_resources` for Python packages
- Include comprehensive tests in the `test do` block
- Ensure all dependencies have correct SHA256 hashes

### Commit Messages
```
Update llmswap to X.Y.Z

- Update version from A.B.C to X.Y.Z
- Update SHA256 hash
- Add new dependency: package-name
```

### PR Requirements
- [ ] Formula syntax is valid (`brew audit` passes)
- [ ] Local installation test passes
- [ ] All tests pass (`brew test llmswap`)
- [ ] CI tests pass on macOS and Ubuntu
- [ ] Version number is correct
- [ ] SHA256 hash matches PyPI

## Release Process

This tap tracks releases from the main llmswap repository:
- **Main repo**: [github.com/sreenathmmenon/llmswap](https://github.com/sreenathmmenon/llmswap)
- **PyPI releases**: [pypi.org/project/llmswap](https://pypi.org/project/llmswap/)

### Typical workflow:
1. New version released to PyPI
2. Update this tap's formula
3. Test and submit PR
4. Merge after CI passes

## Getting Help

- **Homebrew docs**: [docs.brew.sh](https://docs.brew.sh/)
- **Formula issues**: Create issue in this repository
- **llmswap issues**: Create issue in [main repository](https://github.com/sreenathmmenon/llmswap/issues)
- **Homebrew community**: [discourse.brew.sh](https://discourse.brew.sh/)

## License

This tap is licensed under the same terms as llmswap (MIT License).