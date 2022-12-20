#!/bin/bash

echo "HERE"

# This script runs Scrooge (https://git.soma.salesforce.com/servicelibs/scrooge)
# and builds a jar of the generated Thrift stubs

# The classpath to use when running Scrooge
SCROOGE_RUNTIME_CLASSPATH=$1

# The Thrift IDLs, space separated, to compile
GRAPHQL=$2

GRAPHQLS=$5

# JDK used by Bazel to build (aka JDK #2), it may be a relative or absolute path
JAVABASE_PARAM=$3
pushd .
cd $JAVABASE_PARAM
JAVABASE=$(pwd)
popd

# The path/name of the source jar to build
OUTPUT_JAR_PATH=$4


THRIFT_DEST_DIR="apollo"

# Run Scrooge on the specified IDSs
#
# The Scrooge arguments are the same as configured here:
# /projects/libs/servicelibs/srpc/srpc-thrift-svc-parent/MVN-INF/pom.template
$JAVABASE/bin/java -classpath $SCROOGE_RUNTIME_CLASSPATH com.example.compiler.Compiler $THRIFT_DEST_DIR $GRAPHQL $GRAPHQLS

# Build a jar containing the generated Java classes
cd $THRIFT_DEST_DIR
$JAVABASE/bin/jar -cf ../$OUTPUT_JAR_PATH .
cd ..

# Cleanup
#rm -rf $THRIFT_DEST_DIR
