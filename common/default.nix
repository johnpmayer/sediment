
with (import <nixpkgs>{});
with lib.sources;

let

  scalaFiles = sourceFilesBySuffices ./src/main/scala [".scala"];

in stdenv.mkDerivation {
  name = "sediment-common";
  srcs = scalaFiles;
  buildInputs = [ coreutils findutils scala_2_11 ];
  buildCommand = ''
    echo "Using path: $PATH"

    mkdir $out
    files=$(find $srcs -type f)
    echo "Using files: $files"
    scalac -d $out $files
  '';
}
