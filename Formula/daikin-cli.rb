class DaikinCli < Formula
  desc "Control Daikin One+ smart thermostats"
  homepage "https://github.com/omarshahine/daikin-cli"
  url "https://github.com/omarshahine/daikin-cli/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "7413a6e7f76c7ae40350721ce284788f77c5c339edb585f1ce97cd273f457e7d"
  license "MIT"
  head "https://github.com/omarshahine/daikin-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"daikin-cli", ldflags: "-s -w")
  end

  test do
    assert_match "Daikin", shell_output("#{bin}/daikin-cli --help")
  end
end
