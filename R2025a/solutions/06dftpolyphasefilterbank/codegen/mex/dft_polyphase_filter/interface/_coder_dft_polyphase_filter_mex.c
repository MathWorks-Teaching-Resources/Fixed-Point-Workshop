/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * _coder_dft_polyphase_filter_mex.c
 *
 * Code generation for function '_coder_dft_polyphase_filter_mex'
 *
 */

/* Include files */
#include "_coder_dft_polyphase_filter_mex.h"
#include "_coder_dft_polyphase_filter_api.h"
#include "dft_polyphase_filter_data.h"
#include "dft_polyphase_filter_initialize.h"
#include "dft_polyphase_filter_terminate.h"
#include "dft_polyphase_filter_types.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void dft_polyphase_filter_mexFunction(dft_polyphase_filterStackData *SD,
                                      int32_T nlhs, mxArray *plhs[2],
                                      int32_T nrhs, const mxArray *prhs[3])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *outputs[2];
  int32_T i;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 3, 4,
                        20, "dft_polyphase_filter");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 20,
                        "dft_polyphase_filter");
  }
  /* Call the function. */
  dft_polyphase_filter_api(SD, prhs, nlhs, outputs);
  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    i = 1;
  } else {
    i = nlhs;
  }
  emlrtReturnArrays(i, &plhs[0], &outputs[0]);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  dft_polyphase_filterStackData *c_dft_polyphase_filterStackData = NULL;
  c_dft_polyphase_filterStackData =
      (dft_polyphase_filterStackData *)emlrtMxCalloc(
          (size_t)1, (size_t)1U * sizeof(dft_polyphase_filterStackData));
  mexAtExit(&dft_polyphase_filter_atexit);
  /* Module initialization. */
  dft_polyphase_filter_initialize();
  /* Dispatch the entry-point. */
  dft_polyphase_filter_mexFunction(c_dft_polyphase_filterStackData, nlhs, plhs,
                                   nrhs, prhs);
  /* Module termination. */
  dft_polyphase_filter_terminate();
  emlrtMxFree(c_dft_polyphase_filterStackData);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL, "UTF-8", true);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_dft_polyphase_filter_mex.c) */
