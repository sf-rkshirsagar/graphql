load("@rules_java//java:defs.bzl", "java_library")

#load("@rules_java//java:defs.bzl", "java_binary")
#load("//src/main/java/com/example/compiler:rules.bzl", "compile")
#
#package(default_visibility = ["//visibility:public"])

#java_binary(
#    name = "code_generator",
#    srcs = [
#        "Compiler.java",
#    ],
#    main_class = "com.example.compiler.Compiler",
#    deps = [
#        "@maven//:com_apollographql_apollo3_apollo_compiler",
#    ],
#)

sh_binary(
    name = "compiler",
    srcs = ["compiler.sh"],
    visibility = ["//visibility:public"],
)

java_library(
    name = "compiler_main",
    srcs = [
        "Compiler.java",
    ],
    deps = [
        "@maven//:com_apollographql_apollo3_apollo_compiler",
    ],
    visibility = ["//visibility:public"],
)