# typed: strict
# frozen_string_literal: true

cask "spotmoji" do
  version "0.3.3"
  sha256 "419f15f72ca03c7066166cae1ae681ac0c3b5200db2e4e60b5befbc4522fd3e3"

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
