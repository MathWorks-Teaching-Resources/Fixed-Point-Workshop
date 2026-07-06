/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * inverse_fft.c
 *
 * Code generation for function 'inverse_fft'
 *
 */

/* Include files */
#include "inverse_fft.h"
#include "dft_polyphase_filter_data.h"
#include "rt_nonfinite.h"
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo k_emlrtRSI = {
    3,             /* lineNo */
    "inverse_fft", /* fcnName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "inverse_fft."
    "m" /* pathName */
};

static emlrtRSInfo l_emlrtRSI = {
    16,            /* lineNo */
    "inverse_fft", /* fcnName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "inverse_fft."
    "m" /* pathName */
};

static emlrtRSInfo m_emlrtRSI = {
    4,                        /* lineNo */
    "radix2fft_with_scaling", /* fcnName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2fft_wi"
    "th_scaling.m" /* pathName */
};

static emlrtRTEInfo emlrtRTEI = {
    13,               /* lineNo */
    15,               /* colNo */
    "radix2twiddles", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2twiddl"
    "es.m" /* pName */
};

static emlrtBCInfo emlrtBCI = {
    1,                /* iFirst */
    31,               /* iLast */
    14,               /* lineNo */
    15,               /* colNo */
    "w",              /* aName */
    "radix2twiddles", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2twiddl"
    "es.m", /* pName */
    3       /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = {
    1,                        /* iFirst */
    32,                       /* iLast */
    12,                       /* lineNo */
    29,                       /* colNo */
    "x",                      /* aName */
    "radix2fft_with_scaling", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2fft_wi"
    "th_scaling.m", /* pName */
    0               /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = {
    1,                        /* iFirst */
    32,                       /* iLast */
    13,                       /* lineNo */
    36,                       /* colNo */
    "x",                      /* aName */
    "radix2fft_with_scaling", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2fft_wi"
    "th_scaling.m", /* pName */
    0               /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = {
    1,                        /* iFirst */
    32,                       /* iLast */
    14,                       /* lineNo */
    36,                       /* colNo */
    "x",                      /* aName */
    "radix2fft_with_scaling", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2fft_wi"
    "th_scaling.m", /* pName */
    0               /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = {
    1,                        /* iFirst */
    32,                       /* iLast */
    14,                       /* lineNo */
    15,                       /* colNo */
    "x",                      /* aName */
    "radix2fft_with_scaling", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2fft_wi"
    "th_scaling.m", /* pName */
    3               /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = {
    1,                        /* iFirst */
    32,                       /* iLast */
    16,                       /* lineNo */
    49,                       /* colNo */
    "x",                      /* aName */
    "radix2fft_with_scaling", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2fft_wi"
    "th_scaling.m", /* pName */
    0               /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = {
    1,                        /* iFirst */
    32,                       /* iLast */
    17,                       /* lineNo */
    42,                       /* colNo */
    "x",                      /* aName */
    "radix2fft_with_scaling", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2fft_wi"
    "th_scaling.m", /* pName */
    0               /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = {
    1,                        /* iFirst */
    32,                       /* iLast */
    18,                       /* lineNo */
    42,                       /* colNo */
    "x",                      /* aName */
    "radix2fft_with_scaling", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2fft_wi"
    "th_scaling.m", /* pName */
    0               /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = {
    1,                        /* iFirst */
    32,                       /* iLast */
    18,                       /* lineNo */
    19,                       /* colNo */
    "x",                      /* aName */
    "radix2fft_with_scaling", /* fName */
    "/Users/tbryan/work/flow/training/workshops/R2024a/"
    "FixedPointMATLABWorkshopR2024a/solutions/06dftpolyphasefilterbank/"
    "radix2fft_wi"
    "th_scaling.m", /* pName */
    3               /* checkKind */
};

/* Function Definitions */
void inverse_fft(const emlrtStack *sp, const cint32_T X[128000],
                 cint32_T Y[128000])
{
  static const cint32_T w[31] = {{
                                     65536, /* re */
                                     0      /* im */
                                 },
                                 {
                                     65536, /* re */
                                     0      /* im */
                                 },
                                 {
                                     0,    /* re */
                                     65536 /* im */
                                 },
                                 {
                                     65536, /* re */
                                     0      /* im */
                                 },
                                 {
                                     46340, /* re */
                                     46340  /* im */
                                 },
                                 {
                                     0,    /* re */
                                     65536 /* im */
                                 },
                                 {
                                     -46341, /* re */
                                     46340   /* im */
                                 },
                                 {
                                     65536, /* re */
                                     0      /* im */
                                 },
                                 {
                                     60547, /* re */
                                     25079  /* im */
                                 },
                                 {
                                     46340, /* re */
                                     46340  /* im */
                                 },
                                 {
                                     25079, /* re */
                                     60547  /* im */
                                 },
                                 {
                                     0,    /* re */
                                     65536 /* im */
                                 },
                                 {
                                     -25080, /* re */
                                     60547   /* im */
                                 },
                                 {
                                     -46341, /* re */
                                     46340   /* im */
                                 },
                                 {
                                     -60548, /* re */
                                     25079   /* im */
                                 },
                                 {
                                     65536, /* re */
                                     0      /* im */
                                 },
                                 {
                                     64276, /* re */
                                     12785  /* im */
                                 },
                                 {
                                     60547, /* re */
                                     25079  /* im */
                                 },
                                 {
                                     54491, /* re */
                                     36409  /* im */
                                 },
                                 {
                                     46340, /* re */
                                     46340  /* im */
                                 },
                                 {
                                     36409, /* re */
                                     54491  /* im */
                                 },
                                 {
                                     25079, /* re */
                                     60547  /* im */
                                 },
                                 {
                                     12785, /* re */
                                     64276  /* im */
                                 },
                                 {
                                     0,    /* re */
                                     65536 /* im */
                                 },
                                 {
                                     -12786, /* re */
                                     64276   /* im */
                                 },
                                 {
                                     -25080, /* re */
                                     60547   /* im */
                                 },
                                 {
                                     -36410, /* re */
                                     54491   /* im */
                                 },
                                 {
                                     -46341, /* re */
                                     46340   /* im */
                                 },
                                 {
                                     -54492, /* re */
                                     36409   /* im */
                                 },
                                 {
                                     -60548, /* re */
                                     25079   /* im */
                                 },
                                 {
                                     -64277, /* re */
                                     12785   /* im */
                                 }};
  static const int8_T iv[5] = {2, 4, 8, 16, 32};
  static const int8_T iv1[5] = {1, 2, 4, 8, 16};
  static const int8_T iv2[5] = {16, 8, 4, 2, 1};
  emlrtStack b_st;
  emlrtStack st;
  int32_T L;
  int32_T b_i;
  int32_T b_j;
  int32_T i;
  int32_T j;
  int32_T k;
  int32_T q;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &k_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  k = 1;
  L = 2;
  while (L <= 32) {
    real_T d;
    d = (real_T)L / 2.0 - 1.0;
    i = (int32_T)(d + 1.0);
    emlrtForLoopVectorCheckR2021a(0.0, 1.0, d, mxDOUBLE_CLASS,
                                  (int32_T)(d + 1.0), &emlrtRTEI, &st);
    for (j = 0; j < i; j++) {
      if (k > 31) {
        emlrtDynamicBoundsCheckR2012b(32, 1, 31, &emlrtBCI, &st);
      }
      k++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }
    L <<= 1;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }
  for (j = 0; j < 4000; j++) {
    int32_T a0_im;
    int32_T a0_re;
    int32_T temp_im;
    int32_T temp_re;
    st.site = &l_emlrtRSI;
    memcpy(&Y[j * 32], &X[j * 32], 32U * sizeof(cint32_T));
    b_st.site = &m_emlrtRSI;
    b_j = 1;
    for (b_i = 0; b_i < 31; b_i++) {
      if (b_i + 1 < b_j) {
        a0_im = j << 5;
        a0_re = (b_j + a0_im) - 1;
        temp_re = Y[a0_re].re;
        temp_im = Y[a0_re].im;
        Y[a0_re] = Y[b_i + a0_im];
        i = b_i + (j << 5);
        Y[i].re = temp_re;
        Y[i].im = temp_im;
      }
      k = 16;
      while (k < b_j) {
        b_j -= k;
        k >>= 1;
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(&b_st);
        }
      }
      b_j += k;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&b_st);
      }
    }
    for (q = 0; q < 5; q++) {
      int32_T L2;
      L = iv[q];
      L2 = iv1[q];
      i = iv2[q] - 1;
      for (k = 0; k <= i; k++) {
        int64_T i2;
        int64_T i3;
        int32_T i1;
        int32_T i4;
        int32_T temp_re_tmp;
        /*  Skip multiply by w^0=1 */
        i1 = k * L;
        b_i = (i1 + L2) + 1;
        if (b_i > 32) {
          emlrtDynamicBoundsCheckR2012b(b_i, 1, 32, &b_emlrtBCI, &st);
        }
        temp_re_tmp = (b_i + (j << 5)) - 1;
        temp_re = Y[temp_re_tmp].re;
        temp_im = Y[temp_re_tmp].im;
        if (i1 + 1 > 32) {
          emlrtDynamicBoundsCheckR2012b(i1 + 1, 1, 32, &c_emlrtBCI, &st);
        }
        b_i = i1 + (j << 5);
        i2 = (int64_T)Y[b_i].re - temp_re;
        i3 = (int64_T)Y[b_i].im - temp_im;
        if ((i2 & 34359738368L) != 0L) {
          i2 |= -34359738368L;
        } else {
          i2 &= 34359738367L;
        }
        i4 = (int32_T)(i2 >> 1);
        if ((i4 & 131072) != 0) {
          Y[temp_re_tmp].re = i4 | -131072;
        } else {
          Y[temp_re_tmp].re = i4 & 131071;
        }
        if ((i3 & 34359738368L) != 0L) {
          i2 = i3 | -34359738368L;
        } else {
          i2 = i3 & 34359738367L;
        }
        i4 = (int32_T)(i2 >> 1);
        if ((i4 & 131072) != 0) {
          Y[temp_re_tmp].im = i4 | -131072;
        } else {
          Y[temp_re_tmp].im = i4 & 131071;
        }
        if (i1 + 1 > 32) {
          emlrtDynamicBoundsCheckR2012b(i1 + 1, 1, 32, &d_emlrtBCI, &st);
        }
        i2 = (int64_T)Y[b_i].re + temp_re;
        i3 = (int64_T)Y[b_i].im + temp_im;
        if (i1 + 1 > 32) {
          emlrtDynamicBoundsCheckR2012b(i1 + 1, 1, 32, &e_emlrtBCI, &st);
        }
        if ((i2 & 34359738368L) != 0L) {
          i2 |= -34359738368L;
        } else {
          i2 &= 34359738367L;
        }
        i4 = (int32_T)(i2 >> 1);
        if ((i4 & 131072) != 0) {
          Y[b_i].re = i4 | -131072;
        } else {
          Y[b_i].re = i4 & 131071;
        }
        if (i1 + 1 > 32) {
          emlrtDynamicBoundsCheckR2012b(i1 + 1, 1, 32, &e_emlrtBCI, &st);
        }
        if ((i3 & 34359738368L) != 0L) {
          i2 = i3 | -34359738368L;
        } else {
          i2 = i3 & 34359738367L;
        }
        i4 = (int32_T)(i2 >> 1);
        if ((i4 & 131072) != 0) {
          Y[b_i].im = i4 | -131072;
        } else {
          Y[b_i].im = i4 & 131071;
        }
        for (b_j = 0; b_j <= L2 - 2; b_j++) {
          int64_T x0_im;
          int64_T x0_re;
          a0_im = L2 + b_j;
          a0_re = w[a0_im].re;
          a0_im = w[a0_im].im;
          b_i = i1 + b_j;
          i4 = (b_i + L2) + 2;
          if (i4 > 32) {
            emlrtDynamicBoundsCheckR2012b(i4, 1, 32, &f_emlrtBCI, &st);
          }
          temp_re_tmp = (i4 + (j << 5)) - 1;
          temp_re = Y[temp_re_tmp].re;
          temp_im = Y[temp_re_tmp].im;
          x0_re = (int64_T)a0_re * temp_re - (int64_T)a0_im * temp_im;
          i2 = (int64_T)a0_re * temp_im + (int64_T)a0_im * temp_re;
          if ((i2 & 34359738368L) != 0L) {
            x0_im = i2 | -34359738368L;
          } else {
            x0_im = i2 & 34359738367L;
          }
          if (b_i + 2 > 32) {
            emlrtDynamicBoundsCheckR2012b(b_i + 2, 1, 32, &g_emlrtBCI, &st);
          }
          i4 = (b_i + (j << 5)) + 1;
          i2 = ((int64_T)Y[i4].re << 16) - x0_re;
          i3 = ((int64_T)Y[i4].im << 16) - x0_im;
          if ((i2 & 34359738368L) != 0L) {
            i2 |= -34359738368L;
          } else {
            i2 &= 34359738367L;
          }
          a0_im = (int32_T)(i2 >> 17);
          if ((a0_im & 131072) != 0) {
            Y[temp_re_tmp].re = a0_im | -131072;
          } else {
            Y[temp_re_tmp].re = a0_im & 131071;
          }
          if ((i3 & 34359738368L) != 0L) {
            i2 = i3 | -34359738368L;
          } else {
            i2 = i3 & 34359738367L;
          }
          a0_im = (int32_T)(i2 >> 17);
          if ((a0_im & 131072) != 0) {
            Y[temp_re_tmp].im = a0_im | -131072;
          } else {
            Y[temp_re_tmp].im = a0_im & 131071;
          }
          if (b_i + 2 > 32) {
            emlrtDynamicBoundsCheckR2012b(b_i + 2, 1, 32, &h_emlrtBCI, &st);
          }
          i2 = ((int64_T)Y[i4].re << 16) + x0_re;
          i3 = ((int64_T)Y[i4].im << 16) + x0_im;
          if (b_i + 2 > 32) {
            emlrtDynamicBoundsCheckR2012b(b_i + 2, 1, 32, &i_emlrtBCI, &st);
          }
          if ((i2 & 34359738368L) != 0L) {
            i2 |= -34359738368L;
          } else {
            i2 &= 34359738367L;
          }
          a0_im = (int32_T)(i2 >> 17);
          if ((a0_im & 131072) != 0) {
            Y[i4].re = a0_im | -131072;
          } else {
            Y[i4].re = a0_im & 131071;
          }
          if (b_i + 2 > 32) {
            emlrtDynamicBoundsCheckR2012b(b_i + 2, 1, 32, &i_emlrtBCI, &st);
          }
          if ((i3 & 34359738368L) != 0L) {
            i2 = i3 | -34359738368L;
          } else {
            i2 = i3 & 34359738367L;
          }
          b_i = (int32_T)(i2 >> 17);
          if ((b_i & 131072) != 0) {
            Y[i4].im = b_i | -131072;
          } else {
            Y[i4].im = b_i & 131071;
          }
          if (*emlrtBreakCheckR2012bFlagVar != 0) {
            emlrtBreakCheckR2012b(&st);
          }
        }
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(&st);
        }
      }
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtConstCTX)sp);
    }
  }
}

/* End of code generation (inverse_fft.c) */
