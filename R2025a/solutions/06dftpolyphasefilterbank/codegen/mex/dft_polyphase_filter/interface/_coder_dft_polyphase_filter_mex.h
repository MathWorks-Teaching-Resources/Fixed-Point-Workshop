/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * _coder_dft_polyphase_filter_mex.h
 *
 * Code generation for function '_coder_dft_polyphase_filter_mex'
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
void dft_polyphase_filter_mexFunction(dft_polyphase_filterStackData *SD,
                                      int32_T nlhs, mxArray *plhs[2],
                                      int32_T nrhs, const mxArray *prhs[3]);

MEXFUNCTION_LINKAGE void mexFunction(int32_T nlhs, mxArray *plhs[],
                                     int32_T nrhs, const mxArray *prhs[]);

emlrtCTX mexFunctionCreateRootTLS(void);

/* End of code generation (_coder_dft_polyphase_filter_mex.h) */
