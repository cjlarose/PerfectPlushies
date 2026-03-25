# Contributing

## Prerequisites

The project requires JDK 17. A [Nix flake](flake.nix) is provided with a dev shell that supplies it:

```sh
nix develop
```

Alternatively, set the `JAVA_17_HOME` environment variable to your JDK 17 installation.

## Building

```sh
./gradlew :Fabric:remapJar   # Fabric
./gradlew :Forge:jar         # Forge
```

Output jars are written to `Fabric/build/libs/` and `Forge/build/libs/`.

## Developing against a local PerfectPlushieAPI

By default, PerfectPlushieAPI is resolved from Maven. To build against a local checkout of the API instead:

**1. Publish the API to your local Maven cache.**

In your local [PerfectPlushieAPI](https://github.com/Nyfaria/PerfectPlushieAPI) checkout:

```sh
./gradlew publishToMavenLocal
```

**2. Create `local.settings.gradle` in this repo's root.**

This file is gitignored and opts your local build into resolving from `~/.m2`:

```groovy
gradle.allprojects {
    repositories {
        mavenLocal()
    }
}
```

**3. Update `plushie_api_version` in `gradle.properties`** to match the version you published.

**4. Build with a clean Fabric project** to prevent a stale embedded API jar:

```sh
./gradlew :Fabric:clean :Fabric:remapJar
```

The clean step is necessary because Fabric embeds the API jar (Jar-in-Jar), and Gradle's incremental build will reuse a previously embedded version if you don't clean first.

Repeat steps 1 and 4 each time you make changes to the API.
