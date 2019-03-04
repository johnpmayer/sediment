
with import <nixpkgs> {};

let
  pounce = import ./project/pounce;
in stdenv.mkDerivation {

  inherit (pkgs) python;

  name = "sediment-dev-env";
  buildInputs = [
    # General tooling
    git
    pounce.java_version
    pounce.scala_version
    # Project-specific
    python27Packages.worldengine
    feh # really simple image viewer, good enough for now
  ];  
}
