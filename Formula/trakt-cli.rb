class TraktCli < Formula
  desc "Track movies and TV shows via the Trakt.tv API"
  homepage "https://github.com/omarshahine/trakt-plugin"
  url "https://github.com/omarshahine/trakt-plugin/archive/refs/tags/v1.12.1.tar.gz"
  sha256 "75d2afdf0f377340053c2ab510dcc6f42f9775f23ee1bf7f02eae347e660d399"
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
