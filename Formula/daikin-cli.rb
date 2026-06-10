class DaikinCli < Formula
  desc "Control Daikin One+ smart thermostats"
  homepage "https://github.com/omarshahine/daikin-cli"
  url "https://github.com/omarshahine/daikin-cli/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "dea072673e6626cc33d9637cf12ba5e99b69652ad5d98818cd01f2570b09fcd1"
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
