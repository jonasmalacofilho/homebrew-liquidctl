class Liquidctl < Formula
  include Language::Python::Virtualenv

  desc "Cross-platform tool and drivers for liquid coolers and other devices"
  homepage "https://github.com/jonasmalacofilho/liquidctl"
  url "https://files.pythonhosted.org/packages/f6/e4/ba85351cde1be689bd7250f96fd4e48a78988f723843fbbe5b67596edfa2/liquidctl-1.3.3.tar.gz"
  sha256 "d13180867e07420c5890fe1110e8f45fe343794549a9ed7d5e8e76663bc10c24"
  license "GPL-3.0"
  revision 1
  head "https://github.com/jonasmalacofilho/liquidctl.git"

  depends_on "libusb"
  depends_on "python@3.8"

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "hidapi" do
    url "https://files.pythonhosted.org/packages/7c/a0/d5ca6f191c8860a4769ba19448d2b2d6b3e2ca2c30aa61bb96a3f6bd25ba/hidapi-0.9.0.post2.tar.gz"
    sha256 "a71dd3c153cb6bb2b73d2612b5ab262830d78c6428f33f0c06818749e64c9320"
  end

  resource "pyusb" do
    url "https://files.pythonhosted.org/packages/5f/34/2095e821c01225377dda4ebdbd53d8316d6abb243c9bee43d3888fa91dd6/pyusb-1.0.2.tar.gz"
    sha256 "4e9b72cc4a4205ca64fbf1f3fff39a335512166c151ad103e55c8223ac147362"
  end

  def install
    # customize liquidctl --version
    ENV["DIST_NAME"] = OS.mac? ? "homebrew" : "linuxbrew"
    ENV["DIST_PACKAGE"] = "#{tap.nil? ? path : full_name} #{version}"

    # patch cython-hidapi to build with headers in a custom location
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources.reject { |r| r.name == "hidapi" }
    resource("hidapi").stage do
      inreplace "setup.py", "/usr/include/", "#{Formula["libusb"].include}/"
      venv.pip_install "."
    end
    venv.pip_install_and_link buildpath

    man_page = buildpath/"liquidctl.8"
    if OS.mac?
      # setting the is_macos register to 1 adjusts the man page for macOS
      inreplace man_page, ".nr is_macos 0", ".nr is_macos 1"
    end
    man.mkpath
    man8.install man_page

    opoo "The custom jonasmalacofilho/liquidctl tap has been deprecated; " \
         "it is recommended to switch to the liquidctl formula in #{ENV["DIST_NAME"]}brew-core."
  end

  test do
    shell_output "#{bin}/liquidctl list --verbose --debug"
  end
end
