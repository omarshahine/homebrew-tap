class TraktCli < Formula
  desc "Track movies and TV shows via the Trakt.tv API"
  homepage "https://github.com/omarshahine/trakt-plugin"
  url "https://github.com/omarshahine/trakt-plugin/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "72849fc33a552cc0f25e3afabcc3ea67064bec1619cbae7245dbca7e59a615cf"
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
