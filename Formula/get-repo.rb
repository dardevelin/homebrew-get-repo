class GetRepo < Formula
  desc "CLI tool for managing git repositories across VCS providers"
  homepage "https://github.com/dardevelin/get-repo"
  url "https://github.com/dardevelin/get-repo/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "6e4fe47172c66ca200042ee227175b32a90044cdee98624d3553a4d0a91d3e88"
  license "MIT"
  head "https://github.com/dardevelin/get-repo.git", branch: "main"


  depends_on "go" => :build
  depends_on "git"

  def install
    ldflags = %W[
      -s -w
      -X get-repo/pkg/version.Version=#{version}
      -X get-repo/pkg/version.GitCommit=homebrew
      -X get-repo/pkg/version.BuildDate=#{Time.now.utc.strftime("%Y-%m-%d")}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "-o", bin/"get-repo", "./cmd/get-repo"
    
    # Generate and install shell completions
    output = Utils.safe_popen_read(bin/"get-repo", "completion", "bash")
    (bash_completion/"get-repo").write output
    
    output = Utils.safe_popen_read(bin/"get-repo", "completion", "zsh")
    (zsh_completion/"_get-repo").write output
    
    output = Utils.safe_popen_read(bin/"get-repo", "completion", "fish")
    (fish_completion/"get-repo.fish").write output
    
    # Install man page
    man1.install "docs/get-repo.1"
  end

  test do
    # Test version output
    assert_match "get-repo version 1.0.2", shell_output("#{bin}/get-repo --version")
    
    # Test help output
    assert_match "USAGE:", shell_output("#{bin}/get-repo --help")
    
    # Test that the binary runs without error
    system "#{bin}/get-repo", "list"
  end
end