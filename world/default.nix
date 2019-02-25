
with (import <nixpkgs>{});

rec {

  proto_source = fetchurl {
    url = "https://raw.githubusercontent.com/Mindwerks/worldengine/v0.19.0/worldengine/World.proto";
    sha256 = "0h02md7w35b7rwm54hz03r4lnjl6xa705y30hfm2al95y09vkbxm";
  };

  generated_sources = stdenv.mkDerivation {
    name = "world-generated-sources";
    src = proto_source;
    buildInputs = [ protobuf3_5 ];
    buildCommand = ''
      mkdir path_dir
      cp ${proto_source} path_dir/World.proto
      mkdir $out
      protoc -I path_dir --java_out=$out path_dir/*.proto
    '';
  };

}
