#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdint.h>
#include<sys/time.h>
#include<sys/stat.h>
#include<unistd.h>
#include<time.h>
#include<omp.h>

#include <riscv_vector.h>

#define TILE_SIZE 64

#define RESULT_DIR "./results/"

FILE *open_results_file(char *progn, char *n, char *p, char *m);
 

void GEMM(size_t n, size_t p, size_t m, float **a, float **b, float **c) {
    size_t si, sk, sj; // Bucles externos (saltan de bloque en bloque)
    size_t i, k, j;     // Bucles internos (operan dentro del bloque)
    size_t vl;

    // 1. Bucles externos: Dividen el problema en tiles
	#pragma omp parallel for collapse(2) private(si, sj, sk, i, j, k, vl)
    for (si = 0; si < n; si += TILE_SIZE) {
        for (sj = 0; sj < m; sj += TILE_SIZE) {
            for (sk = 0; sk < p; sk += TILE_SIZE) {

                // 2. Bucles internos: Operan DENTRO del bloque actual
                // AQUÍ SÍ REORDENAMOS (j fuera, k dentro) porque el bloque cabe en caché.
                size_t j_end = (sj + TILE_SIZE < m) ? sj + TILE_SIZE : m;
                size_t i_end = (si + TILE_SIZE < n) ? si + TILE_SIZE : n;
                size_t k_end = (sk + TILE_SIZE < p) ? sk + TILE_SIZE : p;

				for (j = sj; j < j_end; j += 2*vl) {
					size_t remaining = (j_end - j);
					vl = __riscv_vsetvl_e32m2(remaining/2 > 0 ? remaining/2 : remaining);

					// 1. BUCLE PRINCIPAL CON UNROLL (De 4 en 4 filas)
					// Nos detenemos 4 elementos antes del final real
					size_t i_unroll_end = (i_end > si + 3) ? i_end - 3 : si;

					for (i = si; i < i_unroll_end; i += 4) {
						// Tenemos 4 acumuladores independientes para 4 filas distintas de C
						vfloat32m2_t v_c00= __riscv_vle32_v_f32m2(&c[i+0][j], vl);
						vfloat32m2_t v_c10= __riscv_vle32_v_f32m2(&c[i+1][j], vl);
						vfloat32m2_t v_c20= __riscv_vle32_v_f32m2(&c[i+2][j], vl);
						vfloat32m2_t v_c30= __riscv_vle32_v_f32m2(&c[i+3][j], vl);
						vfloat32m2_t v_c01= __riscv_vle32_v_f32m2(&c[i+0][j+vl],vl);
						vfloat32m2_t v_c11= __riscv_vle32_v_f32m2(&c[i+1][j+vl],vl);
						vfloat32m2_t v_c21= __riscv_vle32_v_f32m2(&c[i+2][j+vl],vl);
						vfloat32m2_t v_c31= __riscv_vle32_v_f32m2(&c[i+3][j+vl],vl);
						for (k = sk; k < k_end; k++) {
							// Una sola carga de B sirve para alimentar los 8 acumuladores
							vfloat32m2_t v_b0 = __riscv_vle32_v_f32m2(&b[k][j], vl);
							vfloat32m2_t v_b1 = __riscv_vle32_v_f32m2(&b[k][j+vl],vl);

							float a0 = a[i+0][k];
							float a1 = a[i+1][k];
							float a2 = a[i+2][k];
							float a3 = a[i+3][k];

							
							v_c00 = __riscv_vfmacc_vf_f32m2(v_c00, a0, v_b0, vl);
							v_c10 = __riscv_vfmacc_vf_f32m2(v_c10, a1, v_b0, vl);
							v_c20 = __riscv_vfmacc_vf_f32m2(v_c20, a2, v_b0, vl);
							v_c30 = __riscv_vfmacc_vf_f32m2(v_c30, a3, v_b0, vl);
							v_c01 = __riscv_vfmacc_vf_f32m2(v_c01, a0, v_b1, vl);
							v_c11 = __riscv_vfmacc_vf_f32m2(v_c11, a1, v_b1, vl);
							v_c21 = __riscv_vfmacc_vf_f32m2(v_c21, a2, v_b1, vl);
							v_c31 = __riscv_vfmacc_vf_f32m2(v_c31, a3, v_b1, vl);

						}

						__riscv_vse32_v_f32m2(&c[i+0][j], v_c00, vl);
						__riscv_vse32_v_f32m2(&c[i+1][j], v_c10, vl);
						__riscv_vse32_v_f32m2(&c[i+2][j], v_c20, vl);
						__riscv_vse32_v_f32m2(&c[i+3][j], v_c30, vl);
						__riscv_vse32_v_f32m2(&c[i+0][j+vl], v_c01, vl);
						__riscv_vse32_v_f32m2(&c[i+1][j+vl], v_c11, vl);
						__riscv_vse32_v_f32m2(&c[i+2][j+vl], v_c21, vl);
						__riscv_vse32_v_f32m2(&c[i+3][j+vl], v_c31, vl);
					}

					// 2. BUCLE DE LIMPIEZA (Procesa el residuo de 1 en 1)
					for (; i < i_end; i++) {
                        vfloat32m2_t v_c0 = __riscv_vle32_v_f32m2(&c[i][j], vl);
                        vfloat32m2_t v_c1 = __riscv_vle32_v_f32m2(&c[i][j+vl], vl);
                        
                        for (k = sk; k < k_end; k++) {
                            vfloat32m2_t v_b0 = __riscv_vle32_v_f32m2(&b[k][j], vl);
                            vfloat32m2_t v_b1 = __riscv_vle32_v_f32m2(&b[k][j+vl], vl);
                            float a_val = a[i][k];
                            
                            v_c0 = __riscv_vfmacc_vf_f32m2(v_c0, a_val, v_b0, vl);
                            v_c1 = __riscv_vfmacc_vf_f32m2(v_c1, a_val, v_b1, vl);
                        }
                        __riscv_vse32_v_f32m2(&c[i][j], v_c0, vl);
                        __riscv_vse32_v_f32m2(&c[i][j+vl], v_c1, vl);
                    }
				}
            }
        }
    }
}


int main(int argc, char *argv[]){
	float **a, **b, **c;      // Matrices
	size_t n, m, p;        // nxp * pxm = nxm
	struct timeval ti, tf; // Para tomar tiempos
    FILE *rfile;       // Fichero de resultados

	if(argc != 4) {
		printf("Uso: %s <n> <p> <m>\n"
			   "    GEMM. General Matrix Multiply. Multiplicación de matrices aleatorias.\n"
			   "    <n,p> * <p,m> = <n,m>\n", argv[0]);
		exit(EXIT_FAILURE);
	}
	n = atoi(argv[1]);
    if(n == 0 || !strcmp(argv[1],"0")) {
        printf("El argumento debe ser mayor que 0\n");
        exit(EXIT_FAILURE);
    }
	p = atoi(argv[2]);
    if(n == 0 || !strcmp(argv[2],"0")) {
        printf("El argumento debe ser mayor que 0\n");
        exit(EXIT_FAILURE);
    }
	m = atoi(argv[3]);
    if(n == 0 || !strcmp(argv[3],"0")) {
        printf("El argumento debe ser mayor que 0\n");
        exit(EXIT_FAILURE);
    }

    gettimeofday(&ti,NULL);
    
	// Creo directorio y abro archivo para estadísticas
	rfile = open_results_file(argv[0],argv[1],argv[2],argv[3]);
    if(!rfile) exit(EXIT_FAILURE);

	// Reserva dinámica de memoria de los arrays
	// Conviene que esté alineada al tamaño de línea de caché
    // posix_memalign() reserva memoria alineada
    // getconf -a | grep CACHE ofrece un tamaño de línea de caché de 64B
	if (posix_memalign((void **)&a,64,sizeof(float *)*n)) {
		perror("Error reservando memoria");
		fclose(rfile);
		exit(EXIT_FAILURE);
	}
	for(size_t i=0;i<n;i++)
		if (posix_memalign((void **)&a[i],64,sizeof(float)*p)) {
			perror("Error reservando memoria");
			fclose(rfile);
			exit(EXIT_FAILURE);
		}
    if (posix_memalign((void **)&b,64,sizeof(float *)*p)) {
		perror("Error reservando memoria");
		fclose(rfile);
		exit(EXIT_FAILURE);
	}
	for(size_t i=0;i<p;i++)
		if (posix_memalign((void **)&b[i],64,sizeof(float)*m)) {
			perror("Error reservando memoria");
			fclose(rfile);
			exit(EXIT_FAILURE);
		}
	if (posix_memalign((void **)&c,64,sizeof(float *)*n)) {
		perror("Error reservando memoria");
		fclose(rfile);
		exit(EXIT_FAILURE);
	}
	for(size_t i=0;i<n;i++)
		if (posix_memalign((void **)&c[i],64,sizeof(float)*m)) {
			perror("Error reservando memoria");
			fclose(rfile);
			exit(EXIT_FAILURE);
		}
	//Inicialización aleatoria del array
    //srandom(time(NULL));   // Descomentar si se quiere semilla diferente
    for (int i=0; i<n ; i++) {
		for(int j=0; j<p; j++) {
        	a[i][j] = (float) random() / (float) ((1 << 30) - 1);
		}
    }
	for (int i=0; i<p ; i++) {
		for(int j=0; j<m; j++) {
        	b[i][j] = (float) random() / (float) ((1 << 30) - 1);
		}
    }
	for (int i=0; i<n ; i++) {
		for(int j=0; j<m; j++) {
        	c[i][j] = 0.0f;
		}
    }
	gettimeofday(&tf,NULL);
	printf("Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/1000000.0);
	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/1000000.0);
	
	/*******************************************
	 * strcpy de los arrays                      *
	 * *****************************************/

	gettimeofday(&ti,NULL);

    GEMM(n, p,m, a, b,c);

	gettimeofday(&tf,NULL);
	/*******************************************/
	
	printf("Tamaño de tile: (%dx%d) elementos.\n",TILE_SIZE,TILE_SIZE);
	printf("Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/1000000.0);
	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/1000000.0);

	//Imprimir primeros 10 elementos
	printf("a = ");
    for(int i=0; i< ((p>10)?10:p); i++) {
        printf("%.4f ",a[0][i]);
        fprintf(rfile,"%.4f ",a[0][i]);
    }
    printf("\n");
    fprintf(rfile,"\n");

    printf("b = ");
    for(int i=0; i< ((m>10)?10:m); i++) {
        printf("%.4f ",b[0][i]);
        fprintf(rfile,"%.4f ",b[0][i]);
    }
	printf("\n");
    fprintf(rfile,"\n");

	printf("c = ");
    for(int i=0; i< ((m>10)?10:m); i++) {
        printf("%.4f ",c[0][i]);
        fprintf(rfile,"%.4f ",c[0][i]);
    }
	printf("\n");
    fprintf(rfile,"\n");

	// Limpiar y salir
	fclose(rfile);
	for(size_t i=0;i<n;i++)
		free(a[i]);
	free(a);
	for(size_t i=0;i<p;i++)
		free(b[i]);
	free(b);
	for(size_t i=0;i<n;i++)
		free(c[i]);
	free(c);

	return EXIT_SUCCESS;
}

FILE *open_results_file(char *progn, char *n, char *p, char *m) {
   	FILE *rfile;       // Fichero de resultados
	char *rfname;       // Nombre del fichero

    // Si no existe el directorio RESULT_DIR lo creo
    struct stat statbuf;
	if(stat(RESULT_DIR,&statbuf)) {
		if(mkdir(RESULT_DIR, 0755)) {
			perror("No se ha podido crear el directorio de resultados");
			return NULL;
		}
	}

	pid_t pid = getpid();
	time_t t = time(NULL);
	struct tm *tinfo = localtime(&t);
	// Obtengo los caracteres a reserver
	int num = snprintf(NULL, 0, "%s%s_%s_%s_%s_%d_%d_%d_%d", RESULT_DIR, progn, n, p, m, pid, tinfo->tm_hour, tinfo->tm_min, tinfo->tm_sec);
	rfname = (char *) malloc(sizeof(char)*num+1);
	if (!rfname) {
		perror("Error reservando memoria");
		return NULL;
	}

	// Nombre de fichero con pid y tiempo para que sea único
	sprintf(rfname,"%s%s_%s_%s_%s_%d_%d_%d_%d", RESULT_DIR, progn, n, p, m, pid, tinfo->tm_hour, tinfo->tm_min, tinfo->tm_sec);
	rfile = fopen(rfname,"w");
	if (!rfile) {
        free(rfname);
		perror("Error abriendo archivo de resultados");
		return NULL;
	}
    printf("Fichero de resultados: %s\n", rfname);
    free(rfname);
    return rfile;
}
