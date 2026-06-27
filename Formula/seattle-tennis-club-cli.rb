# Private member CLI for Seattle Tennis Club. Works only with your own STC login.
class SeattleTennisClubCli < Formula
  desc "Book Seattle Tennis Club courts, beach, pickleball, and dining (member CLI)"
  homepage "https://www.seattletennisclub.org"
  version "1.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://pub-b509d0d53df7451ebe3d16c9d1653fd3.r2.dev/seattle-tennis-club-cli_1.0.0_macos-arm64.tar.gz"
      sha256 "9cb6f6de0d1f7cdf63a5f876800bec5accd1e9813520303980dfc65a880e9987"
    end
    on_intel do
      url "https://pub-b509d0d53df7451ebe3d16c9d1653fd3.r2.dev/seattle-tennis-club-cli_1.0.0_macos-intel.tar.gz"
      sha256 "16fdde2f52771eacf12daff43749f8ad3c8fde5e7acfd83aaaf768f3ba8bb93c"
    end
  end

  on_linux do
    on_arm do
      url "https://pub-b509d0d53df7451ebe3d16c9d1653fd3.r2.dev/seattle-tennis-club-cli_1.0.0_linux-arm64.tar.gz"
      sha256 "385e728bdfd9667b40c3885fcbf0d8b03b88c14e84430746766533004ea0e65c"
    end
    on_intel do
      url "https://pub-b509d0d53df7451ebe3d16c9d1653fd3.r2.dev/seattle-tennis-club-cli_1.0.0_linux-amd64.tar.gz"
      sha256 "f386f0b4c5c4a3138d1fa7579966083033c4e6364f8ccead4aa28f9fa5ba639c"
    end
  end

  def install
    bin.install "seattle-tennis-club-pp-cli"
  end

  test do
    assert_match "seattle-tennis-club-pp-cli", shell_output("#{bin}/seattle-tennis-club-pp-cli --version")
  end
end
