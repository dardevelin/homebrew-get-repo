cask "get-repo-binary" do
  version "0.1.0"
  sha256 ""  # Will be updated with actual SHA256 of the signed binary

  url "https://github.com/dardevelin/get-repo/releases/download/v#{version}/get-repo-v#{version}-macos-universal-signed.zip"
  name "get-repo"
  desc "Pre-built binary of get-repo - CLI tool for managing git repositories"
  homepage "https://github.com/dardevelin/get-repo"

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