
with import <nixpkgs> {};
with lib.strings;

let

  dependencies = [
    {
      org = "org.world-engine";
      name = "worldengine-java";
      rev = "1.0"; # think about latest
    }
  ];

  makeCoursierString = dep:
    "${dep.org}:${dep.name}:${dep.rev}";

  coursierArgs = concatMapStringsSep " " makeCoursierString dependencies;

in stdenv.mkDerivation {
  name = "coursier-jars";
  buildInputs = [ coursier ];
  buildCommand = ''
    export HOME=$TMP # Coursier requires a home directory
    echo "Resolving ${coursierArgs}"
    export CACHE="$out/coursier-cache"
    export CLASSPATH="$out/classpath"
    mkdir -p $CACHE
    # coursier resolve --cache $CACHE --tree ${coursierArgs}
    coursier fetch --cache $CACHE ${coursierArgs} --classpath > $CLASSPATH
    cat $CLASSPATH
  '';
}