class TraktCli < Formula
  desc "Track movies and TV shows via the Trakt.tv API"
  homepage "https://github.com/omarshahine/trakt-plugin"
  url "https://github.com/omarshahine/trakt-plugin/archive/refs/tags/v1.12.3.tar.gz"
  sha256 "beb551c296469572d0bd6bafe3964679c682d2589408b704101abfdd31480115"
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
