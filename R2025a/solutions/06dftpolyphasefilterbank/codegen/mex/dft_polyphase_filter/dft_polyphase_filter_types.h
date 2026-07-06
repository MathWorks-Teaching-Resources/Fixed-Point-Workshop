/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * dft_polyphase_filter_types.h
 *
 * Code generation for function 'dft_polyphase_filter'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "emlrt.h"

/* Type Definitions */
#ifndef typedef_struct2_T
#define typedef_struct2_T
typedef struct {
  cint32_T x;
  cint32_T w;
} struct2_T;
#endif /* typedef_struct2_T */

#ifndef typedef_struct1_T
#define typedef_struct1_T
typedef struct {
  int16_T coeff;
  cint64_T acc;
  cint16_T x;
  cint32_T y;
  cint16_T z;
} struct1_T;
#endif /* typedef_struct1_T */

#ifndef typedef_struct0_T
#define typedef_struct0_T
typedef struct {
  struct1_T fir_filter;
  struct2_T fft;
} struct0_T;
#endif /* typedef_struct0_T */

#ifndef typedef_b_dft_polyphase_filter
#define typedef_b_dft_polyphase_filter
typedef struct {
  cint32_T X[128000];
  cint32_T Y[128000];
} b_dft_polyphase_filter;
#endif /* typedef_b_dft_polyphase_filter */

#ifndef c_typedef_b_dft_polyphase_filte
#define c_typedef_b_dft_polyphase_filte
typedef struct {
  cint16_T U[128000];
  int32_T magnitudeY[128000];
  int32_T angleY[128000];
} b_dft_polyphase_filter_api;
#endif /* c_typedef_b_dft_polyphase_filte */

#ifndef c_typedef_dft_polyphase_filterS
#define c_typedef_dft_polyphase_filterS
typedef struct {
  b_dft_polyphase_filter f0;
  b_dft_polyphase_filter_api f1;
} dft_polyphase_filterStackData;
#endif /* c_typedef_dft_polyphase_filterS */

/* End of code generation (dft_polyphase_filter_types.h) */
