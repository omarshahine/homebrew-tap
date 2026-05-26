class AqaraCli < Formula
  include Language::Python::Virtualenv

  desc "Command-line client for the Aqara Open Cloud API"
  homepage "https://github.com/omarshahine/aqara-cli"
  url "https://github.com/omarshahine/aqara-cli/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "c57b35b609505592cac2d69219092ed0557e6f12f4b5c67fe5b880d28b8b26f6"
  license "MIT"
  head "https://github.com/omarshahine/aqara-cli.git", branch: "main"

  depends_on "python@3.13"

  resource "click" do
    url "https://files.pythonhosted.org/packages/9b/98/518d8e5081007684232226f475082b30087d0f585e8457db087298259f49/click-8.4.1.tar.gz"
    sha256 "918b5633eddf6b41c32d4f454bf0de810065c74e3f7dbf8ee5452f8be88d3e96"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      First-time setup (full walkthrough in the README):

        1. Register a developer app at https://developer.aqara.com
        2. Add http://localhost:8765/callback as an authorized Redirect URI
        3. Save credentials:  aqara auth set-app --app-id ... --app-key ... --key-id ...
        4. Bootstrap tokens:  aqara auth browser-flow
        5. Pick a default home:  aqara homes && aqara home set "Your Home"
        6. Install the refresher (optional):  aqara auth install-refresher

      Credentials land at ~/.config/aqara-cli/credentials.json (mode 600).
      Env vars (AQARA_OPEN_*) override the credentials file if set.
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/aqara --help")
    assert_match "aqara auth", shell_output("#{bin}/aqara --help")
  end
end
