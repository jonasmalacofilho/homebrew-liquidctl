class Liquidctl < Formula
  include Language::Python::Virtualenv

  desc "Cross-platform CLI and Python drivers for AIO liquid coolers and other devices"
  homepage "https://github.com/jonasmalacofilho/liquidctl"
  url "https://files.pythonhosted.org/packages/f2/08/7e56efece1ed5083e82826a1734f6e3c452401602ca211448c4b2c9e4cc9/liquidctl-1.2.0.tar.gz"
  sha256 "ad8c03c0695620fedaec11e7a8286bb5d4da18ba0c71e55888bfa06f8f7d7529"

  head "https://github.com/jonasmalacofilho/liquidctl.git"

  depends_on "libusb"
  depends_on "python"

  resource "appdirs" do
    url "https://files.pythonhosted.org/packages/48/69/d87c60746b393309ca30761f8e2b49473d43450b150cb08f3c6df5c11be5/appdirs-1.4.3.tar.gz"
    sha256 "9e5896d1372858f8dd3344faf4e5014d21849c756c8d5701f78f8a103b372d92"
  end

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "hidapi" do
    url "https://files.pythonhosted.org/packages/c1/86/89df0e8890f96eeb5fb68d4ccb14cb38e2c2d2cfd7601ba972206acd9015/hidapi-0.7.99.post21.tar.gz"
    sha256 "e0be1aa6566979266a8fc845ab0e18613f4918cf2c977fe67050f5dc7e2a9a97"
  end

  resource "pyusb" do
    url "https://files.pythonhosted.org/packages/5f/34/2095e821c01225377dda4ebdbd53d8316d6abb243c9bee43d3888fa91dd6/pyusb-1.0.2.tar.gz"
    sha256 "4e9b72cc4a4205ca64fbf1f3fff39a335512166c151ad103e55c8223ac147362"
  end

  def install
    ENV["DIST_NAME"] = OS.mac? ? "homebrew" : "linuxbrew"
    ENV["DIST_PACKAGE"] = "#{tap == nil ? path : full_name} #{version}"
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources.reject { |r| r.name == "hidapi" }
    resource("hidapi").stage do
      inreplace "setup.py", "/usr/include/", "#{Formula["libusb"].include}/"
      venv.pip_install "."
    end
    venv.pip_install_and_link buildpath

    man_page = buildpath/"liquidctl.8"
    if man_page.exist?
      if OS.mac?
        inreplace man_page, "/run/liquidctl/", "/Library/Application Support/liquidctl/"
      end
      man.mkpath
      man8.install man_page
    end
  end

  test do
    shell_output("#{bin}/liquidctl list", 0)
  end
end
