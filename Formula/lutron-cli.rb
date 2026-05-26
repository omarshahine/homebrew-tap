class LutronCli < Formula
  include Language::Python::Virtualenv

  desc "Command-line client for Lutron Caseta Smart Bridges"
  homepage "https://github.com/omarshahine/lutron-cli"
  url "https://github.com/omarshahine/lutron-cli/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "8c3646d4e3dd858b148dd8b13b8eb6f385d9967cb12dbd935488e71deac955c6"
  license "MIT"
  head "https://github.com/omarshahine/lutron-cli.git", branch: "main"

  depends_on "python@3.13"
  depends_on "rust" => :build      # cryptography sdist build
  depends_on "openssl@3"           # cryptography link

  resource "click" do
    url "https://files.pythonhosted.org/packages/9b/98/518d8e5081007684232226f475082b30087d0f585e8457db087298259f49/click-8.4.1.tar.gz"
    sha256 "918b5633eddf6b41c32d4f454bf0de810065c74e3f7dbf8ee5452f8be88d3e96"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/eb/56/b1ba7935a17738ae8453301356628e8147c79dbb825bcbc73dc7401f9846/cffi-2.0.0.tar.gz"
    sha256 "44d1b5909021139fe36001ae048dbdde8214afa20200eda0f64c068cac5d5529"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/9f/a9/db8f313fdcd85d767d4973515e1db101f9c71f95fced83233de224673757/cryptography-48.0.0.tar.gz"
    sha256 "5c3932f4436d1cccb036cb0eaef46e6e2db91035166f1ad6505c3c9d5a635920"
  end

  resource "ifaddr" do
    url "https://files.pythonhosted.org/packages/e8/ac/fb4c578f4a3256561548cd825646680edcadb9440f3f68add95ade1eb791/ifaddr-0.2.0.tar.gz"
    sha256 "cc0cbfcaabf765d44595825fb96a99bb12c79716b73b44330ea38ee2b0c4aed4"
  end

  resource "orjson" do
    url "https://files.pythonhosted.org/packages/7e/0c/964746fcafbd16f8ff53219ad9f6b412b34f345c75f384ad434ceaadb538/orjson-3.11.9.tar.gz"
    sha256 "4fef17e1f8722c11587a6ef18e35902450221da0028e65dbaaa543619e68e48f"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/1b/7d/92392ff7815c21062bea51aa7b87d45576f649f16458d78b7cf94b9ab2e6/pycparser-3.0.tar.gz"
    sha256 "600f49d217304a5902ac3c37e1281c9fe94e4d0489de643a9504c5cdfdfc6b29"
  end

  resource "pylutron-caseta" do
    url "https://files.pythonhosted.org/packages/01/98/ebf87849d83d619d1ce179fd962ba7791e684857abd41e7cbd1a06e00a4c/pylutron_caseta-0.28.0.tar.gz"
    sha256 "266a806f29e6fca6f6a572c5739734f5041c0b5aec16e03a189455a7ac80b72f"
  end

  resource "zeroconf" do
    url "https://files.pythonhosted.org/packages/83/34/c981e760690f7b7dc91532d4d4ad21e3922887aaa425a0e7bff8067152da/zeroconf-0.149.16.tar.gz"
    sha256 "5e6b5a3b153c2cc2a8d9e6f6f189ec5638f7d9c86fc3e88a6c53eb6863761a5e"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      First-time setup:

        1. Discover your bridge:  lutron scan
        2. Pair (press the small black button on the back within 180s):
             lutron pair <bridge-ip>
        3. Verify:  lutron info

      Bridge TLS certs are stored at ~/.config/pylutron_caseta/. The default
      bridge host is persisted to ~/.config/lutron-cli/config.json.
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/lutron --help")
    assert_match "lutron area", shell_output("#{bin}/lutron --help")
  end
end
