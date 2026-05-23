#!/usr/bin/python3
# -*- coding: utf-8 -*-
import matplotlib.pyplot as plt # Librería gráfica
import speedup                  # Importo las funciones de speedup.py
import sys

if len(sys.argv) != 4:
  print("Uso: %s <n> <p> <m>" % (sys.argv[0]))
  sys.exit(1)

n=int(sys.argv[1])
p=int(sys.argv[2])
m=int(sys.argv[3])

direc="./results/"
x_labels=("O2", "O3", "vaddmul", "vmacc", "tiled")
x_ind=range(len(x_labels))

speedups = []
for i in x_ind:
  speedups.append(speedup.su(direc + "P3GEMM_O2_%d_%d_%d_*" % (n,p,m), direc + "P3GEMM_%s_%d_%d_%d_*" % (x_labels[i],n,p,m)))

lfs = 20 #label font size
plt.bar(x_ind, speedups)
for i in x_ind:
  plt.text(x_ind[i], speedups[i], str(round(speedups[i],2)), horizontalalignment='center')
plt.grid(axis='y', linewidth=1, linestyle="-")
plt.ylabel('Speedup', fontsize=lfs)
#plt.xlabel('SEW', fontsize=lfs)
plt.title("P3GEMM n=%d p=%d m=%d" % (n,p,m), fontsize=lfs)
plt.xticks(x_ind,x_labels,fontsize=lfs*0.8)

#plt.savefig("./P3GEMMsu_%d_%d_%d.pdf" % (n,p,m), format='pdf',bbox_inches='tight')
plt.savefig("./P3GEMMsu_%d_%d_%d.png" % (n,p,m), format='png',bbox_inches='tight')

