/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * dft_polyphase_filter_terminate.c
 *
 * Code generation for function 'dft_polyphase_filter_terminate'
 *
 */

/* Include files */
#include "dft_polyphase_filter_terminate.h"
#include "_coder_dft_polyphase_filter_mex.h"
#include "dft_polyphase_filter_data.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static void emlrtExitTimeCleanupDtorFcn(const void *r);

/* Function Definitions */
static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void dft_polyphase_filter_atexit(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtPushHeapReferenceStackR2021a(
      &st, false, NULL, (void *)&emlrtExitTimeCleanupDtorFcn, NULL, NULL, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  emlrtDestroyArray(&eml_mx);
  emlrtDestroyArray(&b_eml_mx);
  emlrtDestroyArray(&c_eml_mx);
  emlrtDestroyArray(&d_eml_mx);
  emlrtDestroyArray(&e_eml_mx);
  emlrtDestroyArray(&f_eml_mx);
  emlrtDestroyArray(&g_eml_mx);
  emlrtDestroyArray(&h_eml_mx);
  emlrtDestroyArray(&i_eml_mx);
}

void dft_polyphase_filter_terminate(void)
{
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (dft_polyphase_filter_terminate.c) */
