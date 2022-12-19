load("@rules_java//java:defs.bzl", "java_library")
load("//src/main/java/com/example/compiler:rules.bzl", "compiler")
load("@io_bazel_rules_kotlin//kotlin:jvm.bzl", "kt_jvm_library", "kt_jvm_test")

compiler(
    name = "compiler",
    srcs = [
        "queries/launchlist.graphql",
        "queries/schema.graphqls",
    ],
)

java_library(
    name = "example_gql",
    srcs = [
        "Main.java",
        ":compiler",
    ],
    deps = [
#        ":kt-lib"
    ],
)

# Generated files are here: bazel-out/darwin-fastbuild/bin/src/main/java/com/example/apollo/com/example
# However they can't be located.
#kt_jvm_library(
#    name = "kt-lib",
#    srcs = glob(["**/*.kt", "*.kt"]),
#    deps = [
#        "@maven//:com_apollographql_apollo3_apollo_compiler",
#    ],
#)