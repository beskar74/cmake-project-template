#include <iostream>
#include <lib/init.hpp>

void Init() {
#ifdef NDEBUG
  std::cerr << "Running Release build. NDEBUG defined. Assertions are disabled."
            << std::endl;
#else
  std::cerr
      << "Running Debug build. NDEBUG not defined. Assertions are enabled."
      << std::endl;
#endif

  int check{0};
#ifdef HAVE_BOOST_DEBUG
  check++;
  std::cerr << "Using Boost Debug" << std::endl;
#endif
#ifdef HAVE_BOOST_RELEASE
  check++;
  std::cerr << "Using Boost Release" << std::endl;
#endif
  if (check >= 2)
    throw std::runtime_error(
        "Detected both boost-debug and boost-release. Something is linked"
        "wrongly");

  std::cerr << "Version=" << VERSION << std::endl;
}