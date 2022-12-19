load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_jvm_external",
    sha256 = "6274687f6fc5783b589f56a2f1ed60de3ce1f99bc4e8f9edef3de43bdf7c6e74",
    strip_prefix = "rules_jvm_external-4.3",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/4.3.zip",
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    artifacts = [
        "com.apollographql.apollo3:apollo-compiler:3.6.2",
    ],
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
)

RULES_KOTLIN = "1.6.0"
RULES_KOTLIN_SHA = "a57591404423a52bd6b18ebba7979e8cd2243534736c5c94d35c89718ea38f94"
http_archive(
    name = "io_bazel_rules_kotlin",
    urls = ["https://github.com/bazelbuild/rules_kotlin/releases/download/v%s/rules_kotlin_release.tgz" % RULES_KOTLIN],
    sha256 = RULES_KOTLIN_SHA
)

load("@io_bazel_rules_kotlin//kotlin:repositories.bzl", "kotlin_repositories")
kotlin_repositories()

load("@io_bazel_rules_kotlin//kotlin:core.bzl", "kt_register_toolchains")
kt_register_toolchains()