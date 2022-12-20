load("@rules_java//java:defs.bzl", "java_library")
load("//src/main/java/com/example/compiler:rules.bzl", "compiler")
load("@io_bazel_rules_kotlin//kotlin:jvm.bzl", "kt_jvm_library", "kt_jvm_test")

#compiler(
#    name = "compiler",
#    srcs = [
#        "queries/launchlist.graphql",
#        "queries/schema.graphqls",
#    ],
#)

java_library(
    name = "example_gql",
    srcs = [
        "Main.java",
    ],
    deps = [
        ":graphql-compile",
    ],
)

compiler(
    name = "graphql-compile",
    graphql_file = ["queries/launchlist.graphql"],
    graphqls_file = ["queries/schema.graphqls"],
    srcs = glob(["**/*.java"]),
    deps = ["@maven//:com_apollographql_apollo3_apollo_compiler"],
)