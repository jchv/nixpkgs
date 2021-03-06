{ stdenv, fetchurl, meson, ninja, pkgconfig, gettext, itstool, desktop-file-utils, gnome3, glib, gtk3, libexif, libtiff, colord, colord-gtk, libcanberra-gtk3, lcms2, vte, exiv2 }:

let
  pname = "gnome-color-manager";
  version = "3.30.0";
in stdenv.mkDerivation rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${name}.tar.xz";
    sha256 = "105bqqq3yvdn5lx94mkl0d450f0l8lmwfjjcwyls1pycmj0vifwh";
  };

  nativeBuildInputs = [ meson ninja pkgconfig gettext itstool desktop-file-utils ];
  buildInputs = [ glib gtk3 libexif libtiff colord colord-gtk libcanberra-gtk3 lcms2 vte exiv2 ];

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
      attrPath = "gnome3.${pname}";
    };
  };

  meta = with stdenv.lib; {
    description = "A set of graphical utilities for color management to be used in the GNOME desktop";
    license = licenses.gpl2Plus;
    maintainers = gnome3.maintainers;
    platforms = platforms.linux;
  };
}
