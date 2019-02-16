
with import <nixpkgs> {};

let

  dependencies = [
    # jar(org='org.world-engine', name='worldengine-java', rev='1.0'),
    {
      org = "org.world-engine";
      name = "worldengine-java";
      rev = "1.0"; # think about latest
    }
  ]

in stdenv.mkDerivation {
  
}