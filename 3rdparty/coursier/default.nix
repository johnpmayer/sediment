
with import <nixpkgs> {};
with lib.strings;

let

  dependencies = [
    {
      org = "com.google.protobuf";
      name = "protobuf-java";
      rev = "3.5.1";
    }

    {
      org = "org.ensime";
      name = "api_2.12";
      rev = "2.0.2";
    }
  ];

  makeCoursierString = dep:
    "${dep.org}:${dep.name}:${dep.rev}";

  coursierArgs = concatMapStringsSep " " makeCoursierString dependencies;

in {
  library = stdenv.mkDerivation {
    name = "coursier-jars";
    buildInputs = [ coursier ];
    buildCommand = ''
      export HOME=$TMP # Coursier requires a home directory
      echo "Resolving ${coursierArgs}"
      export CACHE="$out/coursier-cache"
      export CLASSPATH="$out/classpath"
      mkdir -p $CACHE
      coursier resolve --cache $CACHE ${coursierArgs}
      coursier fetch --cache $CACHE ${coursierArgs} --classpath > $CLASSPATH
      cat $CLASSPATH
    '';
  };
}