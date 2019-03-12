
# One proto_library rule per .proto file (?)
proto_library(
    name = "proto",
    srcs = ["World.proto"],
    )

# Java wrapper
java_proto_library(
    name = "lib",
    deps = [":proto"],
    )

