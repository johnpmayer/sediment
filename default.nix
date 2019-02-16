
with import <nixpkgs> {};

stdenv.mkDerivation {

  inherit (pkgs) python;

  name = "sediment-dev-env";
  buildInputs = [
    # General tooling
    git
    # Scala
    scala_2_11
    coursier
    # Project-specific
    python27Packages.worldengine
  ];  
}
