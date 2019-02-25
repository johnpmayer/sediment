
with import <nixpkgs> {};

stdenv.mkDerivation {

  inherit (pkgs) python;

  name = "sediment-dev-env";
  buildInputs = [
    # General tooling
    git
    # Project-specific
    python27Packages.worldengine
    feh # really simple image viewer, good enough for now
  ];  
}
