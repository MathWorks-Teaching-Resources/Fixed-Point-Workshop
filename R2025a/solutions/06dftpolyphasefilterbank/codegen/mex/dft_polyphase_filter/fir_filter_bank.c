/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * fir_filter_bank.c
 *
 * Code generation for function 'fir_filter_bank'
 *
 */

/* Include files */
#include "fir_filter_bank.h"
#include "dft_polyphase_filter_data.h"
#include "rt_nonfinite.h"
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo d_emlrtRSI = {
    11,                /* lineNo */
    "fir_filter_bank", /* fcnName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "fir_filter_b"
    "ank.m" /* pathName */
};

/* Function Definitions */
void fir_filter_bank(const emlrtStack *sp, const int16_T B[256],
                     const cint16_T U[128000], cint32_T X[128000])
{
  static const int64_T im = 0L;
  static const int64_T re = 0L;
  emlrtStack st;
  cint16_T Z[256];
  int32_T i;
  int32_T j;
  int32_T n;
  int16_T P[32];
  st.prev = sp;
  st.tls = sp->tls;
  /*  M = Number of channels in the filter bank. */
  /*  N = Number of taps in each FIR filter. */
  memset(&P[0], 0, 32U * sizeof(int16_T));
  memset(&Z[0], 0, 256U * sizeof(cint16_T));
  for (i = 0; i < 32; i++) {
    cint32_T icv1[4000];
    cint16_T icv[8];
    int16_T a;
    st.site = &d_emlrtRSI;
    for (n = 0; n < 8; n++) {
      icv[n] = Z[i + (n << 5)];
    }
    a = P[i];
    /* FIR_FILTER_CIRCULAR_BUFFER Finite impulse response filter with circular
     * buffer. */
    /*  */
    /*     [y,z,p] = fir_filter_circular_buffer(b,x,z,p,T) */
    /*     filters the data in vector x using an efficient circular buffer */
    /*     implementation with the filter described by vector b to create the */
    /*     filtered data y. */
    /*  */
    /*     The coefficients, b, are the same as used in the MATLAB function
     * filter(b,1,...). */
    /*  */
    /*     Output y(n) is equal to */
    /*   */
    /*       y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(nb)*x(n-nb+1) */
    /*  */
    /*     The states are stored in a circular buffer, z, which should be */
    /*     the same size as b.  For all zero initial states, initialize z as */
    /*      */
    /*       z = zeros(size(b)); */
    /*  */
    /*     The circular buffer position index p should be initialized to  */
    /*  */
    /*       p = 0; */
    /*  */
    /*     Example: */
    /*  */
    /*       T = fir_filter_double_types([]); */
    /*       b = cast(fir1(16,0.25),'like',T.coeff); */
    /*       t = linspace(0,10*pi,256); */
    /*       x = cast(sin(pi*0.0625*t.^2),'like',T.x); */
    /*       z = cast(zeros(size(b)),'like',T.z); */
    /*       p = cast(0,'like',T.p); */
    /*       y0 = filter(b,1,x); */
    /*       y1 = fir_filter_circular_buffer(b,x,z,p,T); */
    /*       clf */
    /*       subplot(2,1,1) */
    /*       plot(t,x,t,y0,t,y1) */
    /*       legend('Input','Builtin filter','Reverse coefficients filter') */
    /*       subplot(2,1,2) */
    /*       plot(t,double(y0)-double(y1)) */
    /*       legend('Difference') */
    /*  Copyright 2018 The MathWorks, Inc. */
    for (n = 0; n < 4000; n++) {
      int64_T acc_im;
      int64_T acc_re;
      int16_T k;
      /*  power of 2 */
      a = (int16_T)((a & 7) + 1);
      icv[a - 1] = U[i + (n << 5)];
      acc_re = re;
      acc_im = im;
      k = a;
      for (j = 0; j < 8; j++) {
        int64_T i1;
        int16_T b_i;
        /*  power of 2 */
        k = (int16_T)((k & 7) + 1);
        b_i = B[i + ((7 - j) << 5)];
        i1 = acc_re + ((int64_T)(b_i * icv[k - 1].re) << 8);
        if ((i1 & 274877906944L) != 0L) {
          acc_re = i1 | -274877906944L;
        } else {
          acc_re = i1 & 274877906943L;
        }
        i1 = acc_im + ((int64_T)(b_i * icv[k - 1].im) << 8);
        if ((i1 & 274877906944L) != 0L) {
          acc_im = i1 | -274877906944L;
        } else {
          acc_im = i1 & 274877906943L;
        }
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(&st);
        }
      }
      icv1[n].re = (int32_T)(acc_re >> 21);
      icv1[n].im = (int32_T)(acc_im >> 21);
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }
    for (n = 0; n < 4000; n++) {
      X[i + (n << 5)] = icv1[n];
    }
    for (n = 0; n < 8; n++) {
      Z[i + (n << 5)] = icv[n];
    }
    P[i] = a;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtConstCTX)sp);
    }
  }
}

/* End of code generation (fir_filter_bank.c) */
