# homebrew-get-repo

Homebrew tap for get-repo - a CLI tool for managing git repositories across VCS providers.

## Installation Options

### Option 1: Build from source (recommended)

```bash
brew tap dardevelin/get-repo
brew install get-repo
```

This builds get-repo from source on your machine.

### Option 2: Pre-built signed binary (macOS only)

```bash
brew tap dardevelin/get-repo
brew install --cask get-repo-binary
```

This installs the pre-built, signed and notarized macOS binary.

## Usage

After installation, you can use get-repo:

```bash
# List repositories
get-repo list

# Clone a repository
get-repo clone https://github.com/user/repo

# Update repositories
get-repo update github.com/user/repo

# Interactive mode
get-repo
```

## Development

To install the latest development version:

```bash
brew install --HEAD dardevelin/get-repo/get-repo
```

## License

MIT License - see the [get-repo repository](https://github.com/dardevelin/get-repo) for details.