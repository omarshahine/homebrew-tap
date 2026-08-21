class JournalCli < Formula
  desc "Read and write Apple Journal entries from the terminal"
  homepage "https://github.com/omarshahine/journal-cli"
  url "https://github.com/omarshahine/journal-cli/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "480b52cf59e45ecce33ef6415e79ecd32d0331510910b9e567f70a3478396ec8"
  license "MIT"
  head "https://github.com/omarshahine/journal-cli.git", branch: "main"

  depends_on xcode: :build
  depends_on :macos

  def install
    cd "swift" do
      # No package dependencies, so the sandboxed offline build just works.
      system "swift", "build", "--disable-sandbox", "-c", "release"
      bin.install ".build/release/journal-cli"
    end
  end

  def caveats
    <<~EOS
      journal-cli reads Journal.app's data store, which is protected by
      macOS privacy controls. Grant Full Disk Access to your terminal in:

        System Settings -> Privacy & Security -> Full Disk Access

      then verify with:  journal-cli doctor
    EOS
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/journal-cli --help")
  end
end
