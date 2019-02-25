
with (import <nixpkgs>{});
with lib.sources;

let 
  coursier-jars = import ../../3rdparty/coursier;
in {

  javaLibrary = { name, javaRoot}: stdenv.mkDerivation {
    name = name;
    src = javaRoot;
    buildInputs = [ coreutils findutils openjdk8 ];
    buildCommand = ''
      cp -r $src/* .
      FILES=$(find . -type f -name '*.java')
      echo "Using files: $FILES"

      CLASSPATH=$(cat ${coursier-jars}/classpath)
      echo "Coursier classpath: $CLASSPATH"

      mkdir $out
      
      set -x
      javac -classpath $CLASSPATH -d $out $FILES
      set +x
    '';
  };

  scalaLibrary = { name, scalaRoot }: stdenv.mkDerivation {
    name = name;
    src = scalaRoot;
    buildInputs = [ coreutils findutils scala_2_11 ];
    buildCommand = ''
      cp -r $src/* .
      FILES=$(find . -type f -name '*.scala')
      echo "Using files: $FILES"

      CLASSPATH=$(cat ${coursier-jars}/classpath)
      echo "Coursier classpath: $CLASSPATH"

      mkdir $out
      
      set -x
      scalac -classpath $CLASSPATH -d $out $FILES
      set +x
    '';
  };

  scalaRunner = { name, topLevelLibrary, mainClass }: pkgs.writeTextFile { 
    name = name;
    text = ''
      PATH=${scala_2_11}/bin:${coreutils}/bin
      DEPS_CLASSPATH=$(cat ${coursier-jars}/classpath)
      LIB_CLASSPATH=${topLevelLibrary}
      FULL_CLASSPATH="$DEPS_CLASSPATH:$LIB_CLASSPATH"
      echo "Running with $FULL_CLASSPATH"
      set -x
      scala -cp $FULL_CLASSPATH ${mainClass} $@
      set +x
    '';
    executable = true;
  };

}