#ifndef Homefi_Crypto
#define Homefi_Crypto
#include "Arduino.h"

class crypto {
  public:
    double deriv(float x, float p);
    void deriv_func(char f, char g);

    void clear();



  private:
    uint32_t r_deriv;
    uint8_t p;
    uint8_t rounds;
    uint8_t posn;
};
#endif





































