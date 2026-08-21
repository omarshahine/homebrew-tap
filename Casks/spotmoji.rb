# typed: strict
# frozen_string_literal: true

cask "spotmoji" do
  version "0.2.0"
  sha256 "aeb8b37189c2c936a7fcf229196662a95756d039cc84f062f40e5ea41fb453e1"

  url "https://github.com/omarshahine/homebrew-tap/releases/download/spotmoji-v#{version}/Spotmoji-#{version}.zip",
      verified: "github.com/omarshahine/homebrew-tap/"
  name "Spotmoji"
  desc "Spotlight-first native emoji picker"
  homepage "https://omarknows.app/spotmoji/"

  depends_on macos: :sonoma

  app "Spotmoji.app"

  uninstall quit: "com.omarshahine.Spotmoji"

  zap trash: [
    "~/Library/Caches/com.omarshahine.Spotmoji",
    "~/Library/Preferences/com.omarshahine.Spotmoji.plist",
    "~/Library/Saved Application State/com.omarshahine.Spotmoji.savedState",
  ]

  caveats <<~EOS
    Spotmoji needs Accessibility permission to paste into the previously active app.
    Grant it in System Settings > Privacy & Security > Accessibility.
  EOS
end
