/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * dft_polyphase_filter.c
 *
 * Code generation for function 'dft_polyphase_filter'
 *
 */

/* Include files */
#include "dft_polyphase_filter.h"
#include "dft_polyphase_filter_data.h"
#include "dft_polyphase_filter_types.h"
#include "fir_filter_bank.h"
#include "inverse_fft.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = {
    2,                      /* lineNo */
    "dft_polyphase_filter", /* fcnName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "dft_polyphas"
    "e_filter.m" /* pathName */
};

static emlrtRSInfo b_emlrtRSI = {
    3,                      /* lineNo */
    "dft_polyphase_filter", /* fcnName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "dft_polyphas"
    "e_filter.m" /* pathName */
};

static emlrtRSInfo c_emlrtRSI = {
    4,                      /* lineNo */
    "dft_polyphase_filter", /* fcnName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "dft_polyphas"
    "e_filter.m" /* pathName */
};

static emlrtRSInfo v_emlrtRSI = {
    10,                /* lineNo */
    "cordic_cart2pol", /* fcnName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "cordic_cart2"
    "pol.m" /* pathName */
};

/* Function Definitions */
void dft_polyphase_filter(dft_polyphase_filterStackData *SD,
                          const emlrtStack *sp, const int16_T B[256],
                          const cint16_T U[128000], const struct0_T *T,
                          int32_T magnitudeY[128000], int32_T angleY[128000])
{
  static const uint32_T a[17] = {102944U, 60771U, 32110U, 16299U, 8181U, 4095U,
                                 2048U,   1024U,  512U,   256U,   128U,  64U,
                                 32U,     16U,    8U,     4U,     2U};
  emlrtStack b_st;
  emlrtStack st;
  int32_T i;
  int32_T n;
  (void)T;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  st.site = &emlrtRSI;
  fir_filter_bank(&st, B, U, SD->f0.X);
  st.site = &b_emlrtRSI;
  inverse_fft(&st, SD->f0.X, SD->f0.Y);
  st.site = &c_emlrtRSI;
  for (i = 0; i < 128000; i++) {
    int32_T a0;
    int32_T a1;
    int32_T a__1;
    int32_T b0;
    int32_T b_yn;
    a1 = SD->f0.Y[i].re >> 1;
    a__1 = SD->f0.Y[i].im >> 1;
    b_st.site = &v_emlrtRSI;
    a0 = 0;
    if (a1 < 0) {
      /*  Compensation for 3rd and 4th quadrants */
      if ((-a1 & 131072) != 0) {
        a1 = -a1 | -131072;
      } else {
        a1 = -a1 & 131071;
      }
      if ((-a__1 & 131072) != 0) {
        a__1 = -a__1 | -131072;
      } else {
        a__1 = -a__1 & 131071;
      }
      b0 = 51471;
    } else {
      b0 = 0;
    }
    for (n = 0; n < 17; n++) {
      int32_T xn;
      xn = a1 >> n;
      b_yn = a__1 >> n;
      if (a__1 < 0) {
        /*  Counter-clockwise rotation */
        b_yn = a1 - b_yn;
        if ((b_yn & 131072) != 0) {
          a1 = b_yn | -131072;
        } else {
          a1 = b_yn & 131071;
        }
        b_yn = a__1 + xn;
        if ((b_yn & 131072) != 0) {
          a__1 = b_yn | -131072;
        } else {
          a__1 = b_yn & 131071;
        }
        b_yn = a0 - (int32_T)(a[n] >> 3);
        if ((b_yn & 131072) != 0) {
          a0 = b_yn | -131072;
        } else {
          a0 = b_yn & 131071;
        }
      } else {
        /*  Clockwise rotation */
        b_yn += a1;
        if ((b_yn & 131072) != 0) {
          a1 = b_yn | -131072;
        } else {
          a1 = b_yn & 131071;
        }
        b_yn = a__1 - xn;
        if ((b_yn & 131072) != 0) {
          a__1 = b_yn | -131072;
        } else {
          a__1 = b_yn & 131071;
        }
        b_yn = a0 + (int32_T)(a[n] >> 3);
        if ((b_yn & 131072) != 0) {
          a0 = b_yn | -131072;
        } else {
          a0 = b_yn & 131071;
        }
      }
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&b_st);
      }
    }
    b_yn = a0 + b0;
    if ((b_yn & 131072) != 0) {
      angleY[i] = b_yn | -131072;
    } else {
      angleY[i] = b_yn & 131071;
    }
    magnitudeY[i] = (int32_T)((a1 * 79593L) >> 17);
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }
}

/* End of code generation (dft_polyphase_filter.c) */
