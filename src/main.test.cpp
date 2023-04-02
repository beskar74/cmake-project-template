#include <gtest/gtest.h>

#include <lib/init.hpp>

int main(int argc, char *argv[]) {
  Init();

  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
