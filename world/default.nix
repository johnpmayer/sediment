
with (import <nixpkgs>{});
with import ../project/pounce;

rec {

  generatedSources = stdenv.mkDerivation {
    name = "world-gen";
    src = ./src/main/resources;
    buildInputs = [ protobuf3_5 ];
    buildCommand = ''
      mkdir $out
      ls -al $src
      protoc --proto_path=$src --java_out=$out $src/*.proto
    '';
  };

  library = javaLibrary {
    name = "world-lib";
    javaRoot = generatedSources;
  };

}
