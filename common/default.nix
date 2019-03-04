
with (import <nixpkgs>{});
with import ../project/pounce;

rec {
  library = scalaLibrary {
    name = "sediment-common-lib";
    scalaRoot = ./src/main/scala;
    dependencies = [
      (import ../world).library
    ];
  };

  run-script = scalaRunner {
    name = "sediment-common-bin";
    topLevelLibrary = library;
    mainClass = "sediment.common.WorldLoader";
  };
}