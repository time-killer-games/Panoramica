#include <cmath>

#if defined(_WIN32)
#define EXPORTED_FUNCTION extern "C" __declspec(dllexport)
#else
#define EXPORTED_FUNCTION extern "C" __attribute__((visibility("default")))
#endif

#ifndef M_PI
#define M_PI 3.14159265358979323846264338327950288
#endif

EXPORTED_FUNCTION double tand(double x) { 
  return tan(x * M_PI / 180.0);
}

EXPORTED_FUNCTION double atand2(double y, double x) {
  return atan2(y, x) * 180.0 / M_PI;
}
