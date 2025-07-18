#!/bin/bash

# Script to update the get-repo formula with a new version

if [ $# -ne 2 ]; then
    echo "Usage: $0 <version> <sha256>"
    echo "Example: $0 0.1.0 abc123def456..."
    exit 1
fi

VERSION=$1
SHA256=$2

# Update the formula
sed -i '' "s|url \".*\"|url \"https://github.com/dardevelin/get-repo/archive/refs/tags/v${VERSION}.tar.gz\"|" Formula/get-repo.rb
sed -i '' "s|sha256 \".*\"|sha256 \"${SHA256}\"|" Formula/get-repo.rb

echo "Formula updated to version ${VERSION} with SHA256 ${SHA256}"
echo "Don't forget to:"
echo "1. Test the formula locally: brew install --build-from-source Formula/get-repo.rb"
echo "2. Commit and push the changes"
echo "3. Create a new release on GitHub if not already done"