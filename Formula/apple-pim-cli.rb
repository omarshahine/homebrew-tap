class ApplePimCli < Formula
  desc "macOS Calendar, Reminders, Contacts, and Mail CLIs via EventKit"
  homepage "https://github.com/omarshahine/apple-pim"
  # Prebuilt, Developer ID signed, notarized, universal binaries -- NOT the
  # source tarball.
  #
  # Building from source produces ad-hoc signed binaries, and macOS records a
  # TCC permission grant against the designated requirement of the binary it
  # was granted to. For an ad-hoc signature that requirement is a bare content
  # hash, so every `brew upgrade` produced a new hash, invalidated the grant,
  # and re-prompted the user for Calendars, Reminders, and Contacts access.
  # Nothing errored; the dialogs just came back.
  #
  # The signed binaries carry a requirement anchored on Apple's certificate
  # chain and team OU instead, which is independent of the binary's contents,
  # so a grant survives every upgrade and certificate renewal.
  url "https://github.com/omarshahine/apple-pim/releases/download/v3.17.0/apple-pim-clis-3.17.0-universal.zip"
  sha256 "806ab420acfccf497230d520c2083bd23b2356102eb8114ee0ec33ad30031786"
  license "MIT"

  # macOS 13 is the package's deployment target. The binaries are universal
  # (arm64 + x86_64), so Intel Macs are covered.
  depends_on macos: :ventura

  # Homebrew rewrites rpaths during relocation, and rewriting re-signs the
  # binary ad-hoc -- which would destroy the Developer ID signature and put
  # users straight back on content-hash pins, silently. These binaries link
  # only /usr/lib and /System and carry no Homebrew-prefix references, so
  # there is nothing to relocate; this makes that explicit and durable.
  preserve_rpath

  def install
    bin.install "calendar-cli", "reminder-cli", "contacts-cli", "mail-cli"
  end

  def caveats
    <<~EOS
      The apple-pim CLIs use EventKit, Contacts, and Mail. macOS will prompt
      for TCC permissions (Calendars, Reminders, Contacts, Automation) the
      first time each command runs. Grant access in:

        System Settings -> Privacy & Security

      You only need to answer those prompts once per machine. These binaries
      are Developer ID signed, so the grant survives future upgrades.

      Upgrading from 3.17.0 or earlier: you will be asked once more, because
      the previous builds were unsigned and their grants were tied to a
      content hash. That is the last time an upgrade will ask.
    EOS
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/calendar-cli --help")
    assert_match "USAGE", shell_output("#{bin}/mail-cli --help")

    # The signature surviving installation is the entire point of shipping
    # prebuilt binaries, and losing it fails silently: everything still runs,
    # users just start getting re-prompted for permissions again. Assert it
    # here so a future Homebrew change that re-signs our binaries is caught
    # by the formula's own test rather than by confused users.
    %w[calendar-cli reminder-cli contacts-cli mail-cli].each do |exe|
      system "codesign", "--verify", "--strict", bin/exe
      assert_match "N9DRSTM2U6", shell_output("codesign -dvvv #{bin}/#{exe} 2>&1")
      # The designated requirement must be identity-anchored, not a cdhash
      # pin. A cdhash here means the signature was replaced.
      refute_match(/cdhash/, shell_output("codesign -d -r- #{bin}/#{exe} 2>&1"))
    end
  end
end
