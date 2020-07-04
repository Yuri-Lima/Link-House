#include "Homefi_Crypto.h"
#include "Arduino.h"
#include "stdarg.h"


double crypto::deriv(float x, float p) {
  uint16_t ex_deriv = pow(x, p - 1);
  r_deriv = ex_deriv * p;
  return r_deriv;
}

void crypto::deriv_func(char f, char g) {
  uint8_t func_deriv = (f * g - f * g) / pow(g, 2);
}
















