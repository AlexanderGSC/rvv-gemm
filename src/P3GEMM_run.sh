#!/bin/bash

if test $# -ne 3; then
    echo "Uso: $0 <n> <p> <m>"
    echo " GEMM. General Matrix Multiply. Multiplicación de matrices aleatorias."
    echo " Introduce las dimensiones: <n,p> * <p,m> = <n,m> "
    exit 1
fi

n=$1
p=$2
m=$3
for (( i=0; i<10; i++ )); do
    echo "------------------------------------------------"
    echo "Iteración $i Elementos $n $p $m"
    echo "------------------------------------------------"
    echo "./P3GEMM_O2 $n $p $m"
    ./P3GEMM_O2 $n $p $m
    echo " "
    echo "./P3GEMM_O3 $n $p $m"
    ./P3GEMM_O3 $n $p $m
    echo " "
    echo "./P3GEMM_vmacc $n $p $m"
    ./P3GEMM_vmacc $n $p $m
    echo " "
    echo "./P3GEMM_vaddmul $n $p $m"
    ./P3GEMM_vaddmul $n $p $m
done
    
