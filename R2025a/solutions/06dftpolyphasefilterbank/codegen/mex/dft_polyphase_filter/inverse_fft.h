/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * inverse_fft.h
 *
 * Code generation for function 'inverse_fft'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void inverse_fft(const emlrtStack *sp, const cint32_T X[128000],
                 cint32_T Y[128000]);

/* End of code generation (inverse_fft.h) */
