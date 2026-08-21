# typed: strict
# frozen_string_literal: true

cask "spotmoji" do
  version "0.3.2"
  sha256 "3ec535a9d64f39369274baa146b5c2013e4e371cd0841843426b0ab584049f69"

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
