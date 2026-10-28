# typed: strict
# frozen_string_literal: true

cask "clipdown" do
  version "1.2.1"
  sha256 "5bafc7d0b26ab2e054a367ecfc6848713bbe4d83d02e016515d68da5745fa7c2"

  url "https://github.com/omarshahine/homebrew-tap/releases/download/clipdown-v#{version}/ClipDown-#{version}.zip"
  name "ClipDown"
  desc "Keeps terminal text formatted when you paste it into Teams, Slack and more"
  homepage "https://omarknows.app/clipdown/"

  auto_updates true
  depends_on macos: :sequoia

  app "ClipDown.app"
  binary "#{appdir}/ClipDown.app/Contents/MacOS/clipdown"

  uninstall quit:       "com.omarshahine.clipdown",
            login_item: "ClipDown"

  zap trash: [
    "~/Library/Caches/com.omarshahine.clipdown",
    "~/Library/Caches/com.omarshahine.clipdown.lock",
    "~/Library/HTTPStorages/com.omarshahine.clipdown",
    "~/Library/Preferences/com.omarshahine.clipdown.plist",
  ]
end
