/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * _coder_dft_polyphase_filter_api.c
 *
 * Code generation for function '_coder_dft_polyphase_filter_api'
 *
 */

/* Include files */
#include "_coder_dft_polyphase_filter_api.h"
#include "dft_polyphase_filter.h"
#include "dft_polyphase_filter_data.h"
#include "dft_polyphase_filter_types.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               int16_T y[256]);

static const mxArray *b_emlrt_marshallOut(const int32_T u[128000]);

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, cint16_T y[128000]);

static const mxArray *c_emlrt_marshallOut(const emlrtStack *sp,
                                          const int32_T u[128000]);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               cint16_T y[128000]);

static struct0_T e_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, int16_T y[256]);

static const mxArray *emlrt_marshallOut(const emlrtStack *sp,
                                        const int32_T u[128000]);

static struct0_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static struct1_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static int16_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId);

static cint64_T j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId);

static cint16_T k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId);

static cint32_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId);

static struct2_T m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static cint32_T n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId);

static void o_emlrt_marshallIn(const mxArray *src, int16_T ret[256]);

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               cint16_T ret[128000]);

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId);

static int16_T r_emlrt_marshallIn(const mxArray *src);

static cint64_T s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src);

static cint16_T t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src);

static cint32_T u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               int16_T y[256])
{
  static const int32_T dims[2] = {32, 8};
  emlrtCheckFiR2012b((emlrtCTX)sp, parentId, u, false, 2U, (void *)&dims[0],
                     eml_mx, b_eml_mx);
  o_emlrt_marshallIn(emlrtAlias(u), y);
  emlrtDestroyArray(&u);
}

static const mxArray *b_emlrt_marshallOut(const int32_T u[128000])
{
  static const int32_T iv[2] = {32, 4000};
  const mxArray *m;
  const mxArray *y;
  int32_T b_i;
  int32_T c_i;
  int32_T i;
  int32_T *pData;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxINT32_CLASS, mxREAL);
  pData = (int32_T *)emlrtMxGetData(m);
  i = 0;
  for (b_i = 0; b_i < 4000; b_i++) {
    for (c_i = 0; c_i < 32; c_i++) {
      pData[i + c_i] = u[c_i + (b_i << 5)];
    }
    i += 32;
  }
  emlrtAssign(&y, m);
  return y;
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, cint16_T y[128000])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static const mxArray *c_emlrt_marshallOut(const emlrtStack *sp,
                                          const int32_T u[128000])
{
  const mxArray *y;
  y = NULL;
  emlrtAssign(&y, emlrtCreateFIR2013b((emlrtCTX)sp, g_eml_mx, i_eml_mx,
                                      "simulinkarray", b_emlrt_marshallOut(u),
                                      false, false));
  return y;
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               cint16_T y[128000])
{
  static const int32_T dims[2] = {32, 4000};
  emlrtCheckFiR2012b((emlrtCTX)sp, parentId, u, true, 2U, (void *)&dims[0],
                     eml_mx, c_eml_mx);
  p_emlrt_marshallIn(sp, emlrtAlias(u), y);
  emlrtDestroyArray(&u);
}

static struct0_T e_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  struct0_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, int16_T y[256])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static const mxArray *emlrt_marshallOut(const emlrtStack *sp,
                                        const int32_T u[128000])
{
  const mxArray *y;
  y = NULL;
  emlrtAssign(&y, emlrtCreateFIR2013b((emlrtCTX)sp, g_eml_mx, h_eml_mx,
                                      "simulinkarray", b_emlrt_marshallOut(u),
                                      false, false));
  return y;
}

static struct0_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[2] = {"fir_filter", "fft"};
  emlrtMsgIdentifier thisId;
  struct0_T y;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 2,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "fir_filter";
  y.fir_filter = g_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0, "fir_filter")),
      &thisId);
  thisId.fIdentifier = "fft";
  y.fft = m_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "fft")),
      &thisId);
  emlrtDestroyArray(&u);
  return y;
}

static struct1_T g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[6] = {"p", "coeff", "acc", "x", "y", "z"};
  emlrtMsgIdentifier thisId;
  struct1_T y;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 6,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "p";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0, "p")),
      &thisId);
  thisId.fIdentifier = "coeff";
  y.coeff = i_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "coeff")),
      &thisId);
  thisId.fIdentifier = "acc";
  y.acc = j_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2, "acc")),
      &thisId);
  thisId.fIdentifier = "x";
  y.x = k_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "x")),
      &thisId);
  thisId.fIdentifier = "y";
  y.y = l_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "y")),
      &thisId);
  thisId.fIdentifier = "z";
  y.z = k_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 5, "z")),
      &thisId);
  emlrtDestroyArray(&u);
  return y;
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  q_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
}

static int16_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  int16_T y;
  emlrtCheckFiR2012b((emlrtCTX)sp, parentId, u, false, 0U, (void *)&dims,
                     eml_mx, b_eml_mx);
  y = r_emlrt_marshallIn(emlrtAlias(u));
  emlrtDestroyArray(&u);
  return y;
}

static cint64_T j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  cint64_T y;
  emlrtCheckFiR2012b((emlrtCTX)sp, parentId, u, true, 0U, (void *)&dims, eml_mx,
                     d_eml_mx);
  y = s_emlrt_marshallIn(sp, emlrtAlias(u));
  emlrtDestroyArray(&u);
  return y;
}

static cint16_T k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  cint16_T y;
  emlrtCheckFiR2012b((emlrtCTX)sp, parentId, u, true, 0U, (void *)&dims, eml_mx,
                     c_eml_mx);
  y = t_emlrt_marshallIn(sp, emlrtAlias(u));
  emlrtDestroyArray(&u);
  return y;
}

static cint32_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  cint32_T y;
  emlrtCheckFiR2012b((emlrtCTX)sp, parentId, u, true, 0U, (void *)&dims, eml_mx,
                     e_eml_mx);
  y = u_emlrt_marshallIn(sp, emlrtAlias(u));
  emlrtDestroyArray(&u);
  return y;
}

static struct2_T m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[2] = {"x", "w"};
  emlrtMsgIdentifier thisId;
  struct2_T y;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 2,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "x";
  y.x = n_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0, "x")),
      &thisId);
  thisId.fIdentifier = "w";
  y.w = n_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "w")),
      &thisId);
  emlrtDestroyArray(&u);
  return y;
}

static cint32_T n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  cint32_T y;
  emlrtCheckFiR2012b((emlrtCTX)sp, parentId, u, true, 0U, (void *)&dims,
                     f_eml_mx, e_eml_mx);
  y = u_emlrt_marshallIn(sp, emlrtAlias(u));
  emlrtDestroyArray(&u);
  return y;
}

static void o_emlrt_marshallIn(const mxArray *src, int16_T ret[256])
{
  const mxArray *mxInt;
  int32_T i;
  int16_T(*r)[256];
  mxInt = emlrtImportFiIntArrayR2008b(src);
  r = (int16_T(*)[256])emlrtMxGetData(mxInt);
  for (i = 0; i < 256; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&mxInt);
  emlrtDestroyArray(&src);
}

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               cint16_T ret[128000])
{
  const mxArray *mxInt;
  mxInt = emlrtImportFiIntArrayR2008b(src);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, mxInt, &ret[0], 2, true);
  emlrtDestroyArray(&mxInt);
  emlrtDestroyArray(&src);
}

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims[2] = {0, 0};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "int16", false, 2U,
                          (const void *)&dims[0]);
  emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

static int16_T r_emlrt_marshallIn(const mxArray *src)
{
  const mxArray *mxInt;
  int16_T ret;
  mxInt = emlrtImportFiIntArrayR2008b(src);
  ret = *(int16_T *)emlrtMxGetData(mxInt);
  emlrtDestroyArray(&mxInt);
  emlrtDestroyArray(&src);
  return ret;
}

static cint64_T s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src)
{
  const mxArray *mxInt;
  cint64_T ret;
  mxInt = emlrtImportFiIntArrayR2008b(src);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, mxInt, &ret, 8, true);
  emlrtDestroyArray(&mxInt);
  emlrtDestroyArray(&src);
  return ret;
}

static cint16_T t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src)
{
  const mxArray *mxInt;
  cint16_T ret;
  mxInt = emlrtImportFiIntArrayR2008b(src);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, mxInt, &ret, 2, true);
  emlrtDestroyArray(&mxInt);
  emlrtDestroyArray(&src);
  return ret;
}

static cint32_T u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src)
{
  const mxArray *mxInt;
  cint32_T ret;
  mxInt = emlrtImportFiIntArrayR2008b(src);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, mxInt, &ret, 4, true);
  emlrtDestroyArray(&mxInt);
  emlrtDestroyArray(&src);
  return ret;
}

void dft_polyphase_filter_api(dft_polyphase_filterStackData *SD,
                              const mxArray *const prhs[3], int32_T nlhs,
                              const mxArray *plhs[2])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  struct0_T T;
  int16_T B[256];
  st.tls = emlrtRootTLSGlobal;
  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "B", B);
  c_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "U", SD->f1.U);
  T = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "T");
  /* Invoke the target function */
  dft_polyphase_filter(SD, &st, B, SD->f1.U, &T, SD->f1.magnitudeY,
                       SD->f1.angleY);
  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(&st, SD->f1.magnitudeY);
  if (nlhs > 1) {
    plhs[1] = c_emlrt_marshallOut(&st, SD->f1.angleY);
  }
}

/* End of code generation (_coder_dft_polyphase_filter_api.c) */
