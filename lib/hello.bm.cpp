#include <benchmark/benchmark.h>

static void BM_Add(benchmark::State& state) {
  int i = 0;
  benchmark::DoNotOptimize(i);
  for (auto _ : state) i++;
}

BENCHMARK(BM_Add);
BENCHMARK_MAIN();