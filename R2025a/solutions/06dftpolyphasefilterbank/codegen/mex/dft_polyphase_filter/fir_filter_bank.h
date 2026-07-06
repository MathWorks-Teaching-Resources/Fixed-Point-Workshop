/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * fir_filter_bank.h
 *
 * Code generation for function 'fir_filter_bank'
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
void fir_filter_bank(const emlrtStack *sp, const int16_T B[256],
                     const cint16_T U[128000], cint32_T X[128000]);

/* End of code generation (fir_filter_bank.h) */
