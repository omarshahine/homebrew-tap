class TraktCli < Formula
  desc "Track movies and TV shows via the Trakt.tv API"
  homepage "https://github.com/omarshahine/trakt-plugin"
  url "https://github.com/omarshahine/trakt-plugin/archive/refs/tags/v1.9.5.tar.gz"
  sha256 "a4507ae6c52d87499cdebd0495d969dad434a4be0e7f6e74af4d2a4480f28eca"
  license "MIT"
  head "https://github.com/omarshahine/trakt-plugin.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"trakt-cli", ldflags: "-s -w")
  end

  test do
    assert_match "trakt", shell_output("#{bin}/trakt-cli --help")
  end
end
