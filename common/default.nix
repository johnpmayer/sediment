
with (import <nixpkgs>{});
with lib.sources;

let

  coursier-jars = import ../3rdparty/coursier;

  scalaFiles = sourceFilesBySuffices ./src/main/scala [".scala"];

in stdenv.mkDerivation {
  name = "sediment-common";
  srcs = scalaFiles;
  buildInputs = [ coreutils findutils scala_2_11 ];
  buildCommand = ''
    CLASSPATH=$(cat ${coursier-jars}/classpath)
    
    echo -n "Coursier classpath: $CLASSPATH"

    mkdir $out
    files=$(find $srcs -type f)
    echo "Using files: $files"
    
    set -x
    scalac -classpath $CLASSPATH -d $out $files
    set +x
  '';
}
