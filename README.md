# cmake-project-template

A Cmake project template that makes it easy to quickly start working on a C++ project.

The project:

- Statically links against minimal version of [Boost](https://www.boost.org/) with the most useful libraries. Feel free
  to change which libraries are built and linked in `build_boost.sh`.
- Statically links against [HdrHistogram\_c](https://github.com/HdrHistogram/HdrHistogram_c).
- Statically links against [Google Benchmark](https://github.com/google/benchmark) and [Google Test](https://github.com/google/googletest). We use the Google Test that Google Benchmark uses.
  See `build_test.sh`.
- Uses `clang++` and `C++20` for everything. It works out of the box on both Linux and BSD systems.
- Provides an easy way to setup tests and benchmarks:
    - If you want to write a test for `file.cpp`, then create `file.test.cpp`, write your tests and then run them
      from `./build/src/test`. All project tests are run by `./build/src/test` that is built from `src/main.test.cpp`.
    - If you want to write a benchmark for `file.cpp`, then create `file.bm.cpp`, `link_benchmark` against it and then
      you can run it after building the project. All benchmarks have a separate binary i.e. there is a target built for
      each `*.bm.cpp` file. See `lib/CMakeLists.txt` for an example.
- Supports both `Release` and `Debug` targets and ensures that the statically linked libraries are built in the same
  way. That means we are actually building two versions of each library: `libname-release.a` and `libname-debug.a`.
- Adheres to [Google's C++ Style Guide](https://google.github.io/styleguide/cppguide.html). See `.clang-format`.

To build your targets in `Debug` mode:

```bash
$ mkdir build
$ cd build
$ cmake ../
$ make
```

To build your targets in `Release` mode:

```bash
$ mkdir build_rel
$ cd build_rel
$ cmake -DCMAKE_BUILD_TYPE=Release ../
$ make
```

