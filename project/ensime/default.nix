
with (import <nixpkgs>{});
with import ../pounce;

rec {
  library = scalaLibrary {
    name = "ensime-gen-lib";
    scalaRoot = ./src/main/scala;
  };

  run-script = scalaRunner {
    name = "ensime-gen";
    topLevelLibrary = library;
    mainClass = "sediment.project.ensime.EnsimeGenerator";
  };
}