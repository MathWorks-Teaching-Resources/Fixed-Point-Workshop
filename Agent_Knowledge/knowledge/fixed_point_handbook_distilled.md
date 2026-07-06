# Fixed-Point Design with MATLAB: Distilled Reference

> Distilled from *Fixed-Point Workflow Using MATLAB* by Tom Bryan and Brenda Zhuang (MathWorks, R2025a).
> For use as context in curriculum development, teaching agents, and subagent knowledge bases.

---

## Part I: Foundations

### Why Fixed-Point?

The simulation ran flawlessly in double precision. On the target processor, the results are wrong — output oscillates, values clip, a one-bit scaling error cascades into total system failure. This gap between algorithm and fixed-point implementation is the central challenge in embedded systems development. Overflow, quantization error, and bit growth are the difference between a working product and a failed prototype.

**Target audience:** Engineers designing communication systems, DSP algorithms, radar, audio, motor control, automotive, or aerospace projects. Embedded software engineers, hardware designers working in C/C++/VHDL/Verilog, and students bridging classroom concepts to real-world embedded systems.

**Fixed-point advantages:** Lower power consumption, smaller die area, less memory, faster execution, lower cost.

**Fixed-point challenge:** Cannot simultaneously represent very large and very small numbers with a reasonable word size. Requires careful management of range, precision, overflow, and quantization.

---

### Numbers in Digital Hardware

#### Floating-Point Numbers
- Characterized by: sign bit, mantissa (fraction), exponent
- Double precision: 64 bits; Single precision: 32 bits
- Can represent very large and very small values simultaneously
- More expensive in hardware than pure integer math

#### Fixed-Point Numbers
- Characterized by: word length (bits), binary point position, signed/unsigned
- Binary point is NOT physically represented in hardware — hardware manipulates pure integers
- The "real world value" interpretation:

```
real_world_value = 2^(-fraction_length) * stored_integer
```

#### Key Design Decisions
When choosing a fixed-point data type, consider:
1. **Range** — limits of representable values
2. **Precision** — distance between successive representable values
3. **Quantization error** — rounding method chosen
4. **Overflow handling** — wrap vs. saturate

Range and precision are inversely related for a given word length.

#### Fixed-Point Arithmetic Rules

**Addition:** Sum of two B-bit numbers (same scaling) requires B+1 bits. Binary points must be aligned before adding.
- Word length of sum = 1 + max(integer_length_a, integer_length_b) + max(fraction_length_a, fraction_length_b)

**Multiplication:** Full-precision product requires word length = sum of operand word lengths.
- Word length of product = wordlength_a + wordlength_b
- Fraction length of product = fractionlength_a + fractionlength_b

---

### The `fi` Object in MATLAB

```matlab
a = fi(value, signedness, wordlength, fractionlength)
% signedness: 1=signed, 0=unsigned
% Example:
a = fi(pi, 1, 16, 13)  % signed, 16-bit, 13 fractional bits -> value 3.1416
```

If fraction length is omitted, `fi` auto-selects for best precision without overflow:
```matlab
a = fi(pi)  % -> signed, 16-bit, fraction length 13 (auto-selected)
```

Key properties:
- `a.int` — the underlying stored integer (what the hardware manipulates)
- `a.lsb` — value of the least-significant bit = `2^(-fractionlength)`
- `a.bin` — binary representation as string
- `range(a)` — representable range of the data type

---

## Part II: Best Practices and Conversion Workflow

### The Types-Table Pattern (Core Design Pattern)

The central technique: **separate algorithm from data type specification** using a struct of "template parameters."

```matlab
% Types table (like C++ template parameters)
function T = fir_filter_dsp_types(dataType)
    if nargin < 1, dataType = 'Fixed'; end
    T.coefficient = fi([], 1, 16, 16, 'DataType', dataType);
    T.input       = fi([], 1, 16, 14, F, 'DataType', dataType);
    T.output      = fi([], 1, 16, 14, F, 'DataType', dataType);
    T.sum         = fi([], 1, 32, 30, F, 'DataType', dataType);
    T.index       = int32([]);
end
```

**Key insight:** Only the TYPE of the template parameter is used, so initialize to empty `[]`. The only exception is complex types, which need `1i` to carry complexity information.

**Using types tables adds ZERO overhead to generated code.** The types-table parameter is optimized away.

### The `'like'` Syntax

Cast variables to match the type of a prototype:
```matlab
y = zeros(size(x), 'like', T.output);     % output array in target type
acc = cast(0, 'like', T.sum);             % accumulator in target type
b = cast(b, 'like', T.coefficient);       % coefficients in target type
```

### Subscripted Assignment (Colon-Indexing)

Preserves data type through assignment — critical for fixed-point:
```matlab
acc(:) = acc + b(j)*z(k);   % retains acc's type (prevents type promotion)
```

Without subscripted assignment, MATLAB would allow the type to change (e.g., double + single -> single), but C/HDL code generation requires fixed types.

### Conversion Heuristic (The Pattern)

1. **Cast first definitions** of variables using `cast(value, 'like', T.field)` or `zeros(..., 'like', T.field)`
2. **Use subscripted assignment** `var(:) = ...` for all subsequent assignments to the same variable
3. Pass the types table `T` as an input parameter to algorithm functions

---

### The 5-Step Fixed-Point Conversion Workflow

#### Step 1: Separate Algorithm from Test Script
- Algorithm = what goes on the embedded processor (no plotting, no display)
- Test script = input generation, verification, plotting
- This separation enables code generation and testing with different types

#### Step 2: Create Types Table and Add Template Parameter
- Define a struct with fields for each variable that needs a type
- Start with `double([])` types to match original behavior
- Add `T` as input parameter to algorithm function

#### Step 3: Generate Code (Start with Floating-Point)
- Use `codegen` to build MEX files early — identifies code-gen issues before fixed-point adds complexity
- Debug type-changing issues while still in floating-point
- Use `-args {b,x,z,p,T}` to define input prototypes

```matlab
codegen fir_filter -args {b,x,z,p,T}
codegen fir_filter -args {b,x,z,p,T} -config:lib -launchreport  % C code
```

#### Step 4: Test with Single-Precision Floating-Point
- Exposes type-mismatch errors before fixed-point
- Validates that all types are fully controlled by the types table
- Common error: "This assignment writes a 'single' value into a 'double' type"
- Fix: use `'like'` for first definitions, `(:)` for subsequent assignments

#### Step 5: Instrument Code and Visualize Types with Fixed-Point
- Use `'ScaledDouble'` data type mode for instrumentation (computes in double but tracks fixed-point ranges)
- `buildInstrumentedMex` logs min/max values and detects overflow/underflow
- `VisualizeDatatypes` shows dynamic range vs. data type coverage
- Red = overflow, Orange = underflow, Blue = in-range, Gray = representable dynamic range

---

### Choosing Fixed-Point Types

#### Method 1: Theory-Based (Preferred for linear systems)
- **Input type:** Based on known input range (e.g., ADC range -1 to +1)
  ```matlab
  x = fi([-1, 1], 1, 16)  % auto-scales -> fraction length 14
  ```
- **Output type:** Based on maximum filter gain
  ```matlab
  max_gain = norm(b, 1);  % = sum(abs(b)) for FIR filters
  output_upper_bound = max_gain * max(abs(x(:)));
  y = fi(output_upper_bound, 1, 16);  % auto-scales
  ```
- **Accumulator type:** Match natural word length of target
  ```matlab
  acc = fi(max_gain, 1, 32);  % 32-bit accumulator for 16x16 multiply
  ```
- **Coefficient type:** Let `fi` auto-scale with target word length
  ```matlab
  b = fi(b0, 1, 16);  % auto-selects fraction length for best precision
  ```

**Important:** Fraction length > word length is valid — it just means the scaling is `2^(-FL) * integer`.

#### Method 2: Simulation-Based
- Run instrumented code with representative test inputs
- Use `VisualizeDatatypes` with `-proposeFL` option to get proposed types
- Caveat: quality depends entirely on test input coverage
- For linear systems (FIR), limits are easily tested; for nonlinear systems, harder to guarantee

#### Choosing Test Inputs
For an FIR filter with `|x| <= 1`, the maximum-gain input is:
```matlab
x = sign(fliplr(b));  % matches coefficient signs -> achieves max output
```

---

### Efficient `fimath` Settings

Default settings produce rounding and saturation code you don't want. Use DSP-friendly settings:

```matlab
F = fimath('RoundingMethod', 'Floor', ...
    'OverflowAction', 'Wrap', ...
    'ProductMode', 'FullPrecision', ...
    'SumMode', 'SpecifyPrecision', ...
    'SumWordLength', 32, ...
    'SumFractionLength', 30, ...
    'CastBeforeSum', true);
```

- **Floor rounding:** Bits are just dropped — no extra logic. But introduces bias (negative direction).
- **Wrap overflow:** No saturation logic — but devastating if overflow actually occurs.
- **Floor bias** is acceptable in feed-forward systems (FIR) but problematic in recursive/feedback systems (IIR).

#### Aligning Product and Sum Types
For zero-cost accumulation (no shifts in generated C), align the types so that:
```
coefficient_FL + input_FL = sum_FL
```
Example: `(16,16) * (16,14) -> (32,30)` — the product naturally fits the 32-bit sum.

**Result:** Generated C code becomes simple multiply-accumulate with no extra shifts:
```c
acc += b[31 - j] * z[k - 1];  // no shifts needed
return (short)(acc >> 16);     // final cast to output
```

---

## Part III: The Vancouver Stock Exchange — A Cautionary Tale

In 1982, the Vancouver Stock Exchange computed its index using a recursive update (IIR-like filter) with floor rounding and 10-bit precision. After two years, the index was off by 480 points solely due to rounding bias.

**Key lessons:**
1. **Biased rounding + feedback = disaster.** Floor rounding always rounds down; in recursive systems, errors accumulate and compound.
2. **More precision won't fix biased rounding.** It only delays when the error becomes apparent.
3. **Convergent rounding** (round-to-nearest-even) is unbiased — even ties go down, odd ties go up. Use it for recursive/feedback systems.
4. **The types-table approach** enables switching between types without modifying the algorithm:

```matlab
% Fixed-point with floor (bad for feedback)
T.y = fi([], 1, 32, 10, 'RoundingMethod', 'Floor');

% Fixed-point with convergent (good for feedback)
T.y = fi([], 1, 32, 10, 'RoundingMethod', 'Convergent');

% Back to floating-point (no modification to algorithm!)
T.y = [];
```

---

## Part IV: CORDIC Algorithm

### What is CORDIC?

The **COordinate Rotation DIgital Computer** algorithm (Volder, 1959) is the backbone of fixed-point implementations of:
- Elementary functions: sine, cosine, arctangent, square root, divide
- Matrix factorizations: QR, SVD
- Coordinate transformations: Givens rotations, Euler-to-NED, oblique orthographic projection

**Why CORDIC for fixed-point?** Implemented using only **shifts and adds** — no multiplier needed.

### Mathematical Foundation

A Givens rotation:
```
G(theta) = [cos(theta)   sin(theta)]
           [-sin(theta)  cos(theta)]
```

Factor out cosine and choose angles theta_n = atan(2^(-n)):
```
G(theta) ≈ K_N * product_{n=0}^{N} [1        ±2^(-n)]
                                     [∓2^(-n)  1      ]
```

Where K_N = product of 1/sqrt(1 + 2^(-2n)) ≈ 0.6073 (the inverse CORDIC growth constant).

**Multiplication by 2^(-n) = right-shift by n bits.** This is why CORDIC needs only shifts and adds.

### CORDIC Vectoring Algorithm (Cartesian to Polar)

Given (x, y), drives y to zero through iterative rotations, yielding magnitude r and phase theta:

```matlab
function [x, y, theta] = cordic_vectoring_kernel(x, y, theta, N, a)
    if x < 0  % Reflect into right half-plane
        x(:) = -x;
        y(:) = -y;
        angle_correction = pi;
    else
        angle_correction = 0;
    end
    for n = 0:N-1
        x_shifted = bitsra(x, n);   % arithmetic right-shift
        y_shifted = bitsra(y, n);
        if y < 0  % Counterclockwise
            x(:) = x - y_shifted;
            y(:) = y + x_shifted;
            theta(:) = theta - a(n+1);
        else       % Clockwise
            x(:) = x + y_shifted;
            y(:) = y - x_shifted;
            theta(:) = theta + a(n+1);
        end
    end
    theta(:) = theta + angle_correction;
end
```

Where `a = atan(2.^-(0:N-1)')` is a constant lookup table.

### CORDIC Data Type Strategy

Since growth constant A_N ≈ 1.6468 < 2, only **one extra integer bit** is needed. Optimal iterations N = wordlength - 1 (value shifts to zero after that).

```matlab
% For DSP (in-place, same word length):
F_xy = fimath('RoundingMethod','Floor','OverflowAction','Wrap',...
    'SumMode','SpecifyPrecision','SumWordLength',w,'SumFractionLength',w-3);
T.x = fi([], 1, w, w-3, F_xy);      % 2 integer bits + sign
T.y = fi([], 1, w, w-3, F_xy);
T.theta = fi([], 1, w, w-4);         % 3 integer bits + sign (for ±pi)
T.a = fi([], 0, w, w-1);             % angle table (0 to pi/4)
```

### Generated C Code (CORDIC cart2pol, 16-bit)

```c
void cordic_cart2pol(const cint16_T Z, short *magnitudeZ, short *angleZ)
{
  static const short a[15] = {3217, 1899, 1003, 509, 256, 128, 64, 32,
                              16,   8,    4,    2,   1,   0,   0};
  short x = Z.re, y = Z.im, theta = 0, b0;
  if (Z.re < 0) { x = -Z.re; y = -Z.im; b0 = 12867; }
  else { b0 = 0; }
  for (int n = 0; n < 15; n++) {
    short x_shifted = x >> n, y_shifted = y >> n;
    if (y < 0) { x -= y_shifted; y += x_shifted; theta -= a[n]; }
    else       { x += y_shifted; y -= x_shifted; theta += a[n]; }
  }
  *angleZ = theta + b0;
  *magnitudeZ = (short)((x * 19898) >> 15);  // multiply by K_N
}
```

---

## Part V: System-Level Examples

### FIR Filter (Chapter 4)

**Purpose:** Simple enough to learn the workflow, complex enough to illustrate all conversion procedures.

**Algorithm:** Weighted moving average: `y(n) = sum(b(j) * x(n-j+1))`

**Implementation choices:**
- **Linear buffer:** Easy to read, but copies entire state buffer each sample
- **Circular buffer:** Efficient for hardware — minimizes data movement

**Final converted function:**
```matlab
function [y,z,p] = fir_filter(b, x, z, p, T)
    y = zeros(size(x), 'like', T.output);
    for n = 1:length(x)
        p = incrementCircularPointer(p, length(b));
        z(p) = x(n);
        acc = cast(0, 'like', T.sum);
        k = p;
        for j = length(b):-1:1
            k = incrementCircularPointer(k, length(b));
            acc(:) = acc + b(j)*z(k);
        end
        y(n) = acc;
    end
end
```

**Final generated C (expert-quality):**
```c
short fir_filter(const short b[32], short x, short z[32], int *p) {
  int acc = 0, k;
  *p = (*p & 31) + 1;
  z[*p - 1] = x;
  k = *p;
  for (int j = 0; j < 32; j++) {
    k = (k & 31) + 1;
    acc += b[31 - j] * z[k - 1];
  }
  return (short)(acc >> 16);
}
```

---

### DFT Polyphase Filter Bank (Chapter 6)

**Architecture:** FIR filter bank -> Inverse FFT -> CORDIC magnitude/phase

```matlab
function [magnitudeY, angleY] = dft_polyphase_filter(B, U, T)
    X = fir_filter_bank(B, U, T.fir_filter);
    Y = inverse_fft(X, T.fft, 1);
    [magnitudeY, angleY] = cordic_cart2pol(Y);
end
```

**Key design insight:** Each sub-component (FIR, FFT, CORDIC) has its own types table, composed into the system-level types table. The same types-table pattern scales from individual functions to complex systems.

**Type variants available:** `double`, `single`, `dsp` (16-bit for C), `hdl` (optimized for FPGA)

---

### Linear Systems of Equations (Chapter 7)

**Problem:** Solve AX = B, (A'A)X = B, or regularized variants in fixed-point.

**Approach:** QR decomposition using CORDIC (shifts and adds only).

**Never use matrix inverse.** Never compute A'A if avoidable (squares condition number, halves dynamic range or doubles word length).

#### Data Type Bounds (Analytical)

For R = Q'A:
```
max(|R(:)|) <= sqrt(m) * max(|A(:)|)
```

For solution X of AX = B:
```
max(|X(:)|) <= sqrt(m) * max(|B(:)|) / min(svd(A))
```

Required integer bits = precision bits + sign bit + 1 bit for CORDIC gain (≈1.6468).

Use `fixed.realSingularValueLowerBound` or `fixed.complexSingularValueLowerBound` to estimate bounds without computing full SVD.

#### QR via CORDIC

```matlab
function [C,R] = qr_zero_sub_diagonal(A, B)
  [niter, Kn] = fixed.cordicConstants(A);
  [m,n] = size(A);
  R = zeros(n, n, 'like', A);
  C = zeros(n, size(B,2), 'like', B);
  for i = 1:m
    for j = 1:n
      if ~isreal(A(i,:))
          [A(i,:), B(i,:)] = rotateFirstElementToReal(A(i,:), B(i,:), j, niter, Kn);
      end
      [R(j,:), A(i,:), C(j,:), B(i,:)] = cordicgivens(R(j,:), A(i,:), C(j,:), B(i,:), j, niter, Kn);
    end
  end
end
```

**HDL architectures:** Systolic array (maximum throughput) or resource-shared (minimum area).

---

### Euler to NED Coordinate Transformation (Chapter 8)

**Application:** Aerospace navigation — converts Euler angles (roll, pitch, yaw) to North-East-Down frame.

**Key advantage of CORDIC approach:**
- No explicit trigonometric function computation
- No multiplications required
- Entire design fits in FPGA fabric (no DSP slices consumed)
- Flexible: pipelined (max throughput) or shared (min area)

**Method:** Apply CORDIC Givens rotations sequentially in appropriate subspaces:
1. Rotate by phi in yz-plane (roll)
2. Rotate by -theta in xz-plane (pitch)
3. Rotate by psi in xy-plane (yaw)

---

### Oblique Orthographic Projection (Chapter 9)

**Application:** Geometric transformation for satellite imagery (Landsat, near-polar-orbiting satellites). Maps a hemisphere onto a plane.

**Method:** Four sequential CORDIC rotations to transform latitude/longitude into map coordinates without computing trigonometric functions or performing multiplications.

**Performance:** CORDIC elements can synthesize at >300 MHz using only fabric logic (LUTs and flip-flops).

---

## Part VI: Code Generation

### C Code Generation

```matlab
codegen fir_filter -args {b,x,z,p,T} -config:lib -launchreport
```

- `-args {prototypes}` defines input types/sizes
- `-config:lib` generates C source library
- `-launchreport` opens compilation report
- Embedded Coder enables "Trace Code" feature for MATLAB-to-C mapping

### HDL Code Generation

```matlab
codegen cordic_cart2pol -args {Z(1)} -config:hdl -launchreport
```

- MATLAB loops produce combinational logic (fast but cannot be clocked)
- For registered/pipelined HDL, use Simulink with MATLAB Function blocks
- Resource-shared vs. pipelined architectures are modeled in Simulink

### SystemC Code Generation

```matlab
cfg = coder.HdlConfig;
cfg.TargetLanguage = "SystemC";
codegen myfunction -args {a,b} -config cfg -launchreport
```

### Combining MATLAB and Simulink for HDL

MATLAB defines the algorithm kernel. Simulink models:
- Dataflow and timing
- Registers (Delay blocks) between iterations
- Resource sharing vs. pipelining
- Parallelism

---

## Part VII: Summary of Design Patterns

| Pattern | Purpose | Example |
|---------|---------|---------|
| Types Table | Separate algorithm from type specification | `T.sum = fi([],1,32,30)` |
| `'like'` syntax | Create variables matching a prototype type | `zeros(n,1,'like',T.output)` |
| Subscripted assignment | Preserve type through assignment | `acc(:) = acc + b*z` |
| `cast(...,'like',T.x)` | Convert inputs to target type | `b = cast(b,'like',T.coefficient)` |
| ScaledDouble | Instrument code to detect overflow/underflow | `fi([],'DataType','ScaledDouble')` |
| `bitsra(x,n)` | Arithmetic right-shift (for CORDIC) | `x_shifted = bitsra(x, n)` |
| `removefimath` | Strip fimath from outputs (prevent propagation) | `y = removefimath(y)` |
| Align product+sum | Eliminate shifts in accumulator | coeff_FL + input_FL = sum_FL |

---

## Part VIII: Common Pitfalls and Solutions

| Pitfall | Cause | Solution |
|---------|-------|----------|
| Type mismatch in codegen | Assigning into variable changes type | Use `(:)` subscripted assignment |
| Overflow in accumulator | Default fi types too narrow | Compute bounds from filter gain or theory |
| Biased error in feedback systems | Floor rounding | Use convergent rounding for recursive systems |
| Extra shifts in generated C | Product and sum types misaligned | Align fraction lengths: coeff_FL + input_FL = sum_FL |
| Overflow in CORDIC | Not accounting for growth factor | Add ceil(log2(1.6468*sqrt(2))) = 2 integer bits |
| Unnecessary saturation/rounding code | Default fimath | Use Floor/Wrap fimath for feed-forward systems |
| Variable-size errors in codegen | MATLAB allows resizing; C doesn't | Preallocate all arrays with correct size |

---

## Part IX: Recommended Workflow (Complete)

1. **Develop algorithm** in MATLAB (floating-point)
2. **Enable fixed-point data types** via types tables so code runs with any type
3. **Test with different fixed-point properties** (word lengths, scaling, overflow modes)
4. **Experiment with algorithm choices** (filter lengths, architectures)
5. **Compare** floating-point vs. fixed-point using the same code with different types tables
6. **Analyze tradeoffs** of resources vs. speed
7. **If targeting HDL:** use MATLAB code as working design document; create Simulink models for hardware optimization
8. **Generate bit-faithful test vectors** from MATLAB for hardware verification
9. **Iterate** until specifications are met

---

## Part X: Tool Reference

### Required MathWorks Products
- MATLAB
- Simulink
- Fixed-Point Designer
- MATLAB Coder
- Embedded Coder
- HDL Coder
- DSP System Toolbox
- Signal Processing Toolbox

### Key Functions and Commands
| Function | Purpose |
|----------|---------|
| `fi(value, signed, wl, fl)` | Create fixed-point number |
| `cast(x, 'like', T)` | Cast to prototype type |
| `zeros(m, n, 'like', T)` | Create typed array |
| `fimath(...)` | Specify arithmetic rules |
| `codegen func -args {...}` | Generate C/HDL code |
| `buildInstrumentedMex` | Build instrumented MEX for logging |
| `VisualizeDatatypes` | Visualize data type utilization |
| `bitsra(x, n)` | Arithmetic right-shift by n |
| `bitsll(x, n)` | Logical left-shift by n |
| `range(x)` | Get representable range of type |
| `eps(x)` / `x.lsb` | Value of least-significant bit |
| `fixed.realSingularValueLowerBound` | Estimate min singular value bound |
| `fixed.cordicConstants(A)` | Get CORDIC iteration count and gain |
| `propagateFloat` | Promote fi operating on float to float |

### Key File Organization Pattern
```
project/
  exercises/          % Student exercise files (by chapter)
  solutions/          % Complete solutions
  references/         % Supporting documentation
```

Each chapter directory contains:
- Algorithm functions (e.g., `fir_filter.m`)
- Type definition files (e.g., `fir_filter_dsp_types.m`, `fir_filter_hdl_types.m`)
- Test scripts (e.g., `test_fir_filter.m`)

---

## Appendix: Comparison of Fixed-Point Representations

| Feature | MATLAB `fi` | Accellera AC Fixed | SystemC |
|---------|-------------|-------------------|---------|
| Notation | `fi([], 1, 16, 14)` | `ac_fixed<16,2,true>` | `sc_fixed<16,2>` |
| Integer meaning | fraction_length | integer_length | integer_length |
| Relationship | WL = IL + FL | same | same |
| Code gen | C, C++, HDL, SystemC | C++ only | SystemC only |

Note: MATLAB `fi` uses fraction length; AC Fixed and SystemC use integer length. The relationship is: `integer_length = word_length - fraction_length`.
