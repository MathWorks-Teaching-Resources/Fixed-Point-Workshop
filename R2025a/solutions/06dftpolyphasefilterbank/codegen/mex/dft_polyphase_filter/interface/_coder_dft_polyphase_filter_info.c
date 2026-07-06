/*
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * _coder_dft_polyphase_filter_info.c
 *
 * Code generation for function 'dft_polyphase_filter'
 *
 */

/* Include files */
#include "_coder_dft_polyphase_filter_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

/* Function Declarations */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

/* Function Definitions */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[9] = {
      "789ced5acb6ed3401475ab162110a51b50c547d449489376c1a2699bd46d5ee4a1b64160"
      "1c7b9c4c6b8fcd78f25c2181041b54217e92254b9638b1270f4b9623"
      "b938a9ebd94cae4f9c731f9e733d8e9935aeb0c630cc16638d9db8353fb3ed6d7b5e67e6"
      "87135fb3e7c70e9b8e4d6663ee3c8adfdab3a82102fac43290a082c9",
      "9992a6422420521be880c1c0d0942e90c6880c1550832aa8ce1ac591a56667a089318246"
      "9f8fda40bca9765406b78da987caac31c9c71f97783716ccc70f977c"
      "6c3bf07727efd9ba01b0c192261e0888ed69f8869515adc7122c4004516b7cc8686bbac1"
      "5612b1445260b3b00fa4b20611291cd6f287990bfb0b366ca6aa43a0",
      "860c36969264a26bca406f0b06305345006e0ae886350ff393e3bc05ecaa33f1eb3ee37f"
      "ee113fc565886d7a7ee4d89df13ff5e0a738509b409280b42bc3b14d"
      "f97ffbe4ffeec14ff125d5df91f65d95c6fdd1252e5a2fafb89df3f4fb9642acbfc97f18"
      "cd41f1d1f150f8fa2ebfb7e875fbd2856fdb81c344bb5738e62a8d4b",
      "51deab9ea3d6eb7d2e919bfa51f6e0f1f28371b183fafd87bafe3ffb8cfb9547dc149f71"
      "408458ec2882e949479601b6f055e9037f7df2fff2e0a7f8f2af0347"
      "19c67703c1e958d417fe2f9fdfbef0c2856fdb8117af4bf1f3cbd66905888d520c6675e5"
      "6af096094f5f88f4c01a7eafa71d8f3c501c2211031520c20b48e27b",
      "58d0798824d0f75a478bfab1e9eac7a6cd4fe229e6eeeaffd3956f1e5f52fdddd26d573f"
      "ea0761e10b6a9f10ab14392866060d9cee9e5cf7079dfd7aeb2044fb"
      "84e83991bff817bd3f87a86b066fba205bcf0a57657fe0779ff8d5839fe24beb0793b45b"
      "2d20d2ff70f005a5ff678a1e4f66868554a2cfc987d546deb8d0f151",
      "78f4ffa1ae7fbfbabbe5b09d71531c0b12ec27480f4a92020ceff5b228ff23577e0b91b4"
      "4e53017757e76fae7cf3f892ea3c9f66b3d491ce87832f289d1ff48e"
      "cf0bc946a953caa763c7430449a3583c8974febeeb7c50d78f2540263ddf83a4cd1ba2a0"
      "98a1aece7dbedf7ddeadc376f2537ca9faef4c7fd40742c317d43afe",
      "9455ab67c972dde0bab0059bd7f5b89eae44cf7b42a3037e75f88947fc146f4282c1b827"
      "59f6aaf401bff7015f3cf829bea4fa4fd31efdff1b2abea0f43f37cc"
      "a9e2c59e91cad7b5bdcb6af228d7a8e53291fe47cffbadb1e87ba1a2862528f2a28049c2"
      "742834fabfe2ef8539d21ebd171a16bea0f4ff6a70d08cb5b418574e",
      "9f0ae9d6309be13890bdfffaff0f6b755925",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 12592U, &nameCaptureInfo);
  return nameCaptureInfo;
}

mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xEntryPoints;
  mxArray *xInputs;
  mxArray *xResult;
  const char_T *propFieldName[9] = {"Version",
                                    "ResolvedFunctions",
                                    "Checksum",
                                    "EntryPoints",
                                    "CoverageInfo",
                                    "IsPolymorphic",
                                    "PropertyList",
                                    "UUID",
                                    "ClassEntryPointIsHandle"};
  const char_T *epFieldName[8] = {
      "Name",     "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "FullPath", "TimeStamp",      "Constructor",     "Visible"};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 8, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "Name",
                emlrtMxCreateString("dft_polyphase_filter"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(2.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(
      xEntryPoints, 0, "FullPath",
      emlrtMxCreateString("/Users/tbryan/work/flow/training/workshops/R2024a/"
                          "FixedPointMATLABWorkshopR2024a/solutions/"
                          "06dftpolyphasefilterbank/dft_polyphas"
                          "e_filter.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(737839.60946759256));
  emlrtSetField(xEntryPoints, 0, "Constructor",
                emlrtMxCreateLogicalScalar(false));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 9, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("24.1.0.2537033 (R2024a)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("zyBAzDPNLe0LmHqj3r7TLD"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

/* End of code generation (_coder_dft_polyphase_filter_info.c) */
