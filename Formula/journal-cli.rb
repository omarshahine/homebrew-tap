class JournalCli < Formula
  desc "Read and write Apple Journal entries from the terminal"
  homepage "https://github.com/omarshahine/apple-journal-cli"
  url "https://github.com/omarshahine/apple-journal-cli/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "0513cc817e4eeee31d436bd05ff639e26bc564cc734cf3a1228d6775bed45b13"
  license "MIT"
  head "https://github.com/omarshahine/apple-journal-cli.git", branch: "main"

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
