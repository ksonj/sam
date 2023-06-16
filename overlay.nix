final: prev: {
  sam = prev.stdenv.mkDerivation {
    pname = "sam";
    version = "2022-11-21-r3";
    nativeBuildInputs = [final.autoPatchelfHook final.makeWrapper];
    buildInputs = with final; [
      libsecret
      curl
      gtk2
      xorg.libXxf86vm
      xorg.libXtst
      xorg.libSM
      gfortran6.cc.lib
    ];
    src = prev.fetchurl {
      url = "https://sam.nrel.gov/download/71-sam-2022-11-21-for-linux/file.html";
      sha256 = "22235de1243d56f6295380b1f622de3160f39912c14848aa5e4f364ce01674c6";
    };
    unpackPhase = ''
      cp $src $name.run
      chmod +x $name.run
    '';
    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/build
      echo "$out/build" | ./$name.run
      cp $out/build/SAM $out/bin/sam
    '';
  };
}
