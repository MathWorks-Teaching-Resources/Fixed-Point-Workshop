/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * dft_polyphase_filter_initialize.c
 *
 * Code generation for function 'dft_polyphase_filter_initialize'
 *
 */

/* Include files */
#include "dft_polyphase_filter_initialize.h"
#include "_coder_dft_polyphase_filter_mex.h"
#include "dft_polyphase_filter_data.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtMCInfo emlrtMCI = {
    -1, /* lineNo */
    -1, /* colNo */
    "", /* fName */
    ""  /* pName */
};

/* Function Declarations */
static const mxArray *b_numerictype(const emlrtStack *sp,
                                    emlrtMCInfo *location);

static void dft_polyphase_filter_once(const emlrtStack *sp);

static const mxArray *fimath(const emlrtStack *sp, const char_T *s,
                             const char_T *s1, const char_T *s2,
                             const char_T *s3, const char_T *s4,
                             const char_T *s5, real_T d, real_T d1,
                             emlrtMCInfo *location);

static const mxArray *numerictype(const emlrtStack *sp, real_T d, real_T d1,
                                  real_T d2, real_T d3, real_T d4,
                                  emlrtMCInfo *location);

/* Function Definitions */
static const mxArray *b_numerictype(const emlrtStack *sp, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  pArrays[0] = emlrtCreateStringR2022a((emlrtCTX)sp, "WordLength");
  pArrays[1] = emlrtCreateDoubleScalar(18.0);
  return emlrtCallMATLABR2012b((emlrtConstCTX)sp, 1, &m, 2, &pArrays[0],
                               "numerictype", true, location);
}

static void dft_polyphase_filter_once(const emlrtStack *sp)
{
  mex_InitInfAndNan();
  emlrtAssignP(&i_eml_mx, NULL);
  emlrtAssignP(&h_eml_mx, NULL);
  emlrtAssignP(&g_eml_mx, NULL);
  emlrtAssignP(&f_eml_mx, NULL);
  emlrtAssignP(&e_eml_mx, NULL);
  emlrtAssignP(&d_eml_mx, NULL);
  emlrtAssignP(&c_eml_mx, NULL);
  emlrtAssignP(&b_eml_mx, NULL);
  emlrtAssignP(&eml_mx, NULL);
  emlrtAssignP(&i_eml_mx, numerictype(sp, 18.0, 14.0, 14.0, 6.103515625E-5,
                                      -14.0, &emlrtMCI));
  emlrtAssignP(&h_eml_mx, b_numerictype(sp, &emlrtMCI));
  emlrtAssignP(&g_eml_mx,
               fimath(sp, "nearest", "Nearest", "saturate", "Saturate",
                      "FullPrecision", "FullPrecision", 32.0, 32.0, &emlrtMCI));
  emlrtAssignP(&f_eml_mx, fimath(sp, "floor", "Floor", "wrap", "Wrap",
                                 "KeepLSB", "KeepLSB", 36.0, 36.0, &emlrtMCI));
  emlrtAssignP(&e_eml_mx, numerictype(sp, 18.0, 16.0, 16.0, 1.52587890625E-5,
                                      -16.0, &emlrtMCI));
  emlrtAssignP(&d_eml_mx,
               numerictype(sp, 39.0, 37.0, 37.0, 7.2759576141834259E-12, -37.0,
                           &emlrtMCI));
  emlrtAssignP(&c_eml_mx, numerictype(sp, 14.0, 12.0, 12.0, 0.000244140625,
                                      -12.0, &emlrtMCI));
  emlrtAssignP(&b_eml_mx, numerictype(sp, 14.0, 17.0, 17.0, 7.62939453125E-6,
                                      -17.0, &emlrtMCI));
  emlrtAssignP(&eml_mx, fimath(sp, "floor", "Floor", "wrap", "Wrap", "KeepLSB",
                               "KeepLSB", 36.0, 39.0, &emlrtMCI));
  emlrtCheckDefaultFimathR2008b(&g_eml_mx);
}

static const mxArray *fimath(const emlrtStack *sp, const char_T *s,
                             const char_T *s1, const char_T *s2,
                             const char_T *s3, const char_T *s4,
                             const char_T *s5, real_T d, real_T d1,
                             emlrtMCInfo *location)
{
  const mxArray *pArrays[42];
  const mxArray *m;
  pArrays[0] = emlrtCreateStringR2022a((emlrtCTX)sp, "RoundMode");
  pArrays[1] = emlrtCreateStringR2022a((emlrtCTX)sp, s);
  pArrays[2] = emlrtCreateStringR2022a((emlrtCTX)sp, "RoundingMethod");
  pArrays[3] = emlrtCreateStringR2022a((emlrtCTX)sp, s1);
  pArrays[4] = emlrtCreateStringR2022a((emlrtCTX)sp, "OverflowMode");
  pArrays[5] = emlrtCreateStringR2022a((emlrtCTX)sp, s2);
  pArrays[6] = emlrtCreateStringR2022a((emlrtCTX)sp, "OverflowAction");
  pArrays[7] = emlrtCreateStringR2022a((emlrtCTX)sp, s3);
  pArrays[8] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductMode");
  pArrays[9] = emlrtCreateStringR2022a((emlrtCTX)sp, s4);
  pArrays[10] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumMode");
  pArrays[11] = emlrtCreateStringR2022a((emlrtCTX)sp, s5);
  pArrays[12] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductWordLength");
  pArrays[13] = emlrtCreateDoubleScalar(d);
  pArrays[14] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumWordLength");
  pArrays[15] = emlrtCreateDoubleScalar(d1);
  pArrays[16] = emlrtCreateStringR2022a((emlrtCTX)sp, "MaxProductWordLength");
  pArrays[17] = emlrtCreateDoubleScalar(65535.0);
  pArrays[18] = emlrtCreateStringR2022a((emlrtCTX)sp, "MaxSumWordLength");
  pArrays[19] = emlrtCreateDoubleScalar(65535.0);
  pArrays[20] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductFractionLength");
  pArrays[21] = emlrtCreateDoubleScalar(30.0);
  pArrays[22] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductFixedExponent");
  pArrays[23] = emlrtCreateDoubleScalar(-30.0);
  pArrays[24] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumFractionLength");
  pArrays[25] = emlrtCreateDoubleScalar(30.0);
  pArrays[26] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumFixedExponent");
  pArrays[27] = emlrtCreateDoubleScalar(-30.0);
  pArrays[28] =
      emlrtCreateStringR2022a((emlrtCTX)sp, "SumSlopeAdjustmentFactor");
  pArrays[29] = emlrtCreateDoubleScalar(1.0);
  pArrays[30] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumBias");
  pArrays[31] = emlrtCreateDoubleScalar(0.0);
  pArrays[32] =
      emlrtCreateStringR2022a((emlrtCTX)sp, "ProductSlopeAdjustmentFactor");
  pArrays[33] = emlrtCreateDoubleScalar(1.0);
  pArrays[34] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductBias");
  pArrays[35] = emlrtCreateDoubleScalar(0.0);
  pArrays[36] = emlrtCreateStringR2022a((emlrtCTX)sp, "CastBeforeSum");
  pArrays[37] = emlrtCreateLogicalScalar(true);
  pArrays[38] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumSlope");
  pArrays[39] = emlrtCreateDoubleScalar(9.3132257461547852E-10);
  pArrays[40] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductSlope");
  pArrays[41] = emlrtCreateDoubleScalar(9.3132257461547852E-10);
  return emlrtCallMATLABR2012b((emlrtConstCTX)sp, 1, &m, 42, &pArrays[0],
                               "fimath", true, location);
}

static const mxArray *numerictype(const emlrtStack *sp, real_T d, real_T d1,
                                  real_T d2, real_T d3, real_T d4,
                                  emlrtMCInfo *location)
{
  const mxArray *pArrays[10];
  const mxArray *m;
  pArrays[0] = emlrtCreateStringR2022a((emlrtCTX)sp, "WordLength");
  pArrays[1] = emlrtCreateDoubleScalar(d);
  pArrays[2] = emlrtCreateStringR2022a((emlrtCTX)sp, "FractionLength");
  pArrays[3] = emlrtCreateDoubleScalar(d1);
  pArrays[4] = emlrtCreateStringR2022a((emlrtCTX)sp, "BinaryPoint");
  pArrays[5] = emlrtCreateDoubleScalar(d2);
  pArrays[6] = emlrtCreateStringR2022a((emlrtCTX)sp, "Slope");
  pArrays[7] = emlrtCreateDoubleScalar(d3);
  pArrays[8] = emlrtCreateStringR2022a((emlrtCTX)sp, "FixedExponent");
  pArrays[9] = emlrtCreateDoubleScalar(d4);
  return emlrtCallMATLABR2012b((emlrtConstCTX)sp, 1, &m, 10, &pArrays[0],
                               "numerictype", true, location);
}

void dft_polyphase_filter_initialize(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2022b(&st);
  emlrtClearAllocCountR2012b(&st, false, 3U, "ForceOff");
  emlrtEnterRtStackR2012b(&st);
  emlrtLicenseCheckR2022a(&st, "EMLRT:runTime:MexFunctionNeedsLicense",
                          "fixed_point_toolbox", 2);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    dft_polyphase_filter_once(&st);
  }
}

/* End of code generation (dft_polyphase_filter_initialize.c) */
