
with (import <nixpkgs>{});
with import ../pounce;

rec {
  library = scalaLibrary {
    name = "library";
    scalaRoot = ./src/main/scala;
    dependencies = [
    ];
  };

  run-script = scalaRunner {
    name = "run-script";
    topLevelLibrary = library;
    mainClass = "sediment.project.nixbsp.NixBsp";
  };
}
