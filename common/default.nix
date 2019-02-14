with (import <nixpkgs>{});

with lib.sources;

let

  scalaFiles = sourceFilesBySuffices ./src/main/scala [".scala"];

in stdenv.mkDerivation rec {
  name = "sediment-common";
  builder = "${bash}/bin/bash";
  args = [ ./builder.sh ];
  inherit coreutils findutils scala_2_11;
  srcs = scalaFiles;
  system = builtins.currentSystem;
}
