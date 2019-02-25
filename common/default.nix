
with (import <nixpkgs>{});
with lib.sources;

let

  coursier-jars = import ../3rdparty/coursier;
  scalaFiles = sourceFilesBySuffices ./src/main/scala [".scala"];
  main-class = "sediment.common.WorldLoader";

in rec {
  library = stdenv.mkDerivation {
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

  run-script = pkgs.writeTextFile { 
    name = "sediment-common-bin";
    text = ''
      DEPS_CLASSPATH=$(cat ${coursier-jars}/classpath)
      LIB_CLASSPATH=${library}
      FULL_CLASSPATH="$DEPS_CLASSPATH:$LIB_CLASSPATH"
      echo "Running with $FULL_CLASSPATH"
      set -x
      scala -cp $FULL_CLASSPATH ${main-class} -- $@
      set +x
    '';
    executable = true;
    destination = "/bin/run";
  };
}
