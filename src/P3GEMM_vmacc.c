#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdint.h>
#include<sys/time.h>
#include<sys/stat.h>
#include<unistd.h>
#include<time.h>

#include <riscv_vector.h>


#define RESULT_DIR "./results/"

FILE *open_results_file(char *progn, char *n, char *p, char *m);

void GEMM(size_t n, size_t p, size_t m, float **a, float **b, float **c) {
	size_t i, j, k;
	size_t vl;
	for (i = 0; i < n; i++) {
    	for (k = 0; k < p; k++) {
        	for (j = 0; j < m; j += vl) {
            	vl = __riscv_vsetvl_e32m8(m - j);
            	vfloat32m8_t v_c = __riscv_vle32_v_f32m8(&c[i][j], vl);
            	vfloat32m8_t v_b = __riscv_vle32_v_f32m8(&b[k][j], vl);
            	v_c = __riscv_vfmacc_vf_f32m8(v_c, a[i][k], v_b, vl);
            	__riscv_vse32_v_f32m8(&c[i][j], v_c, vl);
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
