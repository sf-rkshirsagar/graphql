load("@io_bazel_rules_kotlin//kotlin:jvm.bzl", "kt_jvm_library", "kt_jvm_test")

#def _compiler(ctx):
#    out = ctx.actions.declare_directory("apollo")
#    inputs = ctx.files.srcs
#
#    args = ctx.actions.args()
#    args.add(out.path)
#    args.add_all(ctx.files.srcs)
#
#    ctx.actions.run(
#        executable = ctx.executable.code_generator,
#        arguments = [args],
#        inputs = inputs,
#        outputs = [out],
#    )
#
#    return [DefaultInfo(files = depset([out]))]
#
#compiler = rule(
#    attrs = {
#        "code_generator": attr.label(
#            cfg = "exec",
#            default = ":code_generator",
#            executable = True,
#        ),
#        "srcs": attr.label_list(
#            allow_files = True,
#            mandatory = True,
#            allow_empty = False,
#        ),
#    },
#    implementation = _compiler,
#    output_to_genfiles = True,
#)

# ========================= #

_scrooge_runtime_deps = [
    "@maven//:com_apollographql_apollo3_apollo_compiler",
    "@maven//:com_apollographql_apollo3_apollo_ast",
    "@maven//:org_jetbrains_kotlin_kotlin_stdlib",
    "@maven//:com_squareup_okio_okio_jvm",
    "@maven//:org_antlr_antlr4_runtime",
    "@maven//:com_apollographql_apollo3_apollo_api",
    "@maven//:com_apollographql_apollo3_apollo_api_jvm",
    "@maven//:com_squareup_kotlinpoet",
    "//src/main/java/com/example/compiler:compiler_main",
]

def _expand_loc_with_sep(deps, sep):
    paths = []
    for dep in deps:
        paths.append("$(location %s)" % dep)
    return sep.join(paths)

def compiler(
        name,
        graphql_file,
        graphqls_file,
        srcs = [],
        deps = [],
        classpath_sep = ":"):

    if graphql_file == None or len(graphql_file) == 0 or graphqls_file == None or len(graphqls_file) == 0:
        fail("input not provided")

    scrooge_runtime_cp = _expand_loc_with_sep(_scrooge_runtime_deps, classpath_sep)
    graphql_str = _expand_loc_with_sep(graphql_file, " ")
    graphqls_str = _expand_loc_with_sep(graphqls_file, " ")
    thrift_srcjar_rule_name = "%s_srcjar__generated" % name
    native.genrule(
        name = thrift_srcjar_rule_name,
        srcs = graphql_file + graphqls_file,
        outs = ["%s.srcjar" % name],  # magic extension for rule below
        tools = ["//src/main/java/com/example/compiler"] + _scrooge_runtime_deps,
        cmd = "$(location //src/main/java/com/example/compiler) '%s' '%s' $(JAVABASE) $@ '%s'" %
              (scrooge_runtime_cp, graphql_str, graphqls_str),
        visibility = ["//visibility:public"],
        toolchains = ["@bazel_tools//tools/jdk:current_host_java_runtime"],  # so that JAVABASE is computed
    )

    # Compile the generated sources
#    native.java_library(
#        name = name,
#        srcs = [thrift_srcjar_rule_name] + srcs,
#        deps = deps,
#        visibility = ["//visibility:public"],
#    )

    kt_jvm_library(
        name = name,
        srcs = [thrift_srcjar_rule_name] + srcs,
        deps = deps,
        visibility = ["//visibility:public"],
    )