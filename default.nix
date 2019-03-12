
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

    # Build tools
    bazel
    bazel-deps

    # Development tools
    jetbrains.idea-community

    # Domain-specific tools
    python27Packages.worldengine
    feh # really simple image viewer, good enough for now
  ];  
}
