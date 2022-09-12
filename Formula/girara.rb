class Girara < Formula
  desc "Interface library"
  homepage "https://pwmt.org/projects/girara/"
  url "https://pwmt.org/projects/girara/download/girara-0.3.7.tar.xz"
  sha256 "76402290460d1a6252db47f40e9b903849fed947781b5521ff5d0128222f5d56"
  head "https://git.pwmt.org/pwmt/girara.git", branch: "develop"

=begin
  bottle do
    root_url "https://github.com/zegervdv/homebrew-zathura/releases/download/girara-0.3.7"
    rebuild 1
    sha256 big_sur:      "dd498c1ac849e654f69415e9251a4ea829ea42dc083268b1c43c5d471e3d147a"
    sha256 x86_64_linux: "b0f7fefdc208921c5e9189b5352b6a02a456bd5c315694a0efef85653311c2d1"
  end
=end

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "json-c"
  depends_on "libnotify"

  def install
    inreplace "girara/utils.c" do |s|
      s.gsub!(/xdg-open/, "open")
    end

    # Set HOMBREW_PREFIX
    ENV["CMAKE_INSTALL_PREFIX"] = prefix

    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    system "true" # TODO
  end
end
