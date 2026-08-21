# typed: strict
# frozen_string_literal: true

cask "spotmoji" do
  version "0.3.1"
  sha256 "82e974ef7b9447a403b7b5219630a7ccade41753601149c20d143f562ff8a8f1"

  url "https://github.com/omarshahine/homebrew-tap/releases/download/spotmoji-v#{version}/Spotmoji-#{version}.zip",
      verified: "github.com/omarshahine/homebrew-tap/"
  name "Spotmoji"
  desc "Spotlight-first native emoji picker"
  homepage "https://omarknows.app/spotmoji/"

  auto_updates true
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
