#!/bin/bash

# Script to prepare a new release of get-repo

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <version> <signed-binary-path>"
    echo "Example: $0 0.1.0 ~/get-repo/dist/get-repo-macos-signed.zip"
    exit 1
fi

VERSION=$1
BINARY_PATH=$2
BINARY_NAME="get-repo-v${VERSION}-macos-universal-signed.zip"

echo "Preparing release for get-repo v${VERSION}..."

# Check if binary exists
if [ ! -f "$BINARY_PATH" ]; then
    echo "Error: Binary not found at $BINARY_PATH"
    exit 1
fi

# Calculate SHA256 for the signed binary
echo "Calculating SHA256 for signed binary..."
BINARY_SHA256=$(shasum -a 256 "$BINARY_PATH" | cut -d' ' -f1)
echo "Binary SHA256: $BINARY_SHA256"

# Calculate SHA256 for source tarball (will be created by GitHub)
echo "Calculating SHA256 for source tarball..."
SOURCE_URL="https://github.com/dardevelin/get-repo/archive/refs/tags/v${VERSION}.tar.gz"
echo "Downloading source tarball from $SOURCE_URL..."
SOURCE_SHA256=$(curl -sL "$SOURCE_URL" | shasum -a 256 | cut -d' ' -f1)
echo "Source SHA256: $SOURCE_SHA256"

# Update Formula
echo "Updating Formula/get-repo.rb..."
sed -i '' "s|url \".*\"|url \"${SOURCE_URL}\"|" Formula/get-repo.rb
sed -i '' "s|sha256 \".*\" *# This will.*|sha256 \"${SOURCE_SHA256}\"|" Formula/get-repo.rb

# Update Cask
echo "Updating Casks/get-repo-binary.rb..."
sed -i '' "s|version \".*\"|version \"${VERSION}\"|" Casks/get-repo-binary.rb
sed -i '' "s|sha256 \".*\" *# Will be.*|sha256 \"${BINARY_SHA256}\"|" Casks/get-repo-binary.rb

echo
echo "✅ Formulas updated!"
echo
echo "Next steps:"
echo "1. Copy the signed binary to GitHub releases as: $BINARY_NAME"
echo "2. Test the formulas locally:"
echo "   brew install --build-from-source Formula/get-repo.rb"
echo "   brew install --cask Casks/get-repo-binary.rb"
echo "3. Commit and push the changes"
echo
echo "GitHub Release notes template:"
echo "---"
echo "## Installation"
echo
echo "### Homebrew (build from source)"
echo '```bash'
echo "brew tap dardevelin/get-repo"
echo "brew install get-repo"
echo '```'
echo
echo "### Homebrew (pre-built binary)"
echo '```bash'
echo "brew tap dardevelin/get-repo"
echo "brew install --cask get-repo-binary"
echo '```'
echo
echo "### Direct download"
echo "Download the signed binary: \`${BINARY_NAME}\`"
echo
echo "### Verify checksums"
echo "- Signed binary SHA256: \`${BINARY_SHA256}\`"
echo "- Source tarball SHA256: \`${SOURCE_SHA256}\`"