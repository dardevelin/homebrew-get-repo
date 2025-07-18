# homebrew-get-repo

Homebrew tap for get-repo - a CLI tool for managing git repositories across VCS providers.

## Installation

```bash
brew tap dardevelin/get-repo
brew install get-repo
```

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