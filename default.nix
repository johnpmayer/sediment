
with import <nixpkgs> {};

stdenv.mkDerivation {

  inherit (pkgs) python;

  name = "sediment-dev-env";
  buildInputs = [
    git
    openjdk8
    scala_2_11
    python27Packages.worldengine
  ];  
}
