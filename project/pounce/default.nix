
with (import <nixpkgs>{});
with lib.sources;
with lib.strings;

let 
  coursier-jars = (import ../../3rdparty/coursier).library;
in rec {

  scala_version = scala_2_12;
  java_version = openjdk8;

  javaLibrary = { name, javaRoot }: stdenv.mkDerivation {
    name = name;
    src = javaRoot;
    buildInputs = [ coreutils findutils java_version ];
    buildCommand = ''
      cp -r $src/* .
      FILES=$(find . -type f -name '*.java')
      echo "Using files: $FILES"

      CLASSPATH=$(cat ${coursier-jars}/classpath)
      echo "Coursier classpath: $CLASSPATH"

      mkdir $out
      
      javac -classpath $CLASSPATH -d $out $FILES
    '';
  };

  scalaLibrary = { name, scalaRoot, dependencies ? [] }: let
    depsClasspath = concatStringsSep ":" dependencies;
  in stdenv.mkDerivation {
    name = name;
    src = scalaRoot;
    buildInputs = [ coreutils findutils scala_version ];
    buildCommand = ''
      cp -r $src/* .
      FILES=$(find . -type f -name '*.scala')
      echo "Using files: $FILES"

      CLASSPATH=$(cat ${coursier-jars}/classpath)
      echo "Coursier classpath: $CLASSPATH"

      DEPS_CLASSPATH=${depsClasspath}
      echo "Dependencies classpath: $DEPS_CLASSPATH"

      FULL_CLASSPATH=$CLASSPATH:$DEPS_CLASSPATH
      echo "Full classpath: $FULL_CLASSPATH"

      mkdir $out
      
      scalac -classpath $FULL_CLASSPATH -d $out $FILES
    '';
  };

  scalaRunner = { name, topLevelLibrary, mainClass }: pkgs.writeTextFile { 
    name = name;
    text = ''
      PATH=${scala_version}/bin:${coreutils}/bin
      DEPS_CLASSPATH=$(cat ${coursier-jars}/classpath)
      LIB_CLASSPATH=${topLevelLibrary}
      FULL_CLASSPATH="$DEPS_CLASSPATH:$LIB_CLASSPATH"
      
      echo "Running with $FULL_CLASSPATH"
      
      scala -cp $FULL_CLASSPATH ${mainClass} $@
    '';
    executable = true;
  };

}
