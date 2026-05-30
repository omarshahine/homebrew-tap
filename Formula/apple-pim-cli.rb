class ApplePimCli < Formula
  desc "macOS Calendar, Reminders, Contacts, and Mail CLIs via EventKit"
  homepage "https://github.com/omarshahine/Apple-PIM-Agent-Plugin"
  url "https://github.com/omarshahine/Apple-PIM-Agent-Plugin/archive/refs/tags/v3.7.22.tar.gz"
  sha256 "a3da0e9da18a9c70db85668e34e4b1443b68a55486377400e687722b807e3571"
  license "MIT"
  head "https://github.com/omarshahine/Apple-PIM-Agent-Plugin.git", branch: "main"

  depends_on xcode: :build
  depends_on :macos

  # Homebrew's build sandbox blocks network, so the single SwiftPM dependency
  # is vendored and the manifest is rewritten to a local path for an offline
  # build. Pinned to the version in the upstream Package.resolved.
  resource "swift-argument-parser" do
    url "https://github.com/apple/swift-argument-parser/archive/refs/tags/1.7.0.tar.gz"
    sha256 "84e685f0ca4d069a60193c9e477b6ec5a44016dc789db01e0b17c38b400a922e"
  end

  def install
    cd "swift" do
      resource("swift-argument-parser").stage(buildpath/"swift/vendor/swift-argument-parser")
      inreplace "Package.swift",
                '.package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0"),',
                '.package(path: "vendor/swift-argument-parser"),'
      system "swift", "build", "--disable-sandbox", "-c", "release"
      %w[calendar-cli reminder-cli contacts-cli mail-cli].each do |exe|
        bin.install ".build/release/#{exe}"
      end
    end
  end

  def caveats
    <<~EOS
      The apple-pim CLIs use EventKit, Contacts, and Mail. macOS will prompt
      for TCC permissions (Calendars, Reminders, Contacts, Automation) the
      first time each command runs. Grant access in:

        System Settings -> Privacy & Security
    EOS
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/calendar-cli --help")
  end
end
