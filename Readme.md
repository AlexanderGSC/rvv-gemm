## GEMM Optimization with RISC-V RVV 1.0

This repository contains the analysis and progressive optimisation of a generic matrix multiplication algorithm (**GEMM**) for large matrices ($2000 \times 3000 \times 100$), running natively on a **64-bit RISC-V** architecture utilising the ** RVV 1.0** vector extension and advanced cache locality techniques (*Tiling*).

The repository develops the algorithm through various stages:
* **`P3GEMM_O2.c`**: Pure scalar code.
* **`P3GEMM_vaddmul.c`**: First vector approach using `vle32.v`, `vfmul.vf`, `vfadd.vv`.
* **`P3GEMM_vmacc.c`**: Latency reduction by replacing the Mul/Add pair with the combined instruction `vfmacc.vf`.
* **`P3GEMM_tiled.c`**: Implementation of *Loop Nest Blocking* (Tiling) by dividing the spatial problem into submatrices that fit into the L1 cache, eliminating *stores* with strides to RAM.

## Benchmark Results

The experiment was carried out on a **Banana Pi M4 Berry / BPI-F3** board (with a RISC-V architecture processor), measuring the pure computation time required to calculate the resulting matrix $C$:

| Version | Computing time | SpeedUp vs -O2 | Optimization / Diagnostic |
| :--- | :---: | :---: | :--- |
| **`P3GEMM_O2`** | 2.841 s | $1.0\times$ | Pure C baseline without vectorisation. |
| **`P3GEMM_O3`** | 0.811 s | $3.5\times$ | Automatic vectorisation by the compiler |
| **`P3GEMM_vaddmul`** | 0.754 s | $3.7\times$ | Manual vectorisation. Separate add and mul operations|
| **`P3GEMM_vmacc`** | 0.706 s | $4.0\times$ | Using *Fused Multiply-Add* (`vmacc`) |
| **`P3GEMM_tiled`** | **0.319 s** | **$8.9\times$** | **Tiling Support ($64 \times 64$).** Data cached in L1 cache. *Stores* are performed outside the critical section.

![speedups](result.png) |

> **Key takeaway:** Maximum optimisation is not achieved simply by inserting vector instructions (`LMUL=8`), but by managing how data flows between RAM, L1 cache blocks and the silicon’s vector ALUs.

---

## 🔧 Compilation

To compile natively in the RISC-V environment using vector support (requires `gcc` with support for RVV 1.0):

```bash
# Compile all versions
make

# Run by entering dimensions: N P M
./python3 P3GEMM_su 2000 3000 100
```

### Next Steps

Implement the same algorithm in C++ to measure the impact of zero-cost abstractions on the code

Use GEMM to implement a *2D convolution* using the *im2col* algorithm