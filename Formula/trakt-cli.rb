class TraktCli < Formula
  desc "Track movies and TV shows via the Trakt.tv API"
  homepage "https://github.com/omarshahine/trakt-plugin"
  url "https://github.com/omarshahine/trakt-plugin/archive/refs/tags/v1.9.3.tar.gz"
  sha256 "223b51f62c6f6a9220ef4c177e1efe91975a30efc7bdda0ba646723e4bb114c1"
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
