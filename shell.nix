
with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "sediment-dev-env";
  buildInputs = [
    git
    pants
  ];  
}