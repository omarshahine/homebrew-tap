class FindmyCli < Formula
  desc "Query Find My friend locations via macOS FindMy.app UI scraping"
  homepage "https://github.com/omarshahine/findmy-cli"
  url "https://github.com/omarshahine/findmy-cli/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "293f26d713791008d00069128109991a5bbf972d7ca79a9743f2de43ce23bdc5"
  license "MIT"
  head "https://github.com/omarshahine/findmy-cli.git", branch: "main"

  depends_on "go" => :build
  depends_on xcode: :build
  depends_on :macos

  def install
    system "make", "build"
    bin.install "bin/findmy"
    bin.install "bin/findmy-helper"
  end

  def caveats
    <<~EOS
      findmy drives FindMy.app via screen capture, OCR, and synthesized
      clicks. macOS will prompt for two TCC permissions the first time you
      run it — grant both to the installed helper at:

        #{opt_bin}/findmy-helper

      Required permissions:
        • Screen Recording  (System Settings → Privacy & Security)
        • Accessibility     (System Settings → Privacy & Security)

      If you ever `brew uninstall` and reinstall, you'll need to re-grant
      these (TCC is path-bound and the entry is cleared on uninstall).
    EOS
  end

  test do
    assert_match "findmy", shell_output("#{bin}/findmy 2>&1", 1)
    assert_predicate bin/"findmy-helper", :executable?
  end
end
