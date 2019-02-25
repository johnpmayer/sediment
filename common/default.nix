
with (import <nixpkgs>{});
with lib.sources;
with import ../project/pounce;

let

  coursier-jars = import ../3rdparty/coursier;
  scalaFiles = sourceFilesBySuffices ./src/main/scala [".scala"];
  main-class = "sediment.common.WorldLoader";

in rec {
  library = scalaLibrary {
    name = "sediment-common-lib";
    scalaRoot = ./src/main/scala;
  };

  run-script = scalaRunner {
    name = "sediment-common-bin";
    topLevelLibrary = library;
    mainClass = "sediment.common.WorldLoader";
  };
}
