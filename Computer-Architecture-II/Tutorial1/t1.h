#pragma once

//extern "C" int bias;
extern "C" int _cdecl poly(int);   // _cdecl calling convention
extern "C" int _cdecl multiple_k_asm(uint16_t, uint16_t, uint16_t array[]);   // _cdecl calling convention
extern "C" int _cdecl factorial(int);
// eof

