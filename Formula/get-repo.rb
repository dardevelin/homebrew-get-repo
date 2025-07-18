class GetRepo < Formula
  desc "CLI tool for managing git repositories across VCS providers"
  homepage "https://github.com/dardevelin/get-repo"
  url "https://github.com/dardevelin/get-repo/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4c583de7bbf0616d78b4edaae50489c5113bcd81a1545f303358de05d1b0b9f1"
  license "MIT"
  head "https://github.com/dardevelin/get-repo.git", branch: "main"

  depends_on "go" => :build
  depends_on "git"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/"get-repo", "./cmd/get-repo"
    
    # Generate and install shell completions
    output = Utils.safe_popen_read(bin/"get-repo", "completion", "bash")
    (bash_completion/"get-repo").write output
    
    output = Utils.safe_popen_read(bin/"get-repo", "completion", "zsh")
    (zsh_completion/"_get-repo").write output
    
    output = Utils.safe_popen_read(bin/"get-repo", "completion", "fish")
    (fish_completion/"get-repo.fish").write output
  end

  test do
    # Test version output
    assert_match "get-repo", shell_output("#{bin}/get-repo --version", 2)
    
    # Test help output
    assert_match "USAGE:", shell_output("#{bin}/get-repo --help")
    
    # Test that the binary runs without error
    system "#{bin}/get-repo", "list"
  end
end