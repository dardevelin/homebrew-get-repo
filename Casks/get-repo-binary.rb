cask "get-repo-binary" do
  version "1.0.4"
  sha256 "ba9deba856c66f56cb6447f2eb5a6441ff573fc910c06ebd33eebaf4a0ac70ac"

  url "https://github.com/dardevelin/get-repo/releases/download/v#{version}/get-repo-v#{version}-darwin-arm64.tar.gz"
  name "get-repo"
  desc "Pre-built binary of get-repo - CLI tool for managing git repositories (Apple Silicon only)"
  homepage "https://github.com/dardevelin/get-repo"
  
  depends_on arch: :arm64

  binary "get-repo"

  # Generate completions on install
  postflight do
    # Ensure completion directories exist
    FileUtils.mkdir_p "#{HOMEBREW_PREFIX}/etc/bash_completion.d"
    FileUtils.mkdir_p "#{HOMEBREW_PREFIX}/share/zsh/site-functions"
    FileUtils.mkdir_p "#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d"
    
    # Generate bash completion
    bash_completion = `"#{staged_path}/get-repo" completion bash`
    File.write("#{HOMEBREW_PREFIX}/etc/bash_completion.d/get-repo", bash_completion)
    
    # Generate zsh completion
    zsh_completion = `"#{staged_path}/get-repo" completion zsh`
    File.write("#{HOMEBREW_PREFIX}/share/zsh/site-functions/_get-repo", zsh_completion)
    
    # Generate fish completion
    fish_completion = `"#{staged_path}/get-repo" completion fish`
    File.write("#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/get-repo.fish", fish_completion)
  end

  # Clean up completions on uninstall
  uninstall_postflight do
    File.delete("#{HOMEBREW_PREFIX}/etc/bash_completion.d/get-repo") if File.exist?("#{HOMEBREW_PREFIX}/etc/bash_completion.d/get-repo")
    File.delete("#{HOMEBREW_PREFIX}/share/zsh/site-functions/_get-repo") if File.exist?("#{HOMEBREW_PREFIX}/share/zsh/site-functions/_get-repo")
    File.delete("#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/get-repo.fish") if File.exist?("#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/get-repo.fish")
  end
end