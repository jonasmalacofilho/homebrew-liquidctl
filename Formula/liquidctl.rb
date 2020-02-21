class Liquidctl < Formula
  include Language::Python::Virtualenv

  desc "Cross-platform tool and drivers for liquid coolers and other devices"
  homepage "https://github.com/jonasmalacofilho/liquidctl"
  url "https://files.pythonhosted.org/packages/source/l/liquidctl/liquidctl-1.3.3.tar.gz"
  sha256 "d13180867e07420c5890fe1110e8f45fe343794549a9ed7d5e8e76663bc10c24"

  head "https://github.com/jonasmalacofilho/liquidctl.git"

  depends_on "libusb"
  depends_on "python"

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/source/d/docopt/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "hidapi" do
    url "https://files.pythonhosted.org/packages/source/h/hidapi/hidapi-0.7.99.post21.tar.gz"
    sha256 "e0be1aa6566979266a8fc845ab0e18613f4918cf2c977fe67050f5dc7e2a9a97"
  end

  resource "pyusb" do
    url "https://files.pythonhosted.org/packages/source/p/pyusb/pyusb-1.0.2.tar.gz"
    sha256 "4e9b72cc4a4205ca64fbf1f3fff39a335512166c151ad103e55c8223ac147362"
  end

  def install
    # customize liquidctl --version
    ENV["DIST_NAME"] = OS.mac? ? "homebrew" : "linuxbrew"
    ENV["DIST_PACKAGE"] = "#{tap.nil? ? path : full_name} #{version}"

    opoo "The custom jonasmalacofilho/liquidctl tap has been deprecated; " \
         "it is recommended to switch to the liquidctl formula in #{ENV["DIST_NAME"]}brew-core."

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
  end

  test do
    shell_output "#{bin}/liquidctl list --verbose --debug"
  end
end
