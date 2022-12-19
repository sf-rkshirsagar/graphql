package com.example;

public class Main {
    public static void main(String[] args) {
        // Uncomment and run:
        // bazel build //src/main/java/com/example:compiler
        // bazel build //src/main/java/com/example:example_gql


        // THIS IS WHERE IT ALL FAILS WHEN GENERATED CLASSES ARE USED ->
        // UNCOMMENT THESE LINES:

        // new com.example.LaunchListQuery();
        // new LaunchListQuery();
        // new com.example.apollo.LaunchListQuery();
    }
}
