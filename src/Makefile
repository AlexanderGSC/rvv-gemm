CC := gcc
CFLAGS := -march=rv64gcv -Wall
BIN := P3GEMM_O2 P3GEMM_O3 P3GEMM_vmacc P3GEMM_vaddmul P3GEMM_tiled

.PHONY: all clean

all: $(BIN)

P3GEMM_O2: P3GEMM.c
	$(CC) -O2 $(CFLAGS) -o $@ $^

P3GEMM_O3: P3GEMM.c
	$(CC) -fopt-info-vec-optimized -O3 $(CFLAGS) -o $@ $^

P3GEMM_vmacc: P3GEMM_vmacc.c
	$(CC) -O3 $(CFLAGS) -o $@ $^

P3GEMM_vaddmul: P3GEMM_vaddmul.c
	$(CC) -O3 $(CFLAGS) -o $@ $^

P3GEMM_tiled: P3GEMM_tiled.c
	$(CC) -O3 $(CFLAGS) -o $@ $^

clean:
	rm -f $(BIN)
