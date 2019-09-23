{ stdenv, fetchurl, autoPatchelfHook,

  atomEnv, dpkg, gtk2, db53, libkrb5, openssl, cups, udev,

  makeLibraryPath ? stdenv.lib.makeLibraryPath,
  replaceStrings ? stdenv.lib.replaceStrings,
  substring ? stdenv.lib.substring,
}:

let

  clean = version: replaceStrings [ "_" ] [ "." ] (substring 0 9 version);

in

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "mailspring";
  version = "1.6.3";

  src = fetchurl {
    url = "https://github.com/Foundry376/Mailspring/releases/download/${version}/mailspring-${version}-amd64.deb";
    sha256 = "0lahvfvxwqbnp12qqc6pzbv5vnr3fr9i11af8lqrdjsd1ylsb73r";
  };


  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  buildInputs = [
    atomEnv.packages
    cups
    db53
    libkrb5
    openssl
  ];

  runtimeDependencies = [
    udev.lib
  ];

  unpackPhase = /* sh */ ''
    dpkg -x $src .
  '';

  installPhase = /* sh */ ''
    mkdir -p $out/bin
    cp -ar ./usr/share $out
    ln -s $out/share/mailspring/mailspring $out/bin/mailspring
  '';

  postFixup = /* sh */ ''
    substituteInPlace $out/share/applications/mailspring.desktop \
      --replace /usr/bin $out/bin
  '';

  meta = with stdenv.lib; {
    description = "Open-source mail client built on the modern web with Electron, React, and Flux";
    license = licenses.gpl3;
    maintainers = with maintainers; [ rummik ];
    homepage = https://getmailspring.com;
    platforms = [ "x86_64-linux" ];
  };
}
