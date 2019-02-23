
with (import <nixpkgs>{});
with lib.sources;

let

  coursier-jars = import ../3rdparty/coursier;
  scalaFiles = sourceFilesBySuffices ./src/main/scala [".scala"];
  main-class = "sediment.common.WorldLoader";

in rec {
  my-lib = stdenv.mkDerivation {
    name = "sediment-common-lib";
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
  };

  my-bin = pkgs.writeTextFile { 
    name = "sediment-common-bin";
    text = ''
      DEPS_CLASSPATH=$(cat ${coursier-jars}/classpath)
      LIB_CLASSPATH=${my-lib}
      FULL_CLASSPATH="$DEPS_CLASSPATH:$LIB_CLASSPATH"
      echo "Running with $FULL_CLASSPATH"
      scala -cp $FULL_CLASSPATH ${main-class}
    '';
    executable = true;
    destination = "/bin/run";
  };
}