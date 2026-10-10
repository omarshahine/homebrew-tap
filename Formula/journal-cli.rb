class JournalCli < Formula
  desc "Read and write Apple Journal entries from the terminal"
  homepage "https://github.com/omarshahine/apple-journal-cli"
  url "https://github.com/omarshahine/apple-journal-cli/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "6cd7deff66f4a52a35ccb0cf55783d422dca49e59b91e5b6e5e6dbb98d922256"
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
