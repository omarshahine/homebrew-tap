# typed: strict
# frozen_string_literal: true

cask "clipdown" do
  version "1.1.0"
  sha256 "a224c71a8089b2db99b9bcd78bef29e150bb5f7e3d123502236af85c05d18384"

  url "https://github.com/omarshahine/homebrew-tap/releases/download/clipdown-v#{version}/ClipDown-#{version}.zip",
      verified: "github.com/omarshahine/homebrew-tap/"
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
