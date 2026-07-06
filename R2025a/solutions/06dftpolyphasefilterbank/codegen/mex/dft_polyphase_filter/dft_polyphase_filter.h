/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * dft_polyphase_filter.h
 *
 * Code generation for function 'dft_polyphase_filter'
 *
 */

#pragma once

/* Include files */
#include "dft_polyphase_filter_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void dft_polyphase_filter(dft_polyphase_filterStackData *SD,
                          const emlrtStack *sp, const int16_T B[256],
                          const cint16_T U[128000], const struct0_T *T,
                          int32_T magnitudeY[128000], int32_T angleY[128000]);

/* End of code generation (dft_polyphase_filter.h) */
