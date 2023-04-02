#include <gtest/gtest.h>

#include <lib/hello.hpp>

TEST(Hello, Hello) {
  using namespace beskar::lib;
  hello();
  ASSERT_TRUE(42 == 42);
}