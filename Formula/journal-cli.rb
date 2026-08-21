class JournalCli < Formula
  desc "Read and write Apple Journal entries from the terminal"
  homepage "https://github.com/omarshahine/journal-cli"
  url "https://github.com/omarshahine/journal-cli/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "8afa9dc5d5ec2da53052a1fe50d49b82fe7f2fd063ab168c19799edb949645bc"
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
