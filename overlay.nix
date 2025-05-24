final: prev: let
  src = {
    url = "https://sam.nrel.gov/download/80-sam-2025-4-16-for-linux/file.html";
    sha256 = "sha256-YkbateULhCgpso3nBYGoNLbQXrQ3j7PcedO/LXn/HMw=";
  };
in {
  sam = prev.stdenv.mkDerivation {
    pname = "sam";
    version = "2025-04-16";
    nativeBuildInputs = [
      final.autoPatchelfHook
      final.makeWrapper
    ];
    autoPatchelfIgnoreMissingDeps = ["libgfortran.so.3"];
    buildInputs = with final; [
      libsecret
      curl
      gtk2
      xorg.libXxf86vm
      xorg.libXtst
      xorg.libSM
      libgcc
      #gfortran.cc.lib
    ];
    src = prev.fetchurl src;
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
