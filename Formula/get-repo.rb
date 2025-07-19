class GetRepo < Formula
  desc "CLI tool for managing git repositories across VCS providers"
  homepage "https://github.com/dardevelin/get-repo"
  url "https://github.com/dardevelin/get-repo/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "84c5484489af7ae9f3c7934324bdb549d15ede073f5bb9ce503ce90c27e96b18"
  license "MIT"
  head "https://github.com/dardevelin/get-repo.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "45e9053a08238b16e107e4e60b00c5700827747218581a518229cb0ca46a732a"
    sha256 cellar: :any_skip_relocation, ventura:      "e71c6a260e3b2e1220c62a58463139ac1be1a5601b20bd93118b6392a12e6d33"
  end

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
    assert_match "get-repo version 1.0.0", shell_output("#{bin}/get-repo --version")
    
    # Test help output
    assert_match "USAGE:", shell_output("#{bin}/get-repo --help")
    
    # Test that the binary runs without error
    system "#{bin}/get-repo", "list"
  end
end