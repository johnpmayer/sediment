
with (import <nixpkgs>{});
with import ../project/pounce;

rec {

  protoSource = fetchurl {
    url = "https://raw.githubusercontent.com/Mindwerks/worldengine/v0.19.0/worldengine/World.proto";
    sha256 = "0h02md7w35b7rwm54hz03r4lnjl6xa705y30hfm2al95y09vkbxm";
  };

  generatedSources = stdenv.mkDerivation {
    name = "world-generated-sources";
    src = protoSource;
    buildInputs = [ protobuf3_5 ];
    buildCommand = ''
      mkdir path_dir
      cp $src path_dir/World.proto
      sed -i 's/^package World;$/package world;/' path_dir/World.proto
      mkdir $out
      protoc --proto_path=path_dir --java_out=$out path_dir/*.proto
    '';
  };

  library = javaLibrary {
    name = "world-lib";
    javaRoot = generatedSources;
  };

}
