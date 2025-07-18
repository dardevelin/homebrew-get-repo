cask "get-repo-binary" do
  version "0.1.0"
  sha256 "4118feb4aaa51c61619b783c7af805771e7b0f95fa70ff97f17e089d550857ca"

  url "https://github.com/dardevelin/get-repo/releases/download/v#{version}/get-repo-v#{version}-macos-arm64-signed.zip"
  name "get-repo"
  desc "Pre-built binary of get-repo - CLI tool for managing git repositories (Apple Silicon only)"
  homepage "https://github.com/dardevelin/get-repo"
  
  depends_on arch: :arm64

  binary "get-repo"

  # Generate completions on install
  postflight do
    system_command "#{staged_path}/get-repo",
                   args: ["completion", "bash"],
                   print_stdout: false,
                   must_succeed: true,
                   sudo: false,
                   pipe_to: "#{HOMEBREW_PREFIX}/etc/bash_completion.d/get-repo"

    system_command "#{staged_path}/get-repo",
                   args: ["completion", "zsh"],
                   print_stdout: false,
                   must_succeed: true,
                   sudo: false,
                   pipe_to: "#{HOMEBREW_PREFIX}/share/zsh/site-functions/_get-repo"

    system_command "#{staged_path}/get-repo",
                   args: ["completion", "fish"],
                   print_stdout: false,
                   must_succeed: true,
                   sudo: false,
                   pipe_to: "#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/get-repo.fish"
  end

  # Clean up completions on uninstall
  uninstall_postflight do
    File.delete("#{HOMEBREW_PREFIX}/etc/bash_completion.d/get-repo") if File.exist?("#{HOMEBREW_PREFIX}/etc/bash_completion.d/get-repo")
    File.delete("#{HOMEBREW_PREFIX}/share/zsh/site-functions/_get-repo") if File.exist?("#{HOMEBREW_PREFIX}/share/zsh/site-functions/_get-repo")
    File.delete("#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/get-repo.fish") if File.exist?("#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/get-repo.fish")
  end
end