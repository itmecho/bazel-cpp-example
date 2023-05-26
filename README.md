# Bazel C++ Example

This repo is to show bazel not working when run in a nix shell on MacOS.

## Proving it works normally
Download [bazelisk](https://github.com/bazelbuild/bazelisk) and run the following command in this repo:
```sh
bazelisk run //:hello
```

It should build and run successfully.

## Failing when run under nix
Run the following command to get a nix development environment with bazel:
```
nix develop --experimental-features 'nix-command flakes'
```

Now in the nix shell, run the following command

```sh
bazel run //:hello
```

It gives the following error which I think is caused by it using `clang` instead of `clang++`.

```
Starting local Bazel server and connecting to it...
INFO: Analyzed target //:hello (37 packages loaded, 169 targets configured).
INFO: Found 1 target...
ERROR: <HOME>/src/bazel-c-example/BUILD.bazel:1:10: Compiling main.cc failed: (Exit 1): cc_wrapper.sh failed: error executing command external/local_config_cc/cc_wrapper.sh -U_FORTIFY_SOURCE -fstack-protector -Wall -Wthread-safety -Wself-assign -fcolor-diagnostics -fno-omit-frame-pointer '-std=c++0x' -MD -MF ... (remaining 20 arguments skipped)

Use --sandbox_debug to see verbose messages from the sandbox and retain the sandbox build root for debugging
main.cc:1:10: fatal error: 'iostream' file not found
#include <iostream>
         ^~~~~~~~~~
1 error generated.
Target //:hello failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 14.652s, Critical Path: 0.18s
INFO: 3 processes: 3 internal.
FAILED: Build did NOT complete successfully
FAILED: Build did NOT complete successfully
```

You can also try running it and forcing it to use a c++ only toolchain like this but it gives the same error:
```sh
export BAZEL_USE_CPP_ONLY_TOOLCHAIN=1
bazel run //:hello
```
