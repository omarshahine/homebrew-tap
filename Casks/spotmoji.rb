# typed: strict
# frozen_string_literal: true

cask "spotmoji" do
  version "0.1.2"
  sha256 "b9e42bdd787f9629899abaf061879a5280f8834df172f82f46a79178581d5ae6"

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
