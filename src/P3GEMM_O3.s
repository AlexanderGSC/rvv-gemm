   1              		.file	"P3GEMM.c"
   2              		.option pic
   3              		.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_v1p0_zicsr2p0_zifencei2p0_zve32f1p0_zve32x1p0_
   4              		.attribute unaligned_access, 1
   5              		.attribute stack_align, 16
   6              		.text
   7              	.Ltext0:
   8              		.file 0 "/users/ar006/P3" "P3GEMM.c"
   9              		.align	1
  10              		.globl	GEMM
  12              	GEMM:
  13              	.LFB65:
  14              		.file 1 "P3GEMM.c"
   1:P3GEMM.c      **** #include<stdio.h>
   2:P3GEMM.c      **** #include<stdlib.h>
   3:P3GEMM.c      **** #include<string.h>
   4:P3GEMM.c      **** #include<stdint.h>
   5:P3GEMM.c      **** #include<sys/time.h>
   6:P3GEMM.c      **** #include<sys/stat.h>
   7:P3GEMM.c      **** #include<unistd.h>
   8:P3GEMM.c      **** #include<time.h>
   9:P3GEMM.c      **** 
  10:P3GEMM.c      **** #define RESULT_DIR "./results/"
  11:P3GEMM.c      **** 
  12:P3GEMM.c      **** FILE *open_results_file(char *progn, char *n, char *p, char *m);
  13:P3GEMM.c      **** 
  14:P3GEMM.c      **** void GEMM(size_t n, size_t p, size_t m, float **a, float **b, float **c) {
  15              		.loc 1 14 74
  16              		.cfi_startproc
  17              	.LVL0:
  15:P3GEMM.c      **** 	size_t i, j, k;
  18              		.loc 1 15 2
  16:P3GEMM.c      **** 	
  17:P3GEMM.c      **** 	for (i = 0; i < n; i++)
  19              		.loc 1 17 2
  20              		.loc 1 17 16 discriminator 1
  21 0000 7DC5     		beq	a0,zero,.L28
  22 0002 AE8F     		mv	t6,a1
  23 0004 EDC5     		beq	a1,zero,.L28
  24 0006 B283     		mv	t2,a2
  25 0008 7DC2     		beq	a2,zero,.L28
  14:P3GEMM.c      **** 	size_t i, j, k;
  26              		.loc 1 14 74 is_stmt 0
  27 000a 7971     		addi	sp,sp,-48
  28              		.cfi_def_cfa_offset 48
  29 000c F32220C2 		csrr	t0,vlenb
  30 0010 22F4     		sd	s0,40(sp)
  31 0012 26F0     		sd	s1,32(sp)
  32 0014 4AEC     		sd	s2,24(sp)
  33 0016 4EE8     		sd	s3,16(sp)
  34 0018 52E4     		sd	s4,8(sp)
  35 001a 56E0     		sd	s5,0(sp)
  36              		.cfi_offset 8, -8
  37              		.cfi_offset 9, -16
  38              		.cfi_offset 18, -24
  39              		.cfi_offset 19, -32
  40              		.cfi_offset 20, -40
  41              		.cfi_offset 21, -48
  42 001c 2A84     		mv	s0,a0
  43 001e 3A8A     		mv	s4,a4
  44 0020 3E89     		mv	s2,a5
  45 0022 B684     		mv	s1,a3
  46 0024 E112     		addi	t0,t0,-8
  47 0026 931A2600 		slli	s5,a2,2
  48              		.loc 1 17 9
  49 002a 8149     		li	s3,0
  50              	.LVL1:
  51              	.L3:
  18:P3GEMM.c      **** 		for (k = 0; k < p; k++)
  52              		.loc 1 18 17 is_stmt 1 discriminator 1
  53 002c 03380900 		ld	a6,0(s2)
  54 0030 03BF0400 		ld	t5,0(s1)
  55 0034 528E     		mv	t3,s4
  19:P3GEMM.c      ****         	for (j = 0; j < m; j++) 
  20:P3GEMM.c      **** 			   	c[i][j] = c[i][j] + a[i][k]*b[k][j];
  56              		.loc 1 20 37 is_stmt 0
  57 0036 8148     		li	a7,0
  58 0038 B30E5801 		add	t4,a6,s5
  18:P3GEMM.c      **** 		for (k = 0; k < p; k++)
  59              		.loc 1 18 10
  60 003c 0143     		li	t1,0
  61              	.LVL2:
  62              	.L11:
  19:P3GEMM.c      ****         	for (j = 0; j < m; j++) 
  63              		.loc 1 19 24 is_stmt 1 discriminator 1
  64              		.loc 1 20 32 is_stmt 0
  65 003e B3051F01 		add	a1,t5,a7
  66 0042 9108     		addi	a7,a7,4
  67 0044 33071F01 		add	a4,t5,a7
  68 0048 3337E800 		sltu	a4,a6,a4
  69 004c B3B7D501 		sltu	a5,a1,t4
  70 0050 13371700 		seqz	a4,a4
  71 0054 93B71700 		seqz	a5,a5
  72 0058 D98F     		or	a5,a5,a4
  73 005a 93F7F70F 		andi	a5,a5,0xff
  74              		.loc 1 20 37
  75 005e 03360E00 		ld	a2,0(t3)
  76              		.loc 1 20 19
  77 0062 4285     		mv	a0,a6
  78 0064 ADC3     		beq	a5,zero,.L10
  79 0066 93074600 		addi	a5,a2,4
  80 006a B307F840 		sub	a5,a6,a5
  81 006e 63FCF204 		bleu	a5,t0,.L10
  82 0072 87A70500 		flw	fa5,0(a1)
  83 0076 D777000D 		vsetvli	a5,zero,e32,m1,ta,ma
  84              		.loc 1 20 37
  85 007a 9E86     		mv	a3,t2
  86 007c 4287     		mv	a4,a6
  87 007e D7D1075E 		vfmv.v.f	v3,fa5
  88              	.LVL3:
  89              	.L4:
  90 0082 D7F7060D 		vsetvli	a5,a3,e32,m1,ta,ma
  91              		.loc 1 20 8 is_stmt 1
  92              		.loc 1 20 22 is_stmt 0
  93 0086 87600502 		vle32.v	v1,0(a0)
  94 008a 93952700 		slli	a1,a5,2
  95              		.loc 1 20 40
  96 008e 07610602 		vle32.v	v2,0(a2)
  19:P3GEMM.c      ****         	for (j = 0; j < m; j++) 
  97              		.loc 1 19 24 discriminator 1
  98 0092 9D8E     		sub	a3,a3,a5
  99 0094 2E95     		add	a0,a0,a1
 100 0096 2E96     		add	a2,a2,a1
 101              		.loc 1 20 26
 102 0098 D79021B2 		vfmacc.vv	v1,v3,v2
 103              		.loc 1 20 16
 104 009c A7600702 		vse32.v	v1,0(a4)
  19:P3GEMM.c      ****         	for (j = 0; j < m; j++) 
 105              		.loc 1 19 30 is_stmt 1 discriminator 3
  19:P3GEMM.c      ****         	for (j = 0; j < m; j++) 
 106              		.loc 1 19 24 discriminator 1
 107 00a0 2E97     		add	a4,a4,a1
 108 00a2 E5F2     		bne	a3,zero,.L4
  18:P3GEMM.c      **** 		for (k = 0; k < p; k++)
 109              		.loc 1 18 23 discriminator 2
 110 00a4 0503     		addi	t1,t1,1
 111              	.LVL4:
  18:P3GEMM.c      **** 		for (k = 0; k < p; k++)
 112              		.loc 1 18 17 discriminator 1
 113 00a6 210E     		addi	t3,t3,8
 114 00a8 E39B6FF8 		bne	t6,t1,.L11
 115              	.L7:
  17:P3GEMM.c      **** 		for (k = 0; k < p; k++)
 116              		.loc 1 17 22 discriminator 2
 117 00ac 8509     		addi	s3,s3,1
 118              	.LVL5:
  17:P3GEMM.c      **** 		for (k = 0; k < p; k++)
 119              		.loc 1 17 16 discriminator 1
 120 00ae 2109     		addi	s2,s2,8
 121 00b0 A104     		addi	s1,s1,8
 122 00b2 E31D34F7 		bne	s0,s3,.L3
  21:P3GEMM.c      **** 
  22:P3GEMM.c      **** }
 123              		.loc 1 22 1 is_stmt 0
 124 00b6 2274     		ld	s0,40(sp)
 125              		.cfi_remember_state
 126              		.cfi_restore 8
 127              	.LVL6:
 128 00b8 8274     		ld	s1,32(sp)
 129              		.cfi_restore 9
 130 00ba 6269     		ld	s2,24(sp)
 131              		.cfi_restore 18
 132 00bc C269     		ld	s3,16(sp)
 133              		.cfi_restore 19
 134              	.LVL7:
 135 00be 226A     		ld	s4,8(sp)
 136              		.cfi_restore 20
 137              	.LVL8:
 138 00c0 826A     		ld	s5,0(sp)
 139              		.cfi_restore 21
 140 00c2 4561     		addi	sp,sp,48
 141              		.cfi_def_cfa_offset 0
 142 00c4 8280     		jr	ra
 143              	.LVL9:
 144              	.L10:
 145              		.cfi_restore_state
 146 00c6 C287     		mv	a5,a6
 147              	.LVL10:
 148              	.L6:
  20:P3GEMM.c      **** 
 149              		.loc 1 20 8 is_stmt 1
  20:P3GEMM.c      **** 
 150              		.loc 1 20 26 is_stmt 0
 151 00c8 87270600 		flw	fa5,0(a2)
 152 00cc 07A70700 		flw	fa4,0(a5)
 153 00d0 87A60500 		flw	fa3,0(a1)
  19:P3GEMM.c      **** 			   	c[i][j] = c[i][j] + a[i][k]*b[k][j];
 154              		.loc 1 19 24 discriminator 1
 155 00d4 9107     		addi	a5,a5,4
 156 00d6 1106     		addi	a2,a2,4
  20:P3GEMM.c      **** 
 157              		.loc 1 20 26
 158 00d8 C3F7D770 		fmadd.s	fa5,fa5,fa3,fa4
  20:P3GEMM.c      **** 
 159              		.loc 1 20 16
 160 00dc 27AEF7FE 		fsw	fa5,-4(a5)
  19:P3GEMM.c      **** 			   	c[i][j] = c[i][j] + a[i][k]*b[k][j];
 161              		.loc 1 19 30 is_stmt 1 discriminator 3
  19:P3GEMM.c      **** 			   	c[i][j] = c[i][j] + a[i][k]*b[k][j];
 162              		.loc 1 19 24 discriminator 1
 163 00e0 E394D7FF 		bne	a5,t4,.L6
  18:P3GEMM.c      ****         	for (j = 0; j < m; j++) 
 164              		.loc 1 18 23 discriminator 2
 165 00e4 0503     		addi	t1,t1,1
 166              	.LVL11:
  18:P3GEMM.c      ****         	for (j = 0; j < m; j++) 
 167              		.loc 1 18 17 discriminator 1
 168 00e6 210E     		addi	t3,t3,8
 169 00e8 E39B6FF4 		bne	t6,t1,.L11
 170 00ec C1B7     		j	.L7
 171              	.LVL12:
 172              	.L28:
 173              		.cfi_def_cfa_offset 0
 174              		.cfi_restore 8
 175              		.cfi_restore 9
 176              		.cfi_restore 18
 177              		.cfi_restore 19
 178              		.cfi_restore 20
 179              		.cfi_restore 21
 180 00ee 8280     		ret
 181              		.cfi_endproc
 182              	.LFE65:
 184              		.section	.rodata.str1.8,"aMS",@progbits,1
 185              		.align	3
 186              	.LC0:
 187 0000 2E2F7265 		.string	"./results/"
 187      73756C74 
 187      732F00
 188 000b 00000000 		.align	3
 188      00
 189              	.LC1:
 190 0010 4E6F2073 		.string	"No se ha podido crear el directorio de resultados"
 190      65206861 
 190      20706F64 
 190      69646F20 
 190      63726561 
 191 0042 00000000 		.align	3
 191      0000
 192              	.LC2:
 193 0048 25732573 		.string	"%s%s_%s_%s_%s_%d_%d_%d_%d"
 193      5F25735F 
 193      25735F25 
 193      735F2564 
 193      5F25645F 
 194 0062 00000000 		.align	3
 194      0000
 195              	.LC3:
 196 0068 4572726F 		.string	"Error reservando memoria"
 196      72207265 
 196      73657276 
 196      616E646F 
 196      206D656D 
 197 0081 00000000 		.align	3
 197      000000
 198              	.LC4:
 199 0088 7700     		.string	"w"
 200 008a 00000000 		.align	3
 200      0000
 201              	.LC5:
 202 0090 4572726F 		.string	"Error abriendo archivo de resultados"
 202      72206162 
 202      7269656E 
 202      646F2061 
 202      72636869 
 203 00b5 000000   		.align	3
 204              	.LC6:
 205 00b8 46696368 		.string	"Fichero de resultados: %s\n"
 205      65726F20 
 205      64652072 
 205      6573756C 
 205      7461646F 
 206              		.text
 207              		.align	1
 208              		.globl	open_results_file
 210              	open_results_file:
 211              	.LFB67:
  23:P3GEMM.c      **** 
  24:P3GEMM.c      **** int main(int argc, char *argv[]){
  25:P3GEMM.c      **** 	float **a, **b, **c;      // Matrices
  26:P3GEMM.c      **** 	size_t n, m, p;        // nxp * pxm = nxm
  27:P3GEMM.c      **** 	struct timeval ti, tf; // Para tomar tiempos
  28:P3GEMM.c      ****     FILE *rfile;       // Fichero de resultados
  29:P3GEMM.c      **** 
  30:P3GEMM.c      **** 	if(argc != 4) {
  31:P3GEMM.c      **** 		printf("Uso: %s <n> <p> <m>\n"
  32:P3GEMM.c      **** 			   "    GEMM. General Matrix Multiply. Multiplicación de matrices aleatorias.\n"
  33:P3GEMM.c      **** 			   "    <n,p> * <p,m> = <n,m>\n", argv[0]);
  34:P3GEMM.c      **** 		exit(EXIT_FAILURE);
  35:P3GEMM.c      **** 	}
  36:P3GEMM.c      **** 	n = atoi(argv[1]);
  37:P3GEMM.c      ****     if(n == 0 || !strcmp(argv[1],"0")) {
  38:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
  39:P3GEMM.c      ****         exit(EXIT_FAILURE);
  40:P3GEMM.c      ****     }
  41:P3GEMM.c      **** 	p = atoi(argv[2]);
  42:P3GEMM.c      ****     if(n == 0 || !strcmp(argv[2],"0")) {
  43:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
  44:P3GEMM.c      ****         exit(EXIT_FAILURE);
  45:P3GEMM.c      ****     }
  46:P3GEMM.c      **** 	m = atoi(argv[3]);
  47:P3GEMM.c      ****     if(n == 0 || !strcmp(argv[3],"0")) {
  48:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
  49:P3GEMM.c      ****         exit(EXIT_FAILURE);
  50:P3GEMM.c      ****     }
  51:P3GEMM.c      **** 
  52:P3GEMM.c      ****     gettimeofday(&ti,NULL);
  53:P3GEMM.c      ****     
  54:P3GEMM.c      **** 	// Creo directorio y abro archivo para estadísticas
  55:P3GEMM.c      **** 	rfile = open_results_file(argv[0],argv[1],argv[2],argv[3]);
  56:P3GEMM.c      ****     if(!rfile) exit(EXIT_FAILURE);
  57:P3GEMM.c      **** 
  58:P3GEMM.c      **** 	// Reserva dinámica de memoria de los arrays
  59:P3GEMM.c      **** 	// Conviene que esté alineada al tamaño de línea de caché
  60:P3GEMM.c      ****     // posix_memalign() reserva memoria alineada
  61:P3GEMM.c      ****     // getconf -a | grep CACHE ofrece un tamaño de línea de caché de 64B
  62:P3GEMM.c      **** 	if (posix_memalign((void **)&a,64,sizeof(float *)*n)) {
  63:P3GEMM.c      **** 		perror("Error reservando memoria");
  64:P3GEMM.c      **** 		fclose(rfile);
  65:P3GEMM.c      **** 		exit(EXIT_FAILURE);
  66:P3GEMM.c      **** 	}
  67:P3GEMM.c      **** 	for(size_t i=0;i<n;i++)
  68:P3GEMM.c      **** 		if (posix_memalign((void **)&a[i],64,sizeof(float)*p)) {
  69:P3GEMM.c      **** 			perror("Error reservando memoria");
  70:P3GEMM.c      **** 			fclose(rfile);
  71:P3GEMM.c      **** 			exit(EXIT_FAILURE);
  72:P3GEMM.c      **** 		}
  73:P3GEMM.c      ****     if (posix_memalign((void **)&b,64,sizeof(float *)*p)) {
  74:P3GEMM.c      **** 		perror("Error reservando memoria");
  75:P3GEMM.c      **** 		fclose(rfile);
  76:P3GEMM.c      **** 		exit(EXIT_FAILURE);
  77:P3GEMM.c      **** 	}
  78:P3GEMM.c      **** 	for(size_t i=0;i<p;i++)
  79:P3GEMM.c      **** 		if (posix_memalign((void **)&b[i],64,sizeof(float)*m)) {
  80:P3GEMM.c      **** 			perror("Error reservando memoria");
  81:P3GEMM.c      **** 			fclose(rfile);
  82:P3GEMM.c      **** 			exit(EXIT_FAILURE);
  83:P3GEMM.c      **** 		}
  84:P3GEMM.c      **** 	if (posix_memalign((void **)&c,64,sizeof(float *)*n)) {
  85:P3GEMM.c      **** 		perror("Error reservando memoria");
  86:P3GEMM.c      **** 		fclose(rfile);
  87:P3GEMM.c      **** 		exit(EXIT_FAILURE);
  88:P3GEMM.c      **** 	}
  89:P3GEMM.c      **** 	for(size_t i=0;i<n;i++)
  90:P3GEMM.c      **** 		if (posix_memalign((void **)&c[i],64,sizeof(float)*m)) {
  91:P3GEMM.c      **** 			perror("Error reservando memoria");
  92:P3GEMM.c      **** 			fclose(rfile);
  93:P3GEMM.c      **** 			exit(EXIT_FAILURE);
  94:P3GEMM.c      **** 		}
  95:P3GEMM.c      **** 	//Inicialización aleatoria del array
  96:P3GEMM.c      ****     //srandom(time(NULL));   // Descomentar si se quiere semilla diferente
  97:P3GEMM.c      ****     for (int i=0; i<n ; i++) {
  98:P3GEMM.c      **** 		for(int j=0; j<p; j++) {
  99:P3GEMM.c      ****         	a[i][j] = (float) random() / (float) ((1 << 30) - 1);
 100:P3GEMM.c      **** 		}
 101:P3GEMM.c      ****     }
 102:P3GEMM.c      **** 	for (int i=0; i<p ; i++) {
 103:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 104:P3GEMM.c      ****         	b[i][j] = (float) random() / (float) ((1 << 30) - 1);
 105:P3GEMM.c      **** 		}
 106:P3GEMM.c      ****     }
 107:P3GEMM.c      **** 	for (int i=0; i<n ; i++) {
 108:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 109:P3GEMM.c      ****         	c[i][j] = 0.0f;
 110:P3GEMM.c      **** 		}
 111:P3GEMM.c      ****     }
 112:P3GEMM.c      **** 	gettimeofday(&tf,NULL);
 113:P3GEMM.c      **** 	printf("Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 114:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 115:P3GEMM.c      **** 	
 116:P3GEMM.c      **** 	/*******************************************
 117:P3GEMM.c      **** 	 * strcpy de los arrays                      *
 118:P3GEMM.c      **** 	 * *****************************************/
 119:P3GEMM.c      **** 
 120:P3GEMM.c      **** 	gettimeofday(&ti,NULL);
 121:P3GEMM.c      **** 
 122:P3GEMM.c      ****     GEMM(n, p,m, a, b,c);
 123:P3GEMM.c      **** 
 124:P3GEMM.c      **** 	gettimeofday(&tf,NULL);
 125:P3GEMM.c      **** 	/*******************************************/
 126:P3GEMM.c      **** 	
 127:P3GEMM.c      **** 
 128:P3GEMM.c      **** 	printf("Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/1000000
 129:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 130:P3GEMM.c      **** 
 131:P3GEMM.c      **** 	//Imprimir primeros 10 elementos
 132:P3GEMM.c      **** 	printf("a = ");
 133:P3GEMM.c      ****     for(int i=0; i< ((p>10)?10:p); i++) {
 134:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 135:P3GEMM.c      ****         fprintf(rfile,"%.4f ",a[0][i]);
 136:P3GEMM.c      ****     }
 137:P3GEMM.c      ****     printf("\n");
 138:P3GEMM.c      ****     fprintf(rfile,"\n");
 139:P3GEMM.c      **** 
 140:P3GEMM.c      ****     printf("b = ");
 141:P3GEMM.c      ****     for(int i=0; i< ((m>10)?10:m); i++) {
 142:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 143:P3GEMM.c      ****         fprintf(rfile,"%.4f ",b[0][i]);
 144:P3GEMM.c      ****     }
 145:P3GEMM.c      **** 	printf("\n");
 146:P3GEMM.c      ****     fprintf(rfile,"\n");
 147:P3GEMM.c      **** 
 148:P3GEMM.c      **** 	printf("c = ");
 149:P3GEMM.c      ****     for(int i=0; i< ((m>10)?10:m); i++) {
 150:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 151:P3GEMM.c      ****         fprintf(rfile,"%.4f ",c[0][i]);
 152:P3GEMM.c      ****     }
 153:P3GEMM.c      **** 	printf("\n");
 154:P3GEMM.c      ****     fprintf(rfile,"\n");
 155:P3GEMM.c      **** 
 156:P3GEMM.c      **** 	// Limpiar y salir
 157:P3GEMM.c      **** 	fclose(rfile);
 158:P3GEMM.c      **** 	for(size_t i=0;i<n;i++)
 159:P3GEMM.c      **** 		free(a[i]);
 160:P3GEMM.c      **** 	free(a);
 161:P3GEMM.c      **** 	for(size_t i=0;i<p;i++)
 162:P3GEMM.c      **** 		free(b[i]);
 163:P3GEMM.c      **** 	free(b);
 164:P3GEMM.c      **** 	for(size_t i=0;i<n;i++)
 165:P3GEMM.c      **** 		free(c[i]);
 166:P3GEMM.c      **** 	free(c);
 167:P3GEMM.c      **** 
 168:P3GEMM.c      **** 	return EXIT_SUCCESS;
 169:P3GEMM.c      **** }
 170:P3GEMM.c      **** 
 171:P3GEMM.c      **** FILE *open_results_file(char *progn, char *n, char *p, char *m) {
 212              		.loc 1 171 65
 213              		.cfi_startproc
 214              	.LVL13:
 215 00f0 6D71     		addi	sp,sp,-272
 216              		.cfi_def_cfa_offset 272
 217 00f2 DEE5     		sd	s7,200(sp)
 218              		.cfi_offset 23, -72
 219 00f4 970B0000 		la	s7,__stack_chk_guard
 219      83BB0B00 
 220 00fc D6ED     		sd	s5,216(sp)
 221 00fe DAE9     		sd	s6,208(sp)
 222              		.cfi_offset 21, -56
 223              		.cfi_offset 22, -64
 224 0100 AA8A     		mv	s5,a0
 225 0102 2E8B     		mv	s6,a1
 172:P3GEMM.c      ****    	FILE *rfile;       // Fichero de resultados
 173:P3GEMM.c      **** 	char *rfname;       // Nombre del fichero
 174:P3GEMM.c      **** 
 175:P3GEMM.c      ****     // Si no existe el directorio RESULT_DIR lo creo
 176:P3GEMM.c      ****     struct stat statbuf;
 177:P3GEMM.c      **** 	if(stat(RESULT_DIR,&statbuf)) {
 226              		.loc 1 177 5 is_stmt 0
 227 0104 17050000 		lla	a0,.LC0
 227      13050500 
 228              	.LVL14:
 229 010c 2C18     		addi	a1,sp,56
 230              	.LVL15:
 171:P3GEMM.c      ****    	FILE *rfile;       // Fichero de resultados
 231              		.loc 1 171 65
 232 010e 83B70B00 		ld	a5, 0(s7)
 233 0112 3EFD     		sd	a5, 184(sp)
 234 0114 8147     		li	a5, 0
 172:P3GEMM.c      ****    	FILE *rfile;       // Fichero de resultados
 235              		.loc 1 172 5 is_stmt 1
 173:P3GEMM.c      **** 
 236              		.loc 1 173 2
 176:P3GEMM.c      **** 	if(stat(RESULT_DIR,&statbuf)) {
 237              		.loc 1 176 5
 238              		.loc 1 177 2
 171:P3GEMM.c      ****    	FILE *rfile;       // Fichero de resultados
 239              		.loc 1 171 65 is_stmt 0
 240 0116 CAF9     		sd	s2,240(sp)
 241 0118 E2E1     		sd	s8,192(sp)
 242 011a 06E6     		sd	ra,264(sp)
 243 011c 22E2     		sd	s0,256(sp)
 244 011e A6FD     		sd	s1,248(sp)
 245 0120 CEF5     		sd	s3,232(sp)
 246 0122 D2F1     		sd	s4,224(sp)
 247              		.cfi_offset 18, -32
 248              		.cfi_offset 24, -80
 249              		.cfi_offset 1, -8
 250              		.cfi_offset 8, -16
 251              		.cfi_offset 9, -24
 252              		.cfi_offset 19, -40
 253              		.cfi_offset 20, -48
 171:P3GEMM.c      ****    	FILE *rfile;       // Fichero de resultados
 254              		.loc 1 171 65
 255 0124 328C     		mv	s8,a2
 256 0126 3689     		mv	s2,a3
 257              		.loc 1 177 5
 258 0128 97000000 		call	stat@plt
 258      E7800000 
 259              	.LVL16:
 260              		.loc 1 177 4 discriminator 1
 261 0130 09CD     		beq	a0,zero,.L35
 178:P3GEMM.c      **** 		if(mkdir(RESULT_DIR, 0755)) {
 262              		.loc 1 178 3 is_stmt 1
 263              		.loc 1 178 6 is_stmt 0
 264 0132 9305D01E 		li	a1,493
 265 0136 17050000 		lla	a0,.LC0
 265      13050500 
 266 013e 97000000 		call	mkdir@plt
 266      E7800000 
 267              	.LVL17:
 268              		.loc 1 178 5 discriminator 1
 269 0146 631B0512 		bne	a0,zero,.L49
 270              	.L35:
 179:P3GEMM.c      **** 			perror("No se ha podido crear el directorio de resultados");
 180:P3GEMM.c      **** 			return NULL;
 181:P3GEMM.c      **** 		}
 182:P3GEMM.c      **** 	}
 183:P3GEMM.c      **** 
 184:P3GEMM.c      **** 	pid_t pid = getpid();
 271              		.loc 1 184 2 is_stmt 1
 272              		.loc 1 184 14 is_stmt 0
 273 014a 97000000 		call	getpid@plt
 273      E7800000 
 274              	.LVL18:
 275 0152 AA89     		mv	s3,a0
 185:P3GEMM.c      **** 	time_t t = time(NULL);
 276              		.loc 1 185 13
 277 0154 0145     		li	a0,0
 278              	.LVL19:
 279              		.loc 1 185 2 is_stmt 1
 280              		.loc 1 185 13 is_stmt 0
 281 0156 97000000 		call	time@plt
 281      E7800000 
 282              	.LVL20:
 283 015e AA87     		mv	a5,a0
 186:P3GEMM.c      **** 	struct tm *tinfo = localtime(&t);
 284              		.loc 1 186 21
 285 0160 0818     		addi	a0,sp,48
 185:P3GEMM.c      **** 	time_t t = time(NULL);
 286              		.loc 1 185 9 discriminator 1
 287 0162 3EF8     		sd	a5,48(sp)
 288              		.loc 1 186 2 is_stmt 1
 289              		.loc 1 186 21 is_stmt 0
 290 0164 97000000 		call	localtime@plt
 290      E7800000 
 291              	.LVL21:
 292              	.LBB75:
 293              	.LBB76:
 294              		.file 2 "/usr/include/riscv64-linux-gnu/bits/stdio2.h"
   1:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** /* Checking macros for stdio functions.
   2:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    Copyright (C) 2004-2025 Free Software Foundation, Inc.
   3:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    This file is part of the GNU C Library.
   4:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
   5:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    The GNU C Library is free software; you can redistribute it and/or
   6:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    modify it under the terms of the GNU Lesser General Public
   7:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    License as published by the Free Software Foundation; either
   8:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    version 2.1 of the License, or (at your option) any later version.
   9:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
  10:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    The GNU C Library is distributed in the hope that it will be useful,
  11:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    but WITHOUT ANY WARRANTY; without even the implied warranty of
  12:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  13:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    Lesser General Public License for more details.
  14:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
  15:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    You should have received a copy of the GNU Lesser General Public
  16:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    License along with the GNU C Library; if not, see
  17:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****    <https://www.gnu.org/licenses/>.  */
  18:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
  19:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #ifndef _BITS_STDIO2_H
  20:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #define _BITS_STDIO2_H 1
  21:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
  22:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #ifndef _STDIO_H
  23:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** # error "Never include <bits/stdio2.h> directly; use <stdio.h> instead."
  24:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #endif
  25:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
  26:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #ifdef __va_arg_pack
  27:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __fortify_function int
  28:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __NTH (sprintf (char *__restrict __s, const char *__restrict __fmt, ...))
  29:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** {
  30:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
  31:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				  __glibc_objsize (__s), __fmt,
  32:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				  __va_arg_pack ());
  33:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** }
  34:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #elif __fortify_use_clang
  35:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** /* clang does not have __va_arg_pack, so defer to va_arg version.  */
  36:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __fortify_function_error_function __attribute_overloadable__ int
  37:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __NTH (sprintf (__fortify_clang_overload_arg (char *, __restrict, __s),
  38:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 		const char *__restrict __fmt, ...))
  39:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** {
  40:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   __gnuc_va_list __fortify_ap;
  41:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   __builtin_va_start (__fortify_ap, __fmt);
  42:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   int __r = __builtin___vsprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
  43:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				      __glibc_objsize (__s), __fmt,
  44:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				      __fortify_ap);
  45:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   __builtin_va_end (__fortify_ap);
  46:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   return __r;
  47:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** }
  48:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #elif !defined __cplusplus
  49:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** # define sprintf(str, ...) \
  50:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   __builtin___sprintf_chk (str, __USE_FORTIFY_LEVEL - 1,		      \
  51:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			   __glibc_objsize (str), __VA_ARGS__)
  52:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #endif
  53:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
  54:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __fortify_function __attribute_overloadable__ int
  55:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __NTH (vsprintf (__fortify_clang_overload_arg (char *, __restrict, __s),
  56:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 		 const char *__restrict __fmt, __gnuc_va_list __ap))
  57:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** {
  58:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   return __builtin___vsprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
  59:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				   __glibc_objsize (__s), __fmt, __ap);
  60:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** }
  61:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
  62:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #if defined __USE_ISOC99 || defined __USE_UNIX98
  63:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** # ifdef __va_arg_pack
  64:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __fortify_function int
  65:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __NTH (snprintf (char *__restrict __s, size_t __n,
  66:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 		 const char *__restrict __fmt, ...))
  67:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** {
  68:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
 295              		.loc 2 68 10 discriminator 1
 296 016c 1C41     		lw	a5,0(a0)
 297 016e DA88     		mv	a7,s6
 298 0170 5688     		mv	a6,s5
 299 0172 3EF4     		sd	a5,40(sp)
 300 0174 5441     		lw	a3,4(a0)
 301 0176 97070000 		lla	a5,.LC0
 301      93870700 
 302 017e 17070000 		lla	a4,.LC2
 302      13070700 
 303 0186 36F0     		sd	a3,32(sp)
 304 0188 1045     		lw	a2,8(a0)
 305 018a FD56     		li	a3,-1
 306 018c 8145     		li	a1,0
 307 018e 32EC     		sd	a2,24(sp)
 308              	.LBE76:
 309              	.LBE75:
 310              		.loc 1 186 21
 311 0190 2A84     		mv	s0,a0
 312              	.LVL22:
 187:P3GEMM.c      **** 	// Obtengo los caracteres a reserver
 188:P3GEMM.c      **** 	int num = snprintf(NULL, 0, "%s%s_%s_%s_%s_%d_%d_%d_%d", RESULT_DIR, progn, n, p, m, pid, tinfo->t
 313              		.loc 1 188 2 is_stmt 1
 314              	.LBB78:
 315              	.LBB77:
 316              		.loc 2 68 3
 317              		.loc 2 68 10 is_stmt 0 discriminator 1
 318 0192 0946     		li	a2,2
 319 0194 4EE8     		sd	s3,16(sp)
 320 0196 4AE4     		sd	s2,8(sp)
 321 0198 62E0     		sd	s8,0(sp)
 322 019a 0145     		li	a0,0
 323 019c 97000000 		call	__snprintf_chk@plt
 323      E7800000 
 324              	.LVL23:
 325              	.LBE77:
 326              	.LBE78:
 189:P3GEMM.c      **** 	rfname = (char *) malloc(sizeof(char)*num+1);
 327              		.loc 1 189 2 is_stmt 1
 328              		.loc 1 189 20 is_stmt 0
 329 01a4 130A1500 		addi	s4,a0,1
 330 01a8 5285     		mv	a0,s4
 331              	.LVL24:
 332 01aa 97000000 		call	malloc@plt
 332      E7800000 
 333              	.LVL25:
 334 01b2 AA84     		mv	s1,a0
 335              	.LVL26:
 190:P3GEMM.c      **** 	if (!rfname) {
 336              		.loc 1 190 2 is_stmt 1
 337              		.loc 1 190 5 is_stmt 0
 338 01b4 55C9     		beq	a0,zero,.L50
 191:P3GEMM.c      **** 		perror("Error reservando memoria");
 192:P3GEMM.c      **** 		return NULL;
 193:P3GEMM.c      **** 	}
 194:P3GEMM.c      **** 
 195:P3GEMM.c      **** 	// Nombre de fichero con pid y tiempo para que sea único
 196:P3GEMM.c      **** 	sprintf(rfname,"%s%s_%s_%s_%s_%d_%d_%d_%d", RESULT_DIR, progn, n, p, m, pid, tinfo->tm_hour, tinfo
 339              		.loc 1 196 2 is_stmt 1
 340              	.LVL27:
 341              	.LBB79:
 342              	.LBB80:
  30:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				  __glibc_objsize (__s), __fmt,
 343              		.loc 2 30 3
  30:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				  __glibc_objsize (__s), __fmt,
 344              		.loc 2 30 10 is_stmt 0 discriminator 1
 345 01b6 1C40     		lw	a5,0(s0)
 346 01b8 E288     		mv	a7,s8
 347 01ba 5A88     		mv	a6,s6
 348 01bc 3EF0     		sd	a5,32(sp)
 349 01be 5840     		lw	a4,4(s0)
 350 01c0 D687     		mv	a5,s5
 351 01c2 5286     		mv	a2,s4
 352 01c4 3AEC     		sd	a4,24(sp)
 353 01c6 1444     		lw	a3,8(s0)
 354 01c8 17070000 		lla	a4,.LC0
 354      13070700 
 355 01d0 8945     		li	a1,2
 356 01d2 36E8     		sd	a3,16(sp)
 357 01d4 4EE4     		sd	s3,8(sp)
 358 01d6 97060000 		lla	a3,.LC2
 358      93860600 
 359 01de 4AE0     		sd	s2,0(sp)
 360 01e0 97000000 		call	__sprintf_chk@plt
 360      E7800000 
 361              	.LVL28:
 362              	.LBE80:
 363              	.LBE79:
 197:P3GEMM.c      **** 	rfile = fopen(rfname,"w");
 364              		.loc 1 197 2 is_stmt 1
 365              		.loc 1 197 10 is_stmt 0
 366 01e8 2685     		mv	a0,s1
 367 01ea 97050000 		lla	a1,.LC4
 367      93850500 
 368 01f2 97000000 		call	fopen@plt
 368      E7800000 
 369              	.LVL29:
 370 01fa 2A84     		mv	s0,a0
 371              	.LVL30:
 198:P3GEMM.c      **** 	if (!rfile) {
 372              		.loc 1 198 2 is_stmt 1
 373              		.loc 1 198 5 is_stmt 0
 374 01fc 39C5     		beq	a0,zero,.L51
 199:P3GEMM.c      ****         free(rfname);
 200:P3GEMM.c      **** 		perror("Error abriendo archivo de resultados");
 201:P3GEMM.c      **** 		return NULL;
 202:P3GEMM.c      **** 	}
 203:P3GEMM.c      ****     printf("Fichero de resultados: %s\n", rfname);
 375              		.loc 1 203 5 is_stmt 1
 376              	.LVL31:
 377              	.LBB81:
 378              	.LBB82:
  69:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				   __glibc_objsize (__s), __fmt,
  70:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				   __va_arg_pack ());
  71:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** }
  72:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** # elif __fortify_use_clang
  73:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** /* clang does not have __va_arg_pack, so defer to va_arg version.  */
  74:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __fortify_function_error_function __attribute_overloadable__ int
  75:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __NTH (snprintf (__fortify_clang_overload_arg (char *, __restrict, __s),
  76:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 		 size_t __n, const char *__restrict __fmt, ...))
  77:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** {
  78:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   __gnuc_va_list __fortify_ap;
  79:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   __builtin_va_start (__fortify_ap, __fmt);
  80:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   int __r = __builtin___vsnprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
  81:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				       __glibc_objsize (__s), __fmt,
  82:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				       __fortify_ap);
  83:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   __builtin_va_end (__fortify_ap);
  84:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   return __r;
  85:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** }
  86:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** # elif !defined __cplusplus
  87:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #  define snprintf(str, len, ...) \
  88:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   __builtin___snprintf_chk (str, len, __USE_FORTIFY_LEVEL - 1,		      \
  89:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			    __glibc_objsize (str), __VA_ARGS__)
  90:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** # endif
  91:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
  92:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __fortify_function __attribute_overloadable__ int
  93:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __NTH (vsnprintf (__fortify_clang_overload_arg (char *, __restrict, __s),
  94:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 		  size_t __n, const char *__restrict __fmt,
  95:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 		  __gnuc_va_list __ap))
  96:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****      __fortify_clang_warning (__fortify_clang_bos_static_lt (__n, __s),
  97:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			      "call to vsnprintf may overflow the destination "
  98:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			      "buffer")
  99:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** {
 100:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   return __builtin___vsnprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
 101:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 				    __glibc_objsize (__s), __fmt, __ap);
 102:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** }
 103:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
 104:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #endif
 105:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
 106:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** #if __USE_FORTIFY_LEVEL > 1
 107:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** # ifdef __va_arg_pack
 108:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __fortify_function __nonnull ((1)) int
 109:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** fprintf (FILE *__restrict __stream, const char *__restrict __fmt, ...)
 110:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** {
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
 112:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 113:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** }
 114:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 
 115:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** __fortify_function int
 116:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** printf (const char *__restrict __fmt, ...)
 117:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** {
 118:/usr/include/riscv64-linux-gnu/bits/stdio2.h ****   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
 379              		.loc 2 118 3
 380              		.loc 2 118 10 is_stmt 0
 381 01fe 2686     		mv	a2,s1
 382 0200 97050000 		lla	a1,.LC6
 382      93850500 
 383 0208 0945     		li	a0,2
 384 020a 97000000 		call	__printf_chk@plt
 384      E7800000 
 385              	.LVL32:
 386              	.LBE82:
 387              	.LBE81:
 204:P3GEMM.c      ****     free(rfname);
 388              		.loc 1 204 5 is_stmt 1
 389 0212 2685     		mv	a0,s1
 390 0214 97000000 		call	free@plt
 390      E7800000 
 391              	.LVL33:
 205:P3GEMM.c      ****     return rfile;
 392              		.loc 1 205 5
 393              	.L34:
 206:P3GEMM.c      **** }
 394              		.loc 1 206 1 is_stmt 0
 395 021c 6A77     		ld	a4, 184(sp)
 396 021e 83B70B00 		ld	a5, 0(s7)
 397 0222 B98F     		xor	a5, a4, a5
 398 0224 0147     		li	a4, 0
 399 0226 91EF     		bne	a5,zero,.L52
 400 0228 B260     		ld	ra,264(sp)
 401              		.cfi_remember_state
 402              		.cfi_restore 1
 403 022a 2285     		mv	a0,s0
 404 022c 1264     		ld	s0,256(sp)
 405              		.cfi_restore 8
 406 022e EE74     		ld	s1,248(sp)
 407              		.cfi_restore 9
 408 0230 4E79     		ld	s2,240(sp)
 409              		.cfi_restore 18
 410              	.LVL34:
 411 0232 AE79     		ld	s3,232(sp)
 412              		.cfi_restore 19
 413 0234 0E7A     		ld	s4,224(sp)
 414              		.cfi_restore 20
 415 0236 EE6A     		ld	s5,216(sp)
 416              		.cfi_restore 21
 417              	.LVL35:
 418 0238 4E6B     		ld	s6,208(sp)
 419              		.cfi_restore 22
 420              	.LVL36:
 421 023a AE6B     		ld	s7,200(sp)
 422              		.cfi_restore 23
 423 023c 0E6C     		ld	s8,192(sp)
 424              		.cfi_restore 24
 425              	.LVL37:
 426 023e 5161     		addi	sp,sp,272
 427              		.cfi_def_cfa_offset 0
 428 0240 8280     		jr	ra
 429              	.LVL38:
 430              	.L52:
 431              		.cfi_restore_state
 432 0242 97000000 		call	__stack_chk_fail@plt
 432      E7800000 
 433              	.LVL39:
 434              	.L51:
 199:P3GEMM.c      **** 		perror("Error abriendo archivo de resultados");
 435              		.loc 1 199 9 is_stmt 1
 436 024a 2685     		mv	a0,s1
 437 024c 97000000 		call	free@plt
 437      E7800000 
 438              	.LVL40:
 200:P3GEMM.c      **** 		return NULL;
 439              		.loc 1 200 3
 440 0254 17050000 		lla	a0,.LC5
 440      13050500 
 441 025c 97000000 		call	perror@plt
 441      E7800000 
 442              	.LVL41:
 201:P3GEMM.c      **** 	}
 443              		.loc 1 201 3
 180:P3GEMM.c      **** 		}
 444              		.loc 1 180 11 is_stmt 0
 445 0264 0144     		li	s0,0
 446              	.LVL42:
 447 0266 5DBF     		j	.L34
 448              	.LVL43:
 449              	.L50:
 191:P3GEMM.c      **** 		return NULL;
 450              		.loc 1 191 3 is_stmt 1
 451 0268 17050000 		lla	a0,.LC3
 451      13050500 
 452 0270 97000000 		call	perror@plt
 452      E7800000 
 453              	.LVL44:
 192:P3GEMM.c      **** 	}
 454              		.loc 1 192 3
 180:P3GEMM.c      **** 		}
 455              		.loc 1 180 11 is_stmt 0
 456 0278 0144     		li	s0,0
 457              	.LVL45:
 458 027a 4DB7     		j	.L34
 459              	.LVL46:
 460              	.L49:
 179:P3GEMM.c      **** 			return NULL;
 461              		.loc 1 179 4 is_stmt 1
 462 027c 17050000 		lla	a0,.LC1
 462      13050500 
 463 0284 97000000 		call	perror@plt
 463      E7800000 
 464              	.LVL47:
 180:P3GEMM.c      **** 		}
 465              		.loc 1 180 4
 180:P3GEMM.c      **** 		}
 466              		.loc 1 180 11 is_stmt 0
 467 028c 0144     		li	s0,0
 468 028e 79B7     		j	.L34
 469              		.cfi_endproc
 470              	.LFE67:
 472              		.section	.rodata.str1.8
 473 00d3 00000000 		.align	3
 473      00
 474              	.LC7:
 475 00d8 55736F3A 		.string	"Uso: %s <n> <p> <m>\n    GEMM. General Matrix Multiply. Multiplicaci\303\263n de matrices
 475      20257320 
 475      3C6E3E20 
 475      3C703E20 
 475      3C6D3E0A 
 476 0152 00000000 		.align	3
 476      0000
 477              	.LC8:
 478 0158 456C2061 		.string	"El argumento debe ser mayor que 0"
 478      7267756D 
 478      656E746F 
 478      20646562 
 478      65207365 
 479 017a 00000000 		.align	3
 479      0000
 480              	.LC11:
 481 0180 5469656D 		.string	"Tiempo de inicializaci\303\263n: %.9f s\n"
 481      706F2064 
 481      6520696E 
 481      69636961 
 481      6C697A61 
 482 01a3 00000000 		.align	3
 482      00
 483              	.LC12:
 484 01a8 5469656D 		.string	"Tiempo de c\303\263mputo: %.9f s\n"
 484      706F2064 
 484      652063C3 
 484      B36D7075 
 484      746F3A20 
 485 01c4 00000000 		.align	3
 486              	.LC13:
 487 01c8 61203D20 		.string	"a = "
 487      00
 488 01cd 000000   		.align	3
 489              	.LC14:
 490 01d0 62203D20 		.string	"b = "
 490      00
 491 01d5 000000   		.align	3
 492              	.LC15:
 493 01d8 252E3466 		.string	"%.4f "
 493      2000
 494 01de 0000     		.align	3
 495              	.LC16:
 496 01e0 63203D20 		.string	"c = "
 496      00
 497              		.section	.text.startup,"ax",@progbits
 498              		.align	1
 499              		.globl	main
 501              	main:
 502              	.LFB66:
  24:P3GEMM.c      **** 	float **a, **b, **c;      // Matrices
 503              		.loc 1 24 33 is_stmt 1
 504              		.cfi_startproc
 505              	.LVL48:
 506 0000 1571     		addi	sp,sp,-224
 507              		.cfi_def_cfa_offset 224
 508 0002 17070000 		la	a4,__stack_chk_guard
 508      03370700 
 509 000a 1C63     		ld	a5, 0(a4)
 510 000c BEEC     		sd	a5, 88(sp)
 511 000e 8147     		li	a5, 0
  25:P3GEMM.c      **** 	size_t n, m, p;        // nxp * pxm = nxm
 512              		.loc 1 25 2
  26:P3GEMM.c      **** 	struct timeval ti, tf; // Para tomar tiempos
 513              		.loc 1 26 2
  27:P3GEMM.c      ****     FILE *rfile;       // Fichero de resultados
 514              		.loc 1 27 2
  28:P3GEMM.c      **** 
 515              		.loc 1 28 5
  30:P3GEMM.c      **** 		printf("Uso: %s <n> <p> <m>\n"
 516              		.loc 1 30 2
  24:P3GEMM.c      **** 	float **a, **b, **c;      // Matrices
 517              		.loc 1 24 33 is_stmt 0
 518 0010 CAE1     		sd	s2,192(sp)
 519 0012 86ED     		sd	ra,216(sp)
  30:P3GEMM.c      **** 		printf("Uso: %s <n> <p> <m>\n"
 520              		.loc 1 30 4
 521 0014 9147     		li	a5,4
 522              		.cfi_offset 18, -32
 523              		.cfi_offset 1, -8
  24:P3GEMM.c      **** 	float **a, **b, **c;      // Matrices
 524              		.loc 1 24 33
 525 0016 2E89     		mv	s2,a1
  30:P3GEMM.c      **** 		printf("Uso: %s <n> <p> <m>\n"
 526              		.loc 1 30 4
 527 0018 6318F55C 		bne	a0,a5,.L142
  36:P3GEMM.c      ****     if(n == 0 || !strcmp(argv[1],"0")) {
 528              		.loc 1 36 2 is_stmt 1
 529              	.LVL49:
 530              	.LBB83:
 531              	.LBB84:
 532              		.file 3 "/usr/include/stdlib.h"
   1:/usr/include/stdlib.h **** /* Copyright (C) 1991-2025 Free Software Foundation, Inc.
   2:/usr/include/stdlib.h ****    Copyright The GNU Toolchain Authors.
   3:/usr/include/stdlib.h ****    This file is part of the GNU C Library.
   4:/usr/include/stdlib.h **** 
   5:/usr/include/stdlib.h ****    The GNU C Library is free software; you can redistribute it and/or
   6:/usr/include/stdlib.h ****    modify it under the terms of the GNU Lesser General Public
   7:/usr/include/stdlib.h ****    License as published by the Free Software Foundation; either
   8:/usr/include/stdlib.h ****    version 2.1 of the License, or (at your option) any later version.
   9:/usr/include/stdlib.h **** 
  10:/usr/include/stdlib.h ****    The GNU C Library is distributed in the hope that it will be useful,
  11:/usr/include/stdlib.h ****    but WITHOUT ANY WARRANTY; without even the implied warranty of
  12:/usr/include/stdlib.h ****    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  13:/usr/include/stdlib.h ****    Lesser General Public License for more details.
  14:/usr/include/stdlib.h **** 
  15:/usr/include/stdlib.h ****    You should have received a copy of the GNU Lesser General Public
  16:/usr/include/stdlib.h ****    License along with the GNU C Library; if not, see
  17:/usr/include/stdlib.h ****    <https://www.gnu.org/licenses/>.  */
  18:/usr/include/stdlib.h **** 
  19:/usr/include/stdlib.h **** /*
  20:/usr/include/stdlib.h ****  *	ISO C99 Standard: 7.20 General utilities	<stdlib.h>
  21:/usr/include/stdlib.h ****  */
  22:/usr/include/stdlib.h **** 
  23:/usr/include/stdlib.h **** #ifndef	_STDLIB_H
  24:/usr/include/stdlib.h **** 
  25:/usr/include/stdlib.h **** #define __GLIBC_INTERNAL_STARTING_HEADER_IMPLEMENTATION
  26:/usr/include/stdlib.h **** #include <bits/libc-header-start.h>
  27:/usr/include/stdlib.h **** 
  28:/usr/include/stdlib.h **** /* Get size_t, wchar_t and NULL from <stddef.h>.  */
  29:/usr/include/stdlib.h **** #define __need_size_t
  30:/usr/include/stdlib.h **** #define __need_wchar_t
  31:/usr/include/stdlib.h **** #define __need_NULL
  32:/usr/include/stdlib.h **** #include <stddef.h>
  33:/usr/include/stdlib.h **** 
  34:/usr/include/stdlib.h **** __BEGIN_DECLS
  35:/usr/include/stdlib.h **** 
  36:/usr/include/stdlib.h **** #define	_STDLIB_H	1
  37:/usr/include/stdlib.h **** 
  38:/usr/include/stdlib.h **** #if (defined __USE_XOPEN || defined __USE_XOPEN2K8) && !defined _SYS_WAIT_H
  39:/usr/include/stdlib.h **** /* XPG requires a few symbols from <sys/wait.h> being defined.  */
  40:/usr/include/stdlib.h **** # include <bits/waitflags.h>
  41:/usr/include/stdlib.h **** # include <bits/waitstatus.h>
  42:/usr/include/stdlib.h **** 
  43:/usr/include/stdlib.h **** /* Define the macros <sys/wait.h> also would define this way.  */
  44:/usr/include/stdlib.h **** # define WEXITSTATUS(status)	__WEXITSTATUS (status)
  45:/usr/include/stdlib.h **** # define WTERMSIG(status)	__WTERMSIG (status)
  46:/usr/include/stdlib.h **** # define WSTOPSIG(status)	__WSTOPSIG (status)
  47:/usr/include/stdlib.h **** # define WIFEXITED(status)	__WIFEXITED (status)
  48:/usr/include/stdlib.h **** # define WIFSIGNALED(status)	__WIFSIGNALED (status)
  49:/usr/include/stdlib.h **** # define WIFSTOPPED(status)	__WIFSTOPPED (status)
  50:/usr/include/stdlib.h **** # ifdef __WIFCONTINUED
  51:/usr/include/stdlib.h **** #  define WIFCONTINUED(status)	__WIFCONTINUED (status)
  52:/usr/include/stdlib.h **** # endif
  53:/usr/include/stdlib.h **** #endif	/* X/Open or XPG7 and <sys/wait.h> not included.  */
  54:/usr/include/stdlib.h **** 
  55:/usr/include/stdlib.h **** /* _FloatN API tests for enablement.  */
  56:/usr/include/stdlib.h **** #include <bits/floatn.h>
  57:/usr/include/stdlib.h **** 
  58:/usr/include/stdlib.h **** /* Returned by `div'.  */
  59:/usr/include/stdlib.h **** typedef struct
  60:/usr/include/stdlib.h ****   {
  61:/usr/include/stdlib.h ****     int quot;			/* Quotient.  */
  62:/usr/include/stdlib.h ****     int rem;			/* Remainder.  */
  63:/usr/include/stdlib.h ****   } div_t;
  64:/usr/include/stdlib.h **** 
  65:/usr/include/stdlib.h **** /* Returned by `ldiv'.  */
  66:/usr/include/stdlib.h **** #ifndef __ldiv_t_defined
  67:/usr/include/stdlib.h **** typedef struct
  68:/usr/include/stdlib.h ****   {
  69:/usr/include/stdlib.h ****     long int quot;		/* Quotient.  */
  70:/usr/include/stdlib.h ****     long int rem;		/* Remainder.  */
  71:/usr/include/stdlib.h ****   } ldiv_t;
  72:/usr/include/stdlib.h **** # define __ldiv_t_defined	1
  73:/usr/include/stdlib.h **** #endif
  74:/usr/include/stdlib.h **** 
  75:/usr/include/stdlib.h **** #if defined __USE_ISOC99 && !defined __lldiv_t_defined
  76:/usr/include/stdlib.h **** /* Returned by `lldiv'.  */
  77:/usr/include/stdlib.h **** __extension__ typedef struct
  78:/usr/include/stdlib.h ****   {
  79:/usr/include/stdlib.h ****     long long int quot;		/* Quotient.  */
  80:/usr/include/stdlib.h ****     long long int rem;		/* Remainder.  */
  81:/usr/include/stdlib.h ****   } lldiv_t;
  82:/usr/include/stdlib.h **** # define __lldiv_t_defined	1
  83:/usr/include/stdlib.h **** #endif
  84:/usr/include/stdlib.h **** 
  85:/usr/include/stdlib.h **** 
  86:/usr/include/stdlib.h **** /* The largest number rand will return (same as INT_MAX).  */
  87:/usr/include/stdlib.h **** #define	RAND_MAX	2147483647
  88:/usr/include/stdlib.h **** 
  89:/usr/include/stdlib.h **** 
  90:/usr/include/stdlib.h **** /* We define these the same for all machines.
  91:/usr/include/stdlib.h ****    Changes from this to the outside world should be done in `_exit'.  */
  92:/usr/include/stdlib.h **** #define	EXIT_FAILURE	1	/* Failing exit status.  */
  93:/usr/include/stdlib.h **** #define	EXIT_SUCCESS	0	/* Successful exit status.  */
  94:/usr/include/stdlib.h **** 
  95:/usr/include/stdlib.h **** 
  96:/usr/include/stdlib.h **** /* Maximum length of a multibyte character in the current locale.  */
  97:/usr/include/stdlib.h **** #define	MB_CUR_MAX	(__ctype_get_mb_cur_max ())
  98:/usr/include/stdlib.h **** extern size_t __ctype_get_mb_cur_max (void) __THROW __wur;
  99:/usr/include/stdlib.h **** 
 100:/usr/include/stdlib.h **** 
 101:/usr/include/stdlib.h **** /* Convert a string to a floating-point number.  */
 102:/usr/include/stdlib.h **** extern double atof (const char *__nptr)
 103:/usr/include/stdlib.h ****      __THROW __attribute_pure__ __nonnull ((1)) __wur;
 104:/usr/include/stdlib.h **** /* Convert a string to an integer.  */
 105:/usr/include/stdlib.h **** extern int atoi (const char *__nptr)
 106:/usr/include/stdlib.h ****      __THROW __attribute_pure__ __nonnull ((1)) __wur;
 107:/usr/include/stdlib.h **** /* Convert a string to a long integer.  */
 108:/usr/include/stdlib.h **** extern long int atol (const char *__nptr)
 109:/usr/include/stdlib.h ****      __THROW __attribute_pure__ __nonnull ((1)) __wur;
 110:/usr/include/stdlib.h **** 
 111:/usr/include/stdlib.h **** #ifdef __USE_ISOC99
 112:/usr/include/stdlib.h **** /* Convert a string to a long long integer.  */
 113:/usr/include/stdlib.h **** __extension__ extern long long int atoll (const char *__nptr)
 114:/usr/include/stdlib.h ****      __THROW __attribute_pure__ __nonnull ((1)) __wur;
 115:/usr/include/stdlib.h **** #endif
 116:/usr/include/stdlib.h **** 
 117:/usr/include/stdlib.h **** /* Convert a string to a floating-point number.  */
 118:/usr/include/stdlib.h **** extern double strtod (const char *__restrict __nptr,
 119:/usr/include/stdlib.h **** 		      char **__restrict __endptr)
 120:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 121:/usr/include/stdlib.h **** 
 122:/usr/include/stdlib.h **** #ifdef	__USE_ISOC99
 123:/usr/include/stdlib.h **** /* Likewise for `float' and `long double' sizes of floating-point numbers.  */
 124:/usr/include/stdlib.h **** extern float strtof (const char *__restrict __nptr,
 125:/usr/include/stdlib.h **** 		     char **__restrict __endptr) __THROW __nonnull ((1));
 126:/usr/include/stdlib.h **** 
 127:/usr/include/stdlib.h **** extern long double strtold (const char *__restrict __nptr,
 128:/usr/include/stdlib.h **** 			    char **__restrict __endptr)
 129:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 130:/usr/include/stdlib.h **** #endif
 131:/usr/include/stdlib.h **** 
 132:/usr/include/stdlib.h **** /* Likewise for '_FloatN' and '_FloatNx'.  */
 133:/usr/include/stdlib.h **** 
 134:/usr/include/stdlib.h **** #if __HAVE_FLOAT16 && __GLIBC_USE (IEC_60559_TYPES_EXT)
 135:/usr/include/stdlib.h **** extern _Float16 strtof16 (const char *__restrict __nptr,
 136:/usr/include/stdlib.h **** 			  char **__restrict __endptr)
 137:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 138:/usr/include/stdlib.h **** #endif
 139:/usr/include/stdlib.h **** 
 140:/usr/include/stdlib.h **** #if __HAVE_FLOAT32 && __GLIBC_USE (IEC_60559_TYPES_EXT)
 141:/usr/include/stdlib.h **** extern _Float32 strtof32 (const char *__restrict __nptr,
 142:/usr/include/stdlib.h **** 			  char **__restrict __endptr)
 143:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 144:/usr/include/stdlib.h **** #endif
 145:/usr/include/stdlib.h **** 
 146:/usr/include/stdlib.h **** #if __HAVE_FLOAT64 && __GLIBC_USE (IEC_60559_TYPES_EXT)
 147:/usr/include/stdlib.h **** extern _Float64 strtof64 (const char *__restrict __nptr,
 148:/usr/include/stdlib.h **** 			  char **__restrict __endptr)
 149:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 150:/usr/include/stdlib.h **** #endif
 151:/usr/include/stdlib.h **** 
 152:/usr/include/stdlib.h **** #if __HAVE_FLOAT128 && __GLIBC_USE (IEC_60559_TYPES_EXT)
 153:/usr/include/stdlib.h **** extern _Float128 strtof128 (const char *__restrict __nptr,
 154:/usr/include/stdlib.h **** 			    char **__restrict __endptr)
 155:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 156:/usr/include/stdlib.h **** #endif
 157:/usr/include/stdlib.h **** 
 158:/usr/include/stdlib.h **** #if __HAVE_FLOAT32X && __GLIBC_USE (IEC_60559_TYPES_EXT)
 159:/usr/include/stdlib.h **** extern _Float32x strtof32x (const char *__restrict __nptr,
 160:/usr/include/stdlib.h **** 			    char **__restrict __endptr)
 161:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 162:/usr/include/stdlib.h **** #endif
 163:/usr/include/stdlib.h **** 
 164:/usr/include/stdlib.h **** #if __HAVE_FLOAT64X && __GLIBC_USE (IEC_60559_TYPES_EXT)
 165:/usr/include/stdlib.h **** extern _Float64x strtof64x (const char *__restrict __nptr,
 166:/usr/include/stdlib.h **** 			    char **__restrict __endptr)
 167:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 168:/usr/include/stdlib.h **** #endif
 169:/usr/include/stdlib.h **** 
 170:/usr/include/stdlib.h **** #if __HAVE_FLOAT128X && __GLIBC_USE (IEC_60559_TYPES_EXT)
 171:/usr/include/stdlib.h **** extern _Float128x strtof128x (const char *__restrict __nptr,
 172:/usr/include/stdlib.h **** 			      char **__restrict __endptr)
 173:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 174:/usr/include/stdlib.h **** #endif
 175:/usr/include/stdlib.h **** 
 176:/usr/include/stdlib.h **** /* Convert a string to a long integer.  */
 177:/usr/include/stdlib.h **** extern long int strtol (const char *__restrict __nptr,
 178:/usr/include/stdlib.h **** 			char **__restrict __endptr, int __base)
 179:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 180:/usr/include/stdlib.h **** /* Convert a string to an unsigned long integer.  */
 181:/usr/include/stdlib.h **** extern unsigned long int strtoul (const char *__restrict __nptr,
 182:/usr/include/stdlib.h **** 				  char **__restrict __endptr, int __base)
 183:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 184:/usr/include/stdlib.h **** 
 185:/usr/include/stdlib.h **** #ifdef __USE_MISC
 186:/usr/include/stdlib.h **** /* Convert a string to a quadword integer.  */
 187:/usr/include/stdlib.h **** __extension__
 188:/usr/include/stdlib.h **** extern long long int strtoq (const char *__restrict __nptr,
 189:/usr/include/stdlib.h **** 			     char **__restrict __endptr, int __base)
 190:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 191:/usr/include/stdlib.h **** /* Convert a string to an unsigned quadword integer.  */
 192:/usr/include/stdlib.h **** __extension__
 193:/usr/include/stdlib.h **** extern unsigned long long int strtouq (const char *__restrict __nptr,
 194:/usr/include/stdlib.h **** 				       char **__restrict __endptr, int __base)
 195:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 196:/usr/include/stdlib.h **** #endif /* Use misc.  */
 197:/usr/include/stdlib.h **** 
 198:/usr/include/stdlib.h **** #ifdef __USE_ISOC99
 199:/usr/include/stdlib.h **** /* Convert a string to a quadword integer.  */
 200:/usr/include/stdlib.h **** __extension__
 201:/usr/include/stdlib.h **** extern long long int strtoll (const char *__restrict __nptr,
 202:/usr/include/stdlib.h **** 			      char **__restrict __endptr, int __base)
 203:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 204:/usr/include/stdlib.h **** /* Convert a string to an unsigned quadword integer.  */
 205:/usr/include/stdlib.h **** __extension__
 206:/usr/include/stdlib.h **** extern unsigned long long int strtoull (const char *__restrict __nptr,
 207:/usr/include/stdlib.h **** 					char **__restrict __endptr, int __base)
 208:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 209:/usr/include/stdlib.h **** #endif /* ISO C99 or use MISC.  */
 210:/usr/include/stdlib.h **** 
 211:/usr/include/stdlib.h **** /* Versions of the above functions that handle '0b' and '0B' prefixes
 212:/usr/include/stdlib.h ****    in base 0 or 2.  */
 213:/usr/include/stdlib.h **** #if __GLIBC_USE (C23_STRTOL)
 214:/usr/include/stdlib.h **** # ifdef __REDIRECT
 215:/usr/include/stdlib.h **** extern long int __REDIRECT_NTH (strtol, (const char *__restrict __nptr,
 216:/usr/include/stdlib.h **** 					 char **__restrict __endptr,
 217:/usr/include/stdlib.h **** 					 int __base), __isoc23_strtol)
 218:/usr/include/stdlib.h ****      __nonnull ((1));
 219:/usr/include/stdlib.h **** extern unsigned long int __REDIRECT_NTH (strtoul,
 220:/usr/include/stdlib.h **** 					 (const char *__restrict __nptr,
 221:/usr/include/stdlib.h **** 					  char **__restrict __endptr,
 222:/usr/include/stdlib.h **** 					  int __base), __isoc23_strtoul)
 223:/usr/include/stdlib.h ****      __nonnull ((1));
 224:/usr/include/stdlib.h **** #  ifdef __USE_MISC
 225:/usr/include/stdlib.h **** __extension__
 226:/usr/include/stdlib.h **** extern long long int __REDIRECT_NTH (strtoq, (const char *__restrict __nptr,
 227:/usr/include/stdlib.h **** 					      char **__restrict __endptr,
 228:/usr/include/stdlib.h **** 					      int __base), __isoc23_strtoll)
 229:/usr/include/stdlib.h ****      __nonnull ((1));
 230:/usr/include/stdlib.h **** __extension__
 231:/usr/include/stdlib.h **** extern unsigned long long int __REDIRECT_NTH (strtouq,
 232:/usr/include/stdlib.h **** 					      (const char *__restrict __nptr,
 233:/usr/include/stdlib.h **** 					       char **__restrict __endptr,
 234:/usr/include/stdlib.h **** 					       int __base), __isoc23_strtoull)
 235:/usr/include/stdlib.h ****      __nonnull ((1));
 236:/usr/include/stdlib.h **** #  endif
 237:/usr/include/stdlib.h **** __extension__
 238:/usr/include/stdlib.h **** extern long long int __REDIRECT_NTH (strtoll, (const char *__restrict __nptr,
 239:/usr/include/stdlib.h **** 					       char **__restrict __endptr,
 240:/usr/include/stdlib.h **** 					       int __base), __isoc23_strtoll)
 241:/usr/include/stdlib.h ****      __nonnull ((1));
 242:/usr/include/stdlib.h **** __extension__
 243:/usr/include/stdlib.h **** extern unsigned long long int __REDIRECT_NTH (strtoull,
 244:/usr/include/stdlib.h **** 					      (const char *__restrict __nptr,
 245:/usr/include/stdlib.h **** 					       char **__restrict __endptr,
 246:/usr/include/stdlib.h **** 					       int __base), __isoc23_strtoull)
 247:/usr/include/stdlib.h ****      __nonnull ((1));
 248:/usr/include/stdlib.h **** # else
 249:/usr/include/stdlib.h **** extern long int __isoc23_strtol (const char *__restrict __nptr,
 250:/usr/include/stdlib.h **** 				 char **__restrict __endptr, int __base)
 251:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 252:/usr/include/stdlib.h **** extern unsigned long int __isoc23_strtoul (const char *__restrict __nptr,
 253:/usr/include/stdlib.h **** 					   char **__restrict __endptr,
 254:/usr/include/stdlib.h **** 					   int __base)
 255:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 256:/usr/include/stdlib.h **** __extension__
 257:/usr/include/stdlib.h **** extern long long int __isoc23_strtoll (const char *__restrict __nptr,
 258:/usr/include/stdlib.h **** 				       char **__restrict __endptr, int __base)
 259:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 260:/usr/include/stdlib.h **** __extension__
 261:/usr/include/stdlib.h **** extern unsigned long long int __isoc23_strtoull (const char *__restrict __nptr,
 262:/usr/include/stdlib.h **** 						 char **__restrict __endptr,
 263:/usr/include/stdlib.h **** 						 int __base)
 264:/usr/include/stdlib.h ****      __THROW __nonnull ((1));
 265:/usr/include/stdlib.h **** #  define strtol __isoc23_strtol
 266:/usr/include/stdlib.h **** #  define strtoul __isoc23_strtoul
 267:/usr/include/stdlib.h **** #  ifdef __USE_MISC
 268:/usr/include/stdlib.h **** #   define strtoq __isoc23_strtoll
 269:/usr/include/stdlib.h **** #   define strtouq __isoc23_strtoull
 270:/usr/include/stdlib.h **** #  endif
 271:/usr/include/stdlib.h **** #  define strtoll __isoc23_strtoll
 272:/usr/include/stdlib.h **** #  define strtoull __isoc23_strtoull
 273:/usr/include/stdlib.h **** # endif
 274:/usr/include/stdlib.h **** #endif
 275:/usr/include/stdlib.h **** 
 276:/usr/include/stdlib.h **** /* Convert a floating-point number to a string.  */
 277:/usr/include/stdlib.h **** #if __GLIBC_USE (IEC_60559_BFP_EXT_C23)
 278:/usr/include/stdlib.h **** extern int strfromd (char *__dest, size_t __size, const char *__format,
 279:/usr/include/stdlib.h **** 		     double __f)
 280:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 281:/usr/include/stdlib.h **** 
 282:/usr/include/stdlib.h **** extern int strfromf (char *__dest, size_t __size, const char *__format,
 283:/usr/include/stdlib.h **** 		     float __f)
 284:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 285:/usr/include/stdlib.h **** 
 286:/usr/include/stdlib.h **** extern int strfroml (char *__dest, size_t __size, const char *__format,
 287:/usr/include/stdlib.h **** 		     long double __f)
 288:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 289:/usr/include/stdlib.h **** #endif
 290:/usr/include/stdlib.h **** 
 291:/usr/include/stdlib.h **** #if __HAVE_FLOAT16 && __GLIBC_USE (IEC_60559_TYPES_EXT)
 292:/usr/include/stdlib.h **** extern int strfromf16 (char *__dest, size_t __size, const char * __format,
 293:/usr/include/stdlib.h **** 		       _Float16 __f)
 294:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 295:/usr/include/stdlib.h **** #endif
 296:/usr/include/stdlib.h **** 
 297:/usr/include/stdlib.h **** #if __HAVE_FLOAT32 && __GLIBC_USE (IEC_60559_TYPES_EXT)
 298:/usr/include/stdlib.h **** extern int strfromf32 (char *__dest, size_t __size, const char * __format,
 299:/usr/include/stdlib.h **** 		       _Float32 __f)
 300:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 301:/usr/include/stdlib.h **** #endif
 302:/usr/include/stdlib.h **** 
 303:/usr/include/stdlib.h **** #if __HAVE_FLOAT64 && __GLIBC_USE (IEC_60559_TYPES_EXT)
 304:/usr/include/stdlib.h **** extern int strfromf64 (char *__dest, size_t __size, const char * __format,
 305:/usr/include/stdlib.h **** 		       _Float64 __f)
 306:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 307:/usr/include/stdlib.h **** #endif
 308:/usr/include/stdlib.h **** 
 309:/usr/include/stdlib.h **** #if __HAVE_FLOAT128 && __GLIBC_USE (IEC_60559_TYPES_EXT)
 310:/usr/include/stdlib.h **** extern int strfromf128 (char *__dest, size_t __size, const char * __format,
 311:/usr/include/stdlib.h **** 			_Float128 __f)
 312:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 313:/usr/include/stdlib.h **** #endif
 314:/usr/include/stdlib.h **** 
 315:/usr/include/stdlib.h **** #if __HAVE_FLOAT32X && __GLIBC_USE (IEC_60559_TYPES_EXT)
 316:/usr/include/stdlib.h **** extern int strfromf32x (char *__dest, size_t __size, const char * __format,
 317:/usr/include/stdlib.h **** 			_Float32x __f)
 318:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 319:/usr/include/stdlib.h **** #endif
 320:/usr/include/stdlib.h **** 
 321:/usr/include/stdlib.h **** #if __HAVE_FLOAT64X && __GLIBC_USE (IEC_60559_TYPES_EXT)
 322:/usr/include/stdlib.h **** extern int strfromf64x (char *__dest, size_t __size, const char * __format,
 323:/usr/include/stdlib.h **** 			_Float64x __f)
 324:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 325:/usr/include/stdlib.h **** #endif
 326:/usr/include/stdlib.h **** 
 327:/usr/include/stdlib.h **** #if __HAVE_FLOAT128X && __GLIBC_USE (IEC_60559_TYPES_EXT)
 328:/usr/include/stdlib.h **** extern int strfromf128x (char *__dest, size_t __size, const char * __format,
 329:/usr/include/stdlib.h **** 			 _Float128x __f)
 330:/usr/include/stdlib.h ****      __THROW __nonnull ((3));
 331:/usr/include/stdlib.h **** #endif
 332:/usr/include/stdlib.h **** 
 333:/usr/include/stdlib.h **** 
 334:/usr/include/stdlib.h **** #ifdef __USE_GNU
 335:/usr/include/stdlib.h **** /* Parallel versions of the functions above which take the locale to
 336:/usr/include/stdlib.h ****    use as an additional parameter.  These are GNU extensions inspired
 337:/usr/include/stdlib.h ****    by the POSIX.1-2008 extended locale API.  */
 338:/usr/include/stdlib.h **** # include <bits/types/locale_t.h>
 339:/usr/include/stdlib.h **** 
 340:/usr/include/stdlib.h **** extern long int strtol_l (const char *__restrict __nptr,
 341:/usr/include/stdlib.h **** 			  char **__restrict __endptr, int __base,
 342:/usr/include/stdlib.h **** 			  locale_t __loc) __THROW __nonnull ((1, 4));
 343:/usr/include/stdlib.h **** 
 344:/usr/include/stdlib.h **** extern unsigned long int strtoul_l (const char *__restrict __nptr,
 345:/usr/include/stdlib.h **** 				    char **__restrict __endptr,
 346:/usr/include/stdlib.h **** 				    int __base, locale_t __loc)
 347:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 4));
 348:/usr/include/stdlib.h **** 
 349:/usr/include/stdlib.h **** __extension__
 350:/usr/include/stdlib.h **** extern long long int strtoll_l (const char *__restrict __nptr,
 351:/usr/include/stdlib.h **** 				char **__restrict __endptr, int __base,
 352:/usr/include/stdlib.h **** 				locale_t __loc)
 353:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 4));
 354:/usr/include/stdlib.h **** 
 355:/usr/include/stdlib.h **** __extension__
 356:/usr/include/stdlib.h **** extern unsigned long long int strtoull_l (const char *__restrict __nptr,
 357:/usr/include/stdlib.h **** 					  char **__restrict __endptr,
 358:/usr/include/stdlib.h **** 					  int __base, locale_t __loc)
 359:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 4));
 360:/usr/include/stdlib.h **** 
 361:/usr/include/stdlib.h **** /* Versions of the above functions that handle '0b' and '0B' prefixes
 362:/usr/include/stdlib.h ****    in base 0 or 2.  */
 363:/usr/include/stdlib.h **** # if __GLIBC_USE (C23_STRTOL)
 364:/usr/include/stdlib.h **** #  ifdef __REDIRECT
 365:/usr/include/stdlib.h **** extern long int __REDIRECT_NTH (strtol_l, (const char *__restrict __nptr,
 366:/usr/include/stdlib.h **** 					   char **__restrict __endptr,
 367:/usr/include/stdlib.h **** 					   int __base, locale_t __loc),
 368:/usr/include/stdlib.h **** 				__isoc23_strtol_l)
 369:/usr/include/stdlib.h ****      __nonnull ((1, 4));
 370:/usr/include/stdlib.h **** extern unsigned long int __REDIRECT_NTH (strtoul_l,
 371:/usr/include/stdlib.h **** 					 (const char *__restrict __nptr,
 372:/usr/include/stdlib.h **** 					  char **__restrict __endptr,
 373:/usr/include/stdlib.h **** 					  int __base, locale_t __loc),
 374:/usr/include/stdlib.h **** 					 __isoc23_strtoul_l)
 375:/usr/include/stdlib.h ****      __nonnull ((1, 4));
 376:/usr/include/stdlib.h **** __extension__
 377:/usr/include/stdlib.h **** extern long long int __REDIRECT_NTH (strtoll_l, (const char *__restrict __nptr,
 378:/usr/include/stdlib.h **** 						 char **__restrict __endptr,
 379:/usr/include/stdlib.h **** 						 int __base,
 380:/usr/include/stdlib.h **** 						 locale_t __loc),
 381:/usr/include/stdlib.h **** 				     __isoc23_strtoll_l)
 382:/usr/include/stdlib.h ****      __nonnull ((1, 4));
 383:/usr/include/stdlib.h **** __extension__
 384:/usr/include/stdlib.h **** extern unsigned long long int __REDIRECT_NTH (strtoull_l,
 385:/usr/include/stdlib.h **** 					      (const char *__restrict __nptr,
 386:/usr/include/stdlib.h **** 					       char **__restrict __endptr,
 387:/usr/include/stdlib.h **** 					       int __base, locale_t __loc),
 388:/usr/include/stdlib.h **** 					      __isoc23_strtoull_l)
 389:/usr/include/stdlib.h ****      __nonnull ((1, 4));
 390:/usr/include/stdlib.h **** #  else
 391:/usr/include/stdlib.h **** extern long int __isoc23_strtol_l (const char *__restrict __nptr,
 392:/usr/include/stdlib.h **** 				   char **__restrict __endptr, int __base,
 393:/usr/include/stdlib.h **** 				   locale_t __loc) __THROW __nonnull ((1, 4));
 394:/usr/include/stdlib.h **** extern unsigned long int __isoc23_strtoul_l (const char *__restrict __nptr,
 395:/usr/include/stdlib.h **** 					     char **__restrict __endptr,
 396:/usr/include/stdlib.h **** 					     int __base, locale_t __loc)
 397:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 4));
 398:/usr/include/stdlib.h **** __extension__
 399:/usr/include/stdlib.h **** extern long long int __isoc23_strtoll_l (const char *__restrict __nptr,
 400:/usr/include/stdlib.h **** 					 char **__restrict __endptr,
 401:/usr/include/stdlib.h **** 					 int __base, locale_t __loc)
 402:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 4));
 403:/usr/include/stdlib.h **** __extension__
 404:/usr/include/stdlib.h **** extern unsigned long long int __isoc23_strtoull_l (const char *__restrict __nptr,
 405:/usr/include/stdlib.h **** 						   char **__restrict __endptr,
 406:/usr/include/stdlib.h **** 						   int __base, locale_t __loc)
 407:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 4));
 408:/usr/include/stdlib.h **** #   define strtol_l __isoc23_strtol_l
 409:/usr/include/stdlib.h **** #   define strtoul_l __isoc23_strtoul_l
 410:/usr/include/stdlib.h **** #   define strtoll_l __isoc23_strtoll_l
 411:/usr/include/stdlib.h **** #   define strtoull_l __isoc23_strtoull_l
 412:/usr/include/stdlib.h **** #  endif
 413:/usr/include/stdlib.h **** # endif
 414:/usr/include/stdlib.h **** 
 415:/usr/include/stdlib.h **** extern double strtod_l (const char *__restrict __nptr,
 416:/usr/include/stdlib.h **** 			char **__restrict __endptr, locale_t __loc)
 417:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 418:/usr/include/stdlib.h **** 
 419:/usr/include/stdlib.h **** extern float strtof_l (const char *__restrict __nptr,
 420:/usr/include/stdlib.h **** 		       char **__restrict __endptr, locale_t __loc)
 421:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 422:/usr/include/stdlib.h **** 
 423:/usr/include/stdlib.h **** extern long double strtold_l (const char *__restrict __nptr,
 424:/usr/include/stdlib.h **** 			      char **__restrict __endptr,
 425:/usr/include/stdlib.h **** 			      locale_t __loc)
 426:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 427:/usr/include/stdlib.h **** 
 428:/usr/include/stdlib.h **** # if __HAVE_FLOAT16
 429:/usr/include/stdlib.h **** extern _Float16 strtof16_l (const char *__restrict __nptr,
 430:/usr/include/stdlib.h **** 			    char **__restrict __endptr,
 431:/usr/include/stdlib.h **** 			    locale_t __loc)
 432:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 433:/usr/include/stdlib.h **** # endif
 434:/usr/include/stdlib.h **** 
 435:/usr/include/stdlib.h **** # if __HAVE_FLOAT32
 436:/usr/include/stdlib.h **** extern _Float32 strtof32_l (const char *__restrict __nptr,
 437:/usr/include/stdlib.h **** 			    char **__restrict __endptr,
 438:/usr/include/stdlib.h **** 			    locale_t __loc)
 439:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 440:/usr/include/stdlib.h **** # endif
 441:/usr/include/stdlib.h **** 
 442:/usr/include/stdlib.h **** # if __HAVE_FLOAT64
 443:/usr/include/stdlib.h **** extern _Float64 strtof64_l (const char *__restrict __nptr,
 444:/usr/include/stdlib.h **** 			    char **__restrict __endptr,
 445:/usr/include/stdlib.h **** 			    locale_t __loc)
 446:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 447:/usr/include/stdlib.h **** # endif
 448:/usr/include/stdlib.h **** 
 449:/usr/include/stdlib.h **** # if __HAVE_FLOAT128
 450:/usr/include/stdlib.h **** extern _Float128 strtof128_l (const char *__restrict __nptr,
 451:/usr/include/stdlib.h **** 			      char **__restrict __endptr,
 452:/usr/include/stdlib.h **** 			      locale_t __loc)
 453:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 454:/usr/include/stdlib.h **** # endif
 455:/usr/include/stdlib.h **** 
 456:/usr/include/stdlib.h **** # if __HAVE_FLOAT32X
 457:/usr/include/stdlib.h **** extern _Float32x strtof32x_l (const char *__restrict __nptr,
 458:/usr/include/stdlib.h **** 			      char **__restrict __endptr,
 459:/usr/include/stdlib.h **** 			      locale_t __loc)
 460:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 461:/usr/include/stdlib.h **** # endif
 462:/usr/include/stdlib.h **** 
 463:/usr/include/stdlib.h **** # if __HAVE_FLOAT64X
 464:/usr/include/stdlib.h **** extern _Float64x strtof64x_l (const char *__restrict __nptr,
 465:/usr/include/stdlib.h **** 			      char **__restrict __endptr,
 466:/usr/include/stdlib.h **** 			      locale_t __loc)
 467:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 468:/usr/include/stdlib.h **** # endif
 469:/usr/include/stdlib.h **** 
 470:/usr/include/stdlib.h **** # if __HAVE_FLOAT128X
 471:/usr/include/stdlib.h **** extern _Float128x strtof128x_l (const char *__restrict __nptr,
 472:/usr/include/stdlib.h **** 				char **__restrict __endptr,
 473:/usr/include/stdlib.h **** 				locale_t __loc)
 474:/usr/include/stdlib.h ****      __THROW __nonnull ((1, 3));
 475:/usr/include/stdlib.h **** # endif
 476:/usr/include/stdlib.h **** #endif /* GNU */
 477:/usr/include/stdlib.h **** 
 478:/usr/include/stdlib.h **** 
 479:/usr/include/stdlib.h **** #ifdef __USE_EXTERN_INLINES
 480:/usr/include/stdlib.h **** __extern_inline int
 481:/usr/include/stdlib.h **** __NTH (atoi (const char *__nptr))
 482:/usr/include/stdlib.h **** {
 483:/usr/include/stdlib.h ****   return (int) strtol (__nptr, (char **) NULL, 10);
 533              		.loc 3 483 3
 534              		.loc 3 483 16 is_stmt 0
 535 001c 8865     		ld	a0,8(a1)
 536              	.LVL50:
 537 001e 2946     		li	a2,10
 538 0020 8145     		li	a1,0
 539              	.LVL51:
 540 0022 5EED     		sd	s7,152(sp)
 541              		.cfi_offset 23, -72
 542 0024 97000000 		call	strtol@plt
 542      E7800000 
 543              	.LVL52:
 544              	.LBE84:
 545              	.LBE83:
  36:P3GEMM.c      ****     if(n == 0 || !strcmp(argv[1],"0")) {
 546              		.loc 1 36 4 discriminator 1
 547 002c 9B0B0500 		sext.w	s7,a0
 548              	.LVL53:
  37:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 549              		.loc 1 37 5 is_stmt 1
  37:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 550              		.loc 1 37 7 is_stmt 0
 551 0030 63840B58 		beq	s7,zero,.L134
  37:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 552              		.loc 1 37 19 discriminator 1
 553 0034 83368900 		ld	a3,8(s2)
 554 0038 83C70600 		lbu	a5,0(a3)
 555 003c 9B8707FD 		addiw	a5,a5,-48
 556 0040 1B870700 		sext.w	a4,a5
 557 0044 638D0754 		beq	a5,zero,.L143
 558              	.L56:
 559 0048 A2E9     		sd	s0,208(sp)
 560              		.cfi_offset 8, -16
  37:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 561              		.loc 1 37 15 discriminator 1
 562 004a 6307075E 		beq	a4,zero,.L135
  41:P3GEMM.c      ****     if(n == 0 || !strcmp(argv[2],"0")) {
 563              		.loc 1 41 2 is_stmt 1
 564              	.LVL54:
 565              	.LBB85:
 566              	.LBB86:
 567              		.loc 3 483 3
 568              		.loc 3 483 16 is_stmt 0
 569 004e 03350901 		ld	a0,16(s2)
 570 0052 2946     		li	a2,10
 571 0054 8145     		li	a1,0
 572 0056 97000000 		call	strtol@plt
 572      E7800000 
 573              	.LVL55:
 574              	.LBE86:
 575              	.LBE85:
  42:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 576              		.loc 1 42 19 discriminator 1
 577 005e 83360901 		ld	a3,16(s2)
  41:P3GEMM.c      ****     if(n == 0 || !strcmp(argv[2],"0")) {
 578              		.loc 1 41 4 discriminator 1
 579 0062 1B040500 		sext.w	s0,a0
 580              	.LVL56:
  42:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 581              		.loc 1 42 5 is_stmt 1
  42:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 582              		.loc 1 42 19 is_stmt 0 discriminator 1
 583 0066 83C70600 		lbu	a5,0(a3)
 584 006a 9B8707FD 		addiw	a5,a5,-48
 585 006e 1B870700 		sext.w	a4,a5
 586 0072 63830752 		beq	a5,zero,.L144
 587              	.L58:
  42:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 588              		.loc 1 42 15 discriminator 1
 589 0076 6301075C 		beq	a4,zero,.L135
  46:P3GEMM.c      ****     if(n == 0 || !strcmp(argv[3],"0")) {
 590              		.loc 1 46 2 is_stmt 1
 591              	.LVL57:
 592              	.LBB87:
 593              	.LBB88:
 594              		.loc 3 483 3
 595              		.loc 3 483 16 is_stmt 0
 596 007a 03358901 		ld	a0,24(s2)
 597 007e 2946     		li	a2,10
 598 0080 8145     		li	a1,0
 599 0082 A6E5     		sd	s1,200(sp)
 600              		.cfi_offset 9, -24
 601 0084 97000000 		call	strtol@plt
 601      E7800000 
 602              	.LVL58:
 603              	.LBE88:
 604              	.LBE87:
  47:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 605              		.loc 1 47 19 discriminator 1
 606 008c 83368901 		ld	a3,24(s2)
  46:P3GEMM.c      ****     if(n == 0 || !strcmp(argv[3],"0")) {
 607              		.loc 1 46 4 discriminator 1
 608 0090 9B040500 		sext.w	s1,a0
 609              	.LVL59:
  47:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 610              		.loc 1 47 5 is_stmt 1
  47:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 611              		.loc 1 47 19 is_stmt 0 discriminator 1
 612 0094 83C70600 		lbu	a5,0(a3)
 613 0098 9B8707FD 		addiw	a5,a5,-48
 614 009c 1B870700 		sext.w	a4,a5
 615 00a0 6389074E 		beq	a5,zero,.L145
 616              	.L59:
  47:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 617              		.loc 1 47 15 discriminator 1
 618 00a4 630C0750 		beq	a4,zero,.L55
  52:P3GEMM.c      ****     
 619              		.loc 1 52 5 is_stmt 1
 620 00a8 3C18     		addi	a5,sp,56
 621 00aa 3E85     		mv	a0,a5
 622 00ac 8145     		li	a1,0
 623 00ae 4EFD     		sd	s3,184(sp)
 624 00b0 3EEC     		sd	a5,24(sp)
 625              		.cfi_offset 19, -40
 626 00b2 97000000 		call	gettimeofday@plt
 626      E7800000 
 627              	.LVL60:
  55:P3GEMM.c      ****     if(!rfile) exit(EXIT_FAILURE);
 628              		.loc 1 55 2
  55:P3GEMM.c      ****     if(!rfile) exit(EXIT_FAILURE);
 629              		.loc 1 55 10 is_stmt 0
 630 00ba 83368901 		ld	a3,24(s2)
 631 00be 03360901 		ld	a2,16(s2)
 632 00c2 83358900 		ld	a1,8(s2)
 633 00c6 03350900 		ld	a0,0(s2)
 634 00ca 97000000 		call	open_results_file
 634      E7800000 
 635              	.LVL61:
 636 00d2 AA89     		mv	s3,a0
 637              	.LVL62:
  56:P3GEMM.c      **** 
 638              		.loc 1 56 5 is_stmt 1
  56:P3GEMM.c      **** 
 639              		.loc 1 56 7 is_stmt 0
 640 00d4 63050554 		beq	a0,zero,.L146
  62:P3GEMM.c      **** 		perror("Error reservando memoria");
 641              		.loc 1 62 2 is_stmt 1
 642 00d8 5AF1     		sd	s6,160(sp)
 643              		.cfi_offset 22, -64
  62:P3GEMM.c      **** 		perror("Error reservando memoria");
 644              		.loc 1 62 6 is_stmt 0
 645 00da 139B3B00 		slli	s6,s7,3
 646 00de 5A86     		mv	a2,s6
 647 00e0 93050004 		li	a1,64
 648 00e4 0810     		addi	a0,sp,32
 649              	.LVL63:
 650 00e6 97000000 		call	posix_memalign@plt
 650      E7800000 
 651              	.LVL64:
 652 00ee 52F9     		sd	s4,176(sp)
 653 00f0 56F5     		sd	s5,168(sp)
 654 00f2 62E9     		sd	s8,144(sp)
 655              		.cfi_offset 20, -48
 656              		.cfi_offset 21, -56
 657              		.cfi_offset 24, -80
 658 00f4 63140554 		bne	a0,zero,.L64
 659 00f8 8277     		ld	a5,32(sp)
 660              	.LBB89:
  68:P3GEMM.c      **** 			perror("Error reservando memoria");
 661              		.loc 1 68 7
 662 00fa 131C2400 		slli	s8,s0,2
  67:P3GEMM.c      **** 		if (posix_memalign((void **)&a[i],64,sizeof(float)*p)) {
 663              		.loc 1 67 13
 664 00fe 0149     		li	s2,0
 665              	.LVL65:
 666 0100 BE8A     		mv	s5,a5
 667 0102 3EE4     		sd	a5,8(sp)
 668              	.LVL66:
  67:P3GEMM.c      **** 		if (posix_memalign((void **)&a[i],64,sizeof(float)*p)) {
 669              		.loc 1 67 18 is_stmt 1 discriminator 1
 670 0104 3E8A     		mv	s4,a5
 671              	.LVL67:
 672              	.L62:
  68:P3GEMM.c      **** 			perror("Error reservando memoria");
 673              		.loc 1 68 3
  68:P3GEMM.c      **** 			perror("Error reservando memoria");
 674              		.loc 1 68 7 is_stmt 0
 675 0106 6286     		mv	a2,s8
 676 0108 93050004 		li	a1,64
 677 010c 5685     		mv	a0,s5
 678 010e 97000000 		call	posix_memalign@plt
 678      E7800000 
 679              	.LVL68:
 680 0116 63130552 		bne	a0,zero,.L64
  67:P3GEMM.c      **** 		if (posix_memalign((void **)&a[i],64,sizeof(float)*p)) {
 681              		.loc 1 67 22 is_stmt 1 discriminator 2
 682 011a 0509     		addi	s2,s2,1
 683              	.LVL69:
  67:P3GEMM.c      **** 		if (posix_memalign((void **)&a[i],64,sizeof(float)*p)) {
 684              		.loc 1 67 18 discriminator 1
 685 011c A10A     		addi	s5,s5,8
 686 011e E3942BFF 		bne	s7,s2,.L62
 687              	.LBE89:
  73:P3GEMM.c      **** 		perror("Error reservando memoria");
 688              		.loc 1 73 5
  73:P3GEMM.c      **** 		perror("Error reservando memoria");
 689              		.loc 1 73 9 is_stmt 0
 690 0122 93173400 		slli	a5,s0,3
 691 0126 3E86     		mv	a2,a5
 692 0128 93050004 		li	a1,64
 693 012c 2810     		addi	a0,sp,40
 694 012e 3EE8     		sd	a5,16(sp)
 695 0130 97000000 		call	posix_memalign@plt
 695      E7800000 
 696              	.LVL70:
 697 0138 63120550 		bne	a0,zero,.L64
 698 013c 227C     		ld	s8,40(sp)
 699 013e 6AE1     		sd	s10,128(sp)
 700              	.LVL71:
 701              	.LBB90:
  78:P3GEMM.c      **** 		if (posix_memalign((void **)&b[i],64,sizeof(float)*m)) {
 702              		.loc 1 78 18 is_stmt 1 discriminator 1
  79:P3GEMM.c      **** 			perror("Error reservando memoria");
 703              		.loc 1 79 7 is_stmt 0
 704 0140 939A2400 		slli	s5,s1,2
 705              		.cfi_offset 26, -96
  78:P3GEMM.c      **** 		if (posix_memalign((void **)&b[i],64,sizeof(float)*m)) {
 706              		.loc 1 78 13
 707 0144 014D     		li	s10,0
 708 0146 E28B     		mv	s7,s8
 709              	.LVL72:
  78:P3GEMM.c      **** 		if (posix_memalign((void **)&b[i],64,sizeof(float)*m)) {
 710              		.loc 1 78 18 discriminator 1
 711 0148 19CC     		beq	s0,zero,.L70
 712              	.LVL73:
 713              	.L69:
  79:P3GEMM.c      **** 			perror("Error reservando memoria");
 714              		.loc 1 79 3 is_stmt 1
  79:P3GEMM.c      **** 			perror("Error reservando memoria");
 715              		.loc 1 79 7 is_stmt 0
 716 014a 5686     		mv	a2,s5
 717 014c 93050004 		li	a1,64
 718 0150 5E85     		mv	a0,s7
 719 0152 97000000 		call	posix_memalign@plt
 719      E7800000 
 720              	.LVL74:
 721 015a 63190550 		bne	a0,zero,.L141
  78:P3GEMM.c      **** 		if (posix_memalign((void **)&b[i],64,sizeof(float)*m)) {
 722              		.loc 1 78 22 is_stmt 1 discriminator 2
 723 015e 050D     		addi	s10,s10,1
 724              	.LVL75:
  78:P3GEMM.c      **** 		if (posix_memalign((void **)&b[i],64,sizeof(float)*m)) {
 725              		.loc 1 78 18 discriminator 1
 726 0160 A10B     		addi	s7,s7,8
 727 0162 E314A4FF 		bne	s0,s10,.L69
 728              	.LVL76:
 729              	.L70:
 730              	.LBE90:
  84:P3GEMM.c      **** 		perror("Error reservando memoria");
 731              		.loc 1 84 2
  84:P3GEMM.c      **** 		perror("Error reservando memoria");
 732              		.loc 1 84 6 is_stmt 0
 733 0166 5A86     		mv	a2,s6
 734 0168 93050004 		li	a1,64
 735 016c 0818     		addi	a0,sp,48
 736 016e 97000000 		call	posix_memalign@plt
 736      E7800000 
 737              	.LVL77:
 738 0176 631B054E 		bne	a0,zero,.L141
 739 017a 427D     		ld	s10,48(sp)
 740 017c EEFC     		sd	s11,120(sp)
 741              	.LVL78:
 742              	.LBB91:
  89:P3GEMM.c      **** 		if (posix_memalign((void **)&c[i],64,sizeof(float)*m)) {
 743              		.loc 1 89 18 is_stmt 1 discriminator 1
  90:P3GEMM.c      **** 			perror("Error reservando memoria");
 744              		.loc 1 90 7 is_stmt 0
 745 017e 939B2400 		slli	s7,s1,2
 746              		.cfi_offset 27, -104
  89:P3GEMM.c      **** 		if (posix_memalign((void **)&c[i],64,sizeof(float)*m)) {
 747              		.loc 1 89 13
 748 0182 814D     		li	s11,0
 749 0184 EA8A     		mv	s5,s10
  90:P3GEMM.c      **** 			perror("Error reservando memoria");
 750              		.loc 1 90 7
 751 0186 6A8B     		mv	s6,s10
 752              	.LVL79:
 753              	.L71:
  90:P3GEMM.c      **** 			perror("Error reservando memoria");
 754              		.loc 1 90 3 is_stmt 1
  90:P3GEMM.c      **** 			perror("Error reservando memoria");
 755              		.loc 1 90 7 is_stmt 0
 756 0188 5E86     		mv	a2,s7
 757 018a 93050004 		li	a1,64
 758 018e 5A85     		mv	a0,s6
 759 0190 97000000 		call	posix_memalign@plt
 759      E7800000 
 760              	.LVL80:
 761 0198 6318054C 		bne	a0,zero,.L147
  89:P3GEMM.c      **** 		if (posix_memalign((void **)&c[i],64,sizeof(float)*m)) {
 762              		.loc 1 89 22 is_stmt 1 discriminator 2
 763 019c 850D     		addi	s11,s11,1
 764              	.LVL81:
  89:P3GEMM.c      **** 		if (posix_memalign((void **)&c[i],64,sizeof(float)*m)) {
 765              		.loc 1 89 18 discriminator 1
 766 019e 210B     		addi	s6,s6,8
 767 01a0 E3E42DFF 		bltu	s11,s2,.L71
 768 01a4 A2B4     		fsd	fs0,104(sp)
 769              		.cfi_offset 40, -120
 770 01a6 630F043E 		beq	s0,zero,.L148
 771 01aa 97070000 		flw	fs0,.LC9,a5
 771      07A40700 
 772 01b2 A26D     		ld	s11,8(sp)
 773              	.LVL82:
 774 01b4 66E5     		sd	s9,136(sp)
 775 01b6 014B     		li	s6,0
 776              		.cfi_offset 25, -88
 777              	.L73:
 778              	.LVL83:
 779              	.LBE91:
 780              	.LBB92:
 781              	.LBB93:
  98:P3GEMM.c      ****         	a[i][j] = (float) random() / (float) ((1 << 30) - 1);
 782              		.loc 1 98 17 discriminator 1
 783              	.LBE93:
 784              	.LBE92:
 785              	.LBB95:
  89:P3GEMM.c      **** 		if (posix_memalign((void **)&c[i],64,sizeof(float)*m)) {
 786              		.loc 1 89 13 is_stmt 0
 787 01b8 814C     		li	s9,0
 788              	.LVL84:
 789              	.L75:
 790              	.LBE95:
 791              	.LBB96:
 792              	.LBB94:
  99:P3GEMM.c      **** 		}
 793              		.loc 1 99 10 is_stmt 1
  99:P3GEMM.c      **** 		}
 794              		.loc 1 99 28 is_stmt 0
 795 01ba 97000000 		call	random@plt
 795      E7800000 
 796              	.LVL85:
  99:P3GEMM.c      **** 		}
 797              		.loc 1 99 20 discriminator 1
 798 01c2 D37725D0 		fcvt.s.l	fa5,a0
  99:P3GEMM.c      **** 		}
 799              		.loc 1 99 18 discriminator 1
 800 01c6 03B70D00 		ld	a4,0(s11)
 801 01ca 93962C00 		slli	a3,s9,2
  99:P3GEMM.c      **** 		}
 802              		.loc 1 99 37 discriminator 1
 803 01ce D3F78710 		fmul.s	fa5,fa5,fs0
  99:P3GEMM.c      **** 		}
 804              		.loc 1 99 18 discriminator 1
 805 01d2 3697     		add	a4,a4,a3
  98:P3GEMM.c      ****         	a[i][j] = (float) random() / (float) ((1 << 30) - 1);
 806              		.loc 1 98 17 discriminator 1
 807 01d4 850C     		addi	s9,s9,1
 808              	.LVL86:
  99:P3GEMM.c      **** 		}
 809              		.loc 1 99 18 discriminator 1
 810 01d6 2720F700 		fsw	fa5,0(a4)
  98:P3GEMM.c      ****         	a[i][j] = (float) random() / (float) ((1 << 30) - 1);
 811              		.loc 1 98 22 is_stmt 1 discriminator 3
 812              	.LVL87:
  98:P3GEMM.c      ****         	a[i][j] = (float) random() / (float) ((1 << 30) - 1);
 813              		.loc 1 98 17 discriminator 1
 814 01da E3908CFE 		bne	s9,s0,.L75
 815              	.LBE94:
  97:P3GEMM.c      **** 		for(int j=0; j<p; j++) {
 816              		.loc 1 97 26 discriminator 2
 817              	.LVL88:
  97:P3GEMM.c      **** 		for(int j=0; j<p; j++) {
 818              		.loc 1 97 20 discriminator 1
 819 01de 050B     		addi	s6,s6,1
 820              	.LVL89:
 821 01e0 A10D     		addi	s11,s11,8
 822 01e2 E36B2BFD 		bltu	s6,s2,.L73
 823              	.LVL90:
 824              	.LBE96:
 825              	.LBB97:
 102:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 826              		.loc 1 102 17 discriminator 1
 827 01e6 6382043C 		beq	s1,zero,.L136
 828 01ea E28D     		mv	s11,s8
 829              	.LBE97:
 830              	.LBB100:
  97:P3GEMM.c      **** 		for(int j=0; j<p; j++) {
 831              		.loc 1 97 20 is_stmt 0 discriminator 1
 832 01ec 014B     		li	s6,0
 833              	.LVL91:
 834              	.L78:
 835              	.LBE100:
 836              	.LBB101:
 837              	.LBB98:
 103:P3GEMM.c      ****         	b[i][j] = (float) random() / (float) ((1 << 30) - 1);
 838              		.loc 1 103 17 is_stmt 1 discriminator 1
 839              	.LBE98:
 840              	.LBE101:
 841              	.LBB102:
  89:P3GEMM.c      **** 		if (posix_memalign((void **)&c[i],64,sizeof(float)*m)) {
 842              		.loc 1 89 18 is_stmt 0 discriminator 1
 843 01ee 814C     		li	s9,0
 844              	.LVL92:
 845              	.L79:
 846              	.LBE102:
 847              	.LBB103:
 848              	.LBB99:
 104:P3GEMM.c      **** 		}
 849              		.loc 1 104 10 is_stmt 1
 104:P3GEMM.c      **** 		}
 850              		.loc 1 104 28 is_stmt 0
 851 01f0 97000000 		call	random@plt
 851      E7800000 
 852              	.LVL93:
 104:P3GEMM.c      **** 		}
 853              		.loc 1 104 20 discriminator 1
 854 01f8 D37725D0 		fcvt.s.l	fa5,a0
 104:P3GEMM.c      **** 		}
 855              		.loc 1 104 18 discriminator 1
 856 01fc 03B70D00 		ld	a4,0(s11)
 857 0200 93962C00 		slli	a3,s9,2
 104:P3GEMM.c      **** 		}
 858              		.loc 1 104 37 discriminator 1
 859 0204 D3F78710 		fmul.s	fa5,fa5,fs0
 104:P3GEMM.c      **** 		}
 860              		.loc 1 104 18 discriminator 1
 861 0208 3697     		add	a4,a4,a3
 103:P3GEMM.c      ****         	b[i][j] = (float) random() / (float) ((1 << 30) - 1);
 862              		.loc 1 103 17 discriminator 1
 863 020a 850C     		addi	s9,s9,1
 864              	.LVL94:
 104:P3GEMM.c      **** 		}
 865              		.loc 1 104 18 discriminator 1
 866 020c 2720F700 		fsw	fa5,0(a4)
 103:P3GEMM.c      ****         	b[i][j] = (float) random() / (float) ((1 << 30) - 1);
 867              		.loc 1 103 22 is_stmt 1 discriminator 3
 868              	.LVL95:
 103:P3GEMM.c      ****         	b[i][j] = (float) random() / (float) ((1 << 30) - 1);
 869              		.loc 1 103 17 discriminator 1
 870 0210 E3909CFE 		bne	s9,s1,.L79
 871              	.LBE99:
 102:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 872              		.loc 1 102 23 discriminator 2
 873              	.LVL96:
 102:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 874              		.loc 1 102 17 discriminator 1
 875 0214 050B     		addi	s6,s6,1
 876              	.LVL97:
 877 0216 A10D     		addi	s11,s11,8
 878 0218 E31B8BFC 		bne	s6,s0,.L78
 879 021c AA6C     		ld	s9,136(sp)
 880              		.cfi_restore 25
 881              	.LVL98:
 882              	.L80:
 883              	.LBE103:
 884              	.LBB104:
  97:P3GEMM.c      **** 		for(int j=0; j<p; j++) {
 885              		.loc 1 97 20 is_stmt 0 discriminator 1
 886 021e EA8D     		mv	s11,s10
 887 0220 014B     		li	s6,0
 888              	.L81:
 889              	.LVL99:
 890              	.LBE104:
 891              	.LBB105:
 892              	.LBB106:
 108:P3GEMM.c      ****         	c[i][j] = 0.0f;
 893              		.loc 1 108 17 is_stmt 1 discriminator 1
 109:P3GEMM.c      **** 		}
 894              		.loc 1 109 18 is_stmt 0
 895 0222 03B50D00 		ld	a0,0(s11)
 896 0226 5E86     		mv	a2,s7
 897 0228 8145     		li	a1,0
 898              	.LBE106:
 107:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 899              		.loc 1 107 17 discriminator 1
 900 022a 050B     		addi	s6,s6,1
 901              	.LVL100:
 902              	.LBB107:
 109:P3GEMM.c      **** 		}
 903              		.loc 1 109 18
 904 022c 97000000 		call	memset@plt
 904      E7800000 
 905              	.LVL101:
 906              	.LBE107:
 107:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 907              		.loc 1 107 23 is_stmt 1 discriminator 2
 107:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 908              		.loc 1 107 17 discriminator 1
 909 0234 A10D     		addi	s11,s11,8
 910 0236 E3662BFF 		bltu	s6,s2,.L81
 911              	.L77:
 912              	.LBE105:
 112:P3GEMM.c      **** 	printf("Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 913              		.loc 1 112 2
 914 023a 130B8104 		addi	s6,sp,72
 915 023e 5A85     		mv	a0,s6
 916 0240 8145     		li	a1,0
 917 0242 97000000 		call	gettimeofday@plt
 917      E7800000 
 918              	.LVL102:
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 919              		.loc 1 113 2
 920              	.LBB108:
 921              	.LBB109:
 922              		.loc 2 118 3
 923              	.LBE109:
 924              	.LBE108:
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 925              		.loc 1 113 86 is_stmt 0
 926 024a 8666     		ld	a3,64(sp)
 927 024c 4667     		ld	a4,80(sp)
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 928              		.loc 1 113 99
 929 024e 97070000 		fld	fs0,.LC10,a5
 929      07B40700 
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 930              		.loc 1 113 59
 931 0256 A667     		ld	a5,72(sp)
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 932              		.loc 1 113 86
 933 0258 158F     		sub	a4,a4,a3
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 934              		.loc 1 113 99
 935 025a D37727D2 		fcvt.d.l	fa5,a4
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 936              		.loc 1 113 59
 937 025e 6277     		ld	a4,56(sp)
 938              	.LBB113:
 939              	.LBB110:
 940              		.loc 2 118 10
 941 0260 97050000 		lla	a1,.LC11
 941      93850500 
 942              	.LBE110:
 943              	.LBE113:
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 944              		.loc 1 113 99
 945 0268 D3F7871A 		fdiv.d	fa5,fa5,fs0
 946              	.LBB114:
 947              	.LBB111:
 948              		.loc 2 118 10
 949 026c 0945     		li	a0,2
 950              	.LBE111:
 951              	.LBE114:
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 952              		.loc 1 113 59
 953 026e 998F     		sub	a5,a5,a4
 113:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de inicialización: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv
 954              		.loc 1 113 2
 955 0270 53F727D2 		fcvt.d.l	fa4,a5
 956              	.LBB115:
 957              	.LBB112:
 958              		.loc 2 118 10
 959 0274 D3F7E702 		fadd.d	fa5,fa5,fa4
 960 0278 538607E2 		fmv.x.d	a2,fa5
 961 027c 97000000 		call	__printf_chk@plt
 961      E7800000 
 962              	.LVL103:
 963              	.LBE112:
 964              	.LBE115:
 114:P3GEMM.c      **** 	
 965              		.loc 1 114 2 is_stmt 1
 966              	.LBB116:
 967              	.LBB117:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 968              		.loc 2 111 3
 969              	.LBE117:
 970              	.LBE116:
 114:P3GEMM.c      **** 	
 971              		.loc 1 114 93 is_stmt 0
 972 0284 0666     		ld	a2,64(sp)
 973 0286 4667     		ld	a4,80(sp)
 114:P3GEMM.c      **** 	
 974              		.loc 1 114 66
 975 0288 E276     		ld	a3,56(sp)
 976 028a A667     		ld	a5,72(sp)
 114:P3GEMM.c      **** 	
 977              		.loc 1 114 93
 978 028c 118F     		sub	a4,a4,a2
 114:P3GEMM.c      **** 	
 979              		.loc 1 114 106
 980 028e D37727D2 		fcvt.d.l	fa5,a4
 114:P3GEMM.c      **** 	
 981              		.loc 1 114 66
 982 0292 958F     		sub	a5,a5,a3
 114:P3GEMM.c      **** 	
 983              		.loc 1 114 2
 984 0294 53F727D2 		fcvt.d.l	fa4,a5
 114:P3GEMM.c      **** 	
 985              		.loc 1 114 106
 986 0298 D3F7871A 		fdiv.d	fa5,fa5,fs0
 987              	.LBB119:
 988              	.LBB118:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 989              		.loc 2 111 10
 990 029c 17060000 		lla	a2,.LC11
 990      13060600 
 991 02a4 8945     		li	a1,2
 992 02a6 4E85     		mv	a0,s3
 993 02a8 D3F7E702 		fadd.d	fa5,fa5,fa4
 994 02ac D38607E2 		fmv.x.d	a3,fa5
 995 02b0 97000000 		call	__fprintf_chk@plt
 995      E7800000 
 996              	.LVL104:
 997              	.LBE118:
 998              	.LBE119:
 120:P3GEMM.c      **** 
 999              		.loc 1 120 2 is_stmt 1
 1000 02b8 6265     		ld	a0,24(sp)
 1001 02ba 8145     		li	a1,0
 1002 02bc 97000000 		call	gettimeofday@plt
 1002      E7800000 
 1003              	.LVL105:
 122:P3GEMM.c      **** 
 1004              		.loc 1 122 5
 1005 02c4 A266     		ld	a3,8(sp)
 1006 02c6 EA87     		mv	a5,s10
 1007 02c8 6287     		mv	a4,s8
 1008 02ca 2686     		mv	a2,s1
 1009 02cc A285     		mv	a1,s0
 1010 02ce 4A85     		mv	a0,s2
 1011 02d0 97000000 		call	GEMM
 1011      E7800000 
 1012              	.LVL106:
 124:P3GEMM.c      **** 	/*******************************************/
 1013              		.loc 1 124 2
 1014 02d8 5A85     		mv	a0,s6
 1015 02da 8145     		li	a1,0
 1016 02dc 97000000 		call	gettimeofday@plt
 1016      E7800000 
 1017              	.LVL107:
 128:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 1018              		.loc 1 128 2
 1019              	.LBB120:
 1020              	.LBB121:
 1021              		.loc 2 118 3
 1022              	.LBE121:
 1023              	.LBE120:
 128:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 1024              		.loc 1 128 79 is_stmt 0
 1025 02e4 0666     		ld	a2,64(sp)
 1026 02e6 4667     		ld	a4,80(sp)
 128:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 1027              		.loc 1 128 52
 1028 02e8 E276     		ld	a3,56(sp)
 1029 02ea A667     		ld	a5,72(sp)
 128:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 1030              		.loc 1 128 79
 1031 02ec 118F     		sub	a4,a4,a2
 128:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 1032              		.loc 1 128 92
 1033 02ee D37727D2 		fcvt.d.l	fa5,a4
 128:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 1034              		.loc 1 128 52
 1035 02f2 958F     		sub	a5,a5,a3
 128:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 1036              		.loc 1 128 2
 1037 02f4 53F727D2 		fcvt.d.l	fa4,a5
 128:P3GEMM.c      **** 	fprintf(rfile,"Tiempo de cómputo: %.9f s\n", (tf.tv_sec - ti.tv_sec) + (tf.tv_usec - ti.tv_usec)/
 1038              		.loc 1 128 92
 1039 02f8 D3F7871A 		fdiv.d	fa5,fa5,fs0
 1040              	.LBB124:
 1041              	.LBB122:
 1042              		.loc 2 118 10
 1043 02fc 97050000 		lla	a1,.LC12
 1043      93850500 
 1044 0304 0945     		li	a0,2
 1045              	.LBE122:
 1046              	.LBE124:
 1047              	.LBB125:
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1048              		.loc 1 133 31 discriminator 1
 1049 0306 228B     		mv	s6,s0
 1050              	.LBE125:
 1051              	.LBB136:
 1052              	.LBB123:
 1053              		.loc 2 118 10
 1054 0308 D3F7E702 		fadd.d	fa5,fa5,fa4
 1055 030c 538607E2 		fmv.x.d	a2,fa5
 1056 0310 97000000 		call	__printf_chk@plt
 1056      E7800000 
 1057              	.LVL108:
 1058              	.LBE123:
 1059              	.LBE136:
 129:P3GEMM.c      **** 
 1060              		.loc 1 129 2 is_stmt 1
 1061              	.LBB137:
 1062              	.LBB138:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1063              		.loc 2 111 3
 1064              	.LBE138:
 1065              	.LBE137:
 129:P3GEMM.c      **** 
 1066              		.loc 1 129 86 is_stmt 0
 1067 0318 0666     		ld	a2,64(sp)
 1068 031a 4667     		ld	a4,80(sp)
 129:P3GEMM.c      **** 
 1069              		.loc 1 129 59
 1070 031c E276     		ld	a3,56(sp)
 1071 031e A667     		ld	a5,72(sp)
 129:P3GEMM.c      **** 
 1072              		.loc 1 129 86
 1073 0320 118F     		sub	a4,a4,a2
 129:P3GEMM.c      **** 
 1074              		.loc 1 129 99
 1075 0322 D37727D2 		fcvt.d.l	fa5,a4
 129:P3GEMM.c      **** 
 1076              		.loc 1 129 59
 1077 0326 958F     		sub	a5,a5,a3
 129:P3GEMM.c      **** 
 1078              		.loc 1 129 2
 1079 0328 53F727D2 		fcvt.d.l	fa4,a5
 129:P3GEMM.c      **** 
 1080              		.loc 1 129 99
 1081 032c D3F7871A 		fdiv.d	fa5,fa5,fs0
 1082              	.LBB140:
 1083              	.LBB139:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1084              		.loc 2 111 10
 1085 0330 17060000 		lla	a2,.LC12
 1085      13060600 
 1086 0338 8945     		li	a1,2
 1087 033a 4E85     		mv	a0,s3
 1088 033c D3F7E702 		fadd.d	fa5,fa5,fa4
 1089 0340 D38607E2 		fmv.x.d	a3,fa5
 1090 0344 97000000 		call	__fprintf_chk@plt
 1090      E7800000 
 1091              	.LVL109:
 1092              	.LBE139:
 1093              	.LBE140:
 132:P3GEMM.c      ****     for(int i=0; i< ((p>10)?10:p); i++) {
 1094              		.loc 1 132 2 is_stmt 1
 1095              	.LBB141:
 1096              	.LBB142:
 1097              		.loc 2 118 3
 1098              		.loc 2 118 10 is_stmt 0
 1099 034c 97050000 		lla	a1,.LC13
 1099      93850500 
 1100 0354 0945     		li	a0,2
 1101 0356 97000000 		call	__printf_chk@plt
 1101      E7800000 
 1102              	.LVL110:
 1103              	.LBE142:
 1104              	.LBE141:
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1105              		.loc 1 133 5 is_stmt 1
 1106              	.LBB143:
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1107              		.loc 1 133 9
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1108              		.loc 1 133 19 discriminator 1
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1109              		.loc 1 133 31 is_stmt 0 discriminator 1
 1110 035e A947     		li	a5,10
 1111 0360 63E78722 		bgtu	s0,a5,.L149
 1112              	.L82:
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1113              		.loc 1 133 19 discriminator 1
 1114 0364 21C8     		beq	s0,zero,.L88
 1115 0366 A267     		ld	a5,8(sp)
 1116              	.LBE143:
 1117              	.LBB144:
 159:P3GEMM.c      **** 	free(a);
 1118              		.loc 1 159 3
 1119 0368 814D     		li	s11,0
 1120 036a 83BB0700 		ld	s7,0(a5)
 1121              	.LVL111:
 1122              	.L87:
 1123              	.LBE144:
 1124              	.LBB145:
 134:P3GEMM.c      ****         fprintf(rfile,"%.4f ",a[0][i]);
 1125              		.loc 1 134 9 is_stmt 1
 1126              	.LBB126:
 1127              	.LBB127:
 1128              		.loc 2 118 3
 1129              	.LBE127:
 1130              	.LBE126:
 134:P3GEMM.c      ****         fprintf(rfile,"%.4f ",a[0][i]);
 1131              		.loc 1 134 9 is_stmt 0
 1132 036e 87A70B00 		flw	fa5,0(s7)
 1133              	.LBB130:
 1134              	.LBB128:
 1135              		.loc 2 118 10
 1136 0372 97050000 		lla	a1,.LC15
 1136      93850500 
 1137 037a 0945     		li	a0,2
 1138 037c D3870742 		fcvt.d.s	fa5,fa5
 1139              	.LBE128:
 1140              	.LBE130:
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1141              		.loc 1 133 19 discriminator 1
 1142 0380 850D     		addi	s11,s11,1
 1143              	.LVL112:
 1144 0382 910B     		addi	s7,s7,4
 1145              	.LBB131:
 1146              	.LBB129:
 1147              		.loc 2 118 10
 1148 0384 538607E2 		fmv.x.d	a2,fa5
 1149 0388 97000000 		call	__printf_chk@plt
 1149      E7800000 
 1150              	.LVL113:
 1151              	.LBE129:
 1152              	.LBE131:
 135:P3GEMM.c      ****     }
 1153              		.loc 1 135 9 is_stmt 1
 1154              	.LBB132:
 1155              	.LBB133:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1156              		.loc 2 111 3
 1157              	.LBE133:
 1158              	.LBE132:
 135:P3GEMM.c      ****     }
 1159              		.loc 1 135 9 is_stmt 0
 1160 0390 87A7CBFF 		flw	fa5,-4(s7)
 1161              	.LBB135:
 1162              	.LBB134:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1163              		.loc 2 111 10
 1164 0394 4E85     		mv	a0,s3
 1165 0396 17060000 		lla	a2,.LC15
 1165      13060600 
 1166 039e D3870742 		fcvt.d.s	fa5,fa5
 1167 03a2 8945     		li	a1,2
 1168 03a4 D38607E2 		fmv.x.d	a3,fa5
 1169 03a8 97000000 		call	__fprintf_chk@plt
 1169      E7800000 
 1170              	.LVL114:
 1171              	.LBE134:
 1172              	.LBE135:
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1173              		.loc 1 133 37 is_stmt 1 discriminator 3
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1174              		.loc 1 133 19 discriminator 1
 1175 03b0 E3EF6DFB 		bltu	s11,s6,.L87
 1176              	.L88:
 1177              	.LBE145:
 137:P3GEMM.c      ****     fprintf(rfile,"\n");
 1178              		.loc 1 137 5
 1179              	.LVL115:
 1180              	.LBB146:
 1181              	.LBB147:
 1182              		.loc 2 118 3
 1183              		.loc 2 118 10 is_stmt 0
 1184 03b4 2945     		li	a0,10
 1185 03b6 97000000 		call	putchar@plt
 1185      E7800000 
 1186              	.LVL116:
 1187              	.LBE147:
 1188              	.LBE146:
 138:P3GEMM.c      **** 
 1189              		.loc 1 138 5 is_stmt 1
 1190              	.LBB148:
 1191              	.LBB149:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1192              		.loc 2 111 3
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1193              		.loc 2 111 10 is_stmt 0
 1194 03be CE85     		mv	a1,s3
 1195 03c0 2945     		li	a0,10
 1196 03c2 97000000 		call	fputc@plt
 1196      E7800000 
 1197              	.LVL117:
 1198              	.LBE149:
 1199              	.LBE148:
 140:P3GEMM.c      ****     for(int i=0; i< ((m>10)?10:m); i++) {
 1200              		.loc 1 140 5 is_stmt 1
 1201              	.LBB150:
 1202              	.LBB151:
 1203              		.loc 2 118 3
 1204              		.loc 2 118 10 is_stmt 0
 1205 03ca 97050000 		lla	a1,.LC14
 1205      93850500 
 1206 03d2 0945     		li	a0,2
 1207 03d4 97000000 		call	__printf_chk@plt
 1207      E7800000 
 1208              	.LVL118:
 1209              	.LBE151:
 1210              	.LBE150:
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1211              		.loc 1 141 5 is_stmt 1
 1212              	.LBB152:
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1213              		.loc 1 141 9
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1214              		.loc 1 141 19 discriminator 1
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1215              		.loc 1 141 31 is_stmt 0 discriminator 1
 1216 03dc A947     		li	a5,10
 1217 03de 268B     		mv	s6,s1
 1218 03e0 63EF9716 		bgtu	s1,a5,.L150
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1219              		.loc 1 141 19 discriminator 1
 1220 03e4 63800418 		beq	s1,zero,.L151
 1221              	.L85:
 1222 03e8 83340C00 		ld	s1,0(s8)
 1223              	.LVL119:
 1224              	.LBE152:
 1225              	.LBB163:
 162:P3GEMM.c      **** 	free(b);
 1226              		.loc 1 162 3
 1227 03ec 814B     		li	s7,0
 1228              	.LVL120:
 1229              	.L89:
 1230              	.LBE163:
 1231              	.LBB164:
 142:P3GEMM.c      ****         fprintf(rfile,"%.4f ",b[0][i]);
 1232              		.loc 1 142 9 is_stmt 1
 1233              	.LBB153:
 1234              	.LBB154:
 1235              		.loc 2 118 3
 1236              	.LBE154:
 1237              	.LBE153:
 142:P3GEMM.c      ****         fprintf(rfile,"%.4f ",b[0][i]);
 1238              		.loc 1 142 9 is_stmt 0
 1239 03ee 87A70400 		flw	fa5,0(s1)
 1240              	.LBB157:
 1241              	.LBB155:
 1242              		.loc 2 118 10
 1243 03f2 97050000 		lla	a1,.LC15
 1243      93850500 
 1244 03fa 0945     		li	a0,2
 1245 03fc D3870742 		fcvt.d.s	fa5,fa5
 1246              	.LBE155:
 1247              	.LBE157:
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1248              		.loc 1 141 19 discriminator 1
 1249 0400 850B     		addi	s7,s7,1
 1250              	.LVL121:
 1251 0402 9104     		addi	s1,s1,4
 1252              	.LBB158:
 1253              	.LBB156:
 1254              		.loc 2 118 10
 1255 0404 538607E2 		fmv.x.d	a2,fa5
 1256 0408 97000000 		call	__printf_chk@plt
 1256      E7800000 
 1257              	.LVL122:
 1258              	.LBE156:
 1259              	.LBE158:
 143:P3GEMM.c      ****     }
 1260              		.loc 1 143 9 is_stmt 1
 1261              	.LBB159:
 1262              	.LBB160:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1263              		.loc 2 111 3
 1264              	.LBE160:
 1265              	.LBE159:
 143:P3GEMM.c      ****     }
 1266              		.loc 1 143 9 is_stmt 0
 1267 0410 87A7C4FF 		flw	fa5,-4(s1)
 1268              	.LBB162:
 1269              	.LBB161:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1270              		.loc 2 111 10
 1271 0414 4E85     		mv	a0,s3
 1272 0416 17060000 		lla	a2,.LC15
 1272      13060600 
 1273 041e D3870742 		fcvt.d.s	fa5,fa5
 1274 0422 8945     		li	a1,2
 1275 0424 D38607E2 		fmv.x.d	a3,fa5
 1276 0428 97000000 		call	__fprintf_chk@plt
 1276      E7800000 
 1277              	.LVL123:
 1278              	.LBE161:
 1279              	.LBE162:
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1280              		.loc 1 141 37 is_stmt 1 discriminator 3
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1281              		.loc 1 141 19 discriminator 1
 1282 0430 E3EF6BFB 		bltu	s7,s6,.L89
 1283              	.LBE164:
 145:P3GEMM.c      ****     fprintf(rfile,"\n");
 1284              		.loc 1 145 2
 1285              	.LVL124:
 1286              	.LBB165:
 1287              	.LBB166:
 1288              		.loc 2 118 3
 1289              		.loc 2 118 10 is_stmt 0
 1290 0434 2945     		li	a0,10
 1291 0436 97000000 		call	putchar@plt
 1291      E7800000 
 1292              	.LVL125:
 1293              	.LBE166:
 1294              	.LBE165:
 146:P3GEMM.c      **** 
 1295              		.loc 1 146 5 is_stmt 1
 1296              	.LBB168:
 1297              	.LBB169:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1298              		.loc 2 111 3
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1299              		.loc 2 111 10 is_stmt 0
 1300 043e CE85     		mv	a1,s3
 1301 0440 2945     		li	a0,10
 1302 0442 97000000 		call	fputc@plt
 1302      E7800000 
 1303              	.LVL126:
 1304              	.LBE169:
 1305              	.LBE168:
 148:P3GEMM.c      ****     for(int i=0; i< ((m>10)?10:m); i++) {
 1306              		.loc 1 148 2 is_stmt 1
 1307              	.LBB171:
 1308              	.LBB172:
 1309              		.loc 2 118 3
 1310              		.loc 2 118 10 is_stmt 0
 1311 044a 97050000 		lla	a1,.LC16
 1311      93850500 
 1312 0452 0945     		li	a0,2
 1313 0454 97000000 		call	__printf_chk@plt
 1313      E7800000 
 1314              	.LVL127:
 1315              	.LBE172:
 1316              	.LBE171:
 149:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 1317              		.loc 1 149 5 is_stmt 1
 1318              	.LBB174:
 149:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 1319              		.loc 1 149 9
 149:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 1320              		.loc 1 149 19 discriminator 1
 1321 045c 83340D00 		ld	s1,0(s10)
 1322              	.LBE174:
 1323              	.LBB185:
 165:P3GEMM.c      **** 	free(c);
 1324              		.loc 1 165 3 is_stmt 0
 1325 0460 814B     		li	s7,0
 1326              	.LVL128:
 1327              	.L90:
 1328              	.LBE185:
 1329              	.LBB186:
 150:P3GEMM.c      ****         fprintf(rfile,"%.4f ",c[0][i]);
 1330              		.loc 1 150 9 is_stmt 1
 1331              	.LBB175:
 1332              	.LBB176:
 1333              		.loc 2 118 3
 1334              	.LBE176:
 1335              	.LBE175:
 150:P3GEMM.c      ****         fprintf(rfile,"%.4f ",c[0][i]);
 1336              		.loc 1 150 9 is_stmt 0
 1337 0462 87A70400 		flw	fa5,0(s1)
 1338              	.LBB179:
 1339              	.LBB177:
 1340              		.loc 2 118 10
 1341 0466 97050000 		lla	a1,.LC15
 1341      93850500 
 1342 046e 0945     		li	a0,2
 1343 0470 D3870742 		fcvt.d.s	fa5,fa5
 1344              	.LBE177:
 1345              	.LBE179:
 149:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 1346              		.loc 1 149 19 discriminator 1
 1347 0474 850B     		addi	s7,s7,1
 1348              	.LVL129:
 1349 0476 9104     		addi	s1,s1,4
 1350              	.LBB180:
 1351              	.LBB178:
 1352              		.loc 2 118 10
 1353 0478 538607E2 		fmv.x.d	a2,fa5
 1354 047c 97000000 		call	__printf_chk@plt
 1354      E7800000 
 1355              	.LVL130:
 1356              	.LBE178:
 1357              	.LBE180:
 151:P3GEMM.c      ****     }
 1358              		.loc 1 151 9 is_stmt 1
 1359              	.LBB181:
 1360              	.LBB182:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1361              		.loc 2 111 3
 1362              	.LBE182:
 1363              	.LBE181:
 151:P3GEMM.c      ****     }
 1364              		.loc 1 151 9 is_stmt 0
 1365 0484 87A7C4FF 		flw	fa5,-4(s1)
 1366              	.LBB184:
 1367              	.LBB183:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1368              		.loc 2 111 10
 1369 0488 4E85     		mv	a0,s3
 1370 048a 17060000 		lla	a2,.LC15
 1370      13060600 
 1371 0492 D3870742 		fcvt.d.s	fa5,fa5
 1372 0496 8945     		li	a1,2
 1373 0498 D38607E2 		fmv.x.d	a3,fa5
 1374 049c 97000000 		call	__fprintf_chk@plt
 1374      E7800000 
 1375              	.LVL131:
 1376              	.LBE183:
 1377              	.LBE184:
 149:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 1378              		.loc 1 149 37 is_stmt 1 discriminator 3
 149:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 1379              		.loc 1 149 19 discriminator 1
 1380 04a4 E3EF6BFB 		bgtu	s6,s7,.L90
 1381              	.L96:
 1382              	.LBE186:
 153:P3GEMM.c      ****     fprintf(rfile,"\n");
 1383              		.loc 1 153 2
 1384              	.LVL132:
 1385              	.LBB187:
 1386              	.LBB188:
 1387              		.loc 2 118 3
 1388              		.loc 2 118 10 is_stmt 0
 1389 04a8 2945     		li	a0,10
 1390 04aa 97000000 		call	putchar@plt
 1390      E7800000 
 1391              	.LVL133:
 1392              	.LBE188:
 1393              	.LBE187:
 154:P3GEMM.c      **** 
 1394              		.loc 1 154 5 is_stmt 1
 1395              	.LBB189:
 1396              	.LBB190:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1397              		.loc 2 111 3
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1398              		.loc 2 111 10 is_stmt 0
 1399 04b2 CE85     		mv	a1,s3
 1400 04b4 2945     		li	a0,10
 1401 04b6 97000000 		call	fputc@plt
 1401      E7800000 
 1402              	.LVL134:
 1403              	.LBE190:
 1404              	.LBE189:
 157:P3GEMM.c      **** 	for(size_t i=0;i<n;i++)
 1405              		.loc 1 157 2 is_stmt 1
 1406 04be 4E85     		mv	a0,s3
 1407 04c0 97000000 		call	fclose@plt
 1407      E7800000 
 1408              	.LVL135:
 158:P3GEMM.c      **** 		free(a[i]);
 1409              		.loc 1 158 2
 1410              	.LBB191:
 158:P3GEMM.c      **** 		free(a[i]);
 1411              		.loc 1 158 6
 158:P3GEMM.c      **** 		free(a[i]);
 1412              		.loc 1 158 18 discriminator 1
 158:P3GEMM.c      **** 		free(a[i]);
 1413              		.loc 1 158 13 is_stmt 0
 1414 04c8 8144     		li	s1,0
 1415              	.LVL136:
 1416              	.L91:
 159:P3GEMM.c      **** 	free(a);
 1417              		.loc 1 159 3 is_stmt 1
 1418 04ca 03350A00 		ld	a0,0(s4)
 158:P3GEMM.c      **** 		free(a[i]);
 1419              		.loc 1 158 22 is_stmt 0 discriminator 3
 1420 04ce 8504     		addi	s1,s1,1
 1421              	.LVL137:
 158:P3GEMM.c      **** 		free(a[i]);
 1422              		.loc 1 158 18 discriminator 1
 1423 04d0 210A     		addi	s4,s4,8
 159:P3GEMM.c      **** 	free(a);
 1424              		.loc 1 159 3
 1425 04d2 97000000 		call	free@plt
 1425      E7800000 
 1426              	.LVL138:
 158:P3GEMM.c      **** 		free(a[i]);
 1427              		.loc 1 158 22 is_stmt 1 discriminator 3
 158:P3GEMM.c      **** 		free(a[i]);
 1428              		.loc 1 158 18 discriminator 1
 1429 04da E3E824FF 		bltu	s1,s2,.L91
 1430              	.LBE191:
 160:P3GEMM.c      **** 	for(size_t i=0;i<p;i++)
 1431              		.loc 1 160 2
 1432 04de 2265     		ld	a0,8(sp)
 1433 04e0 E284     		mv	s1,s8
 1434              	.LVL139:
 1435 04e2 97000000 		call	free@plt
 1435      E7800000 
 1436              	.LVL140:
 161:P3GEMM.c      **** 		free(b[i]);
 1437              		.loc 1 161 2
 1438              	.LBB192:
 161:P3GEMM.c      **** 		free(b[i]);
 1439              		.loc 1 161 6
 161:P3GEMM.c      **** 		free(b[i]);
 1440              		.loc 1 161 18 discriminator 1
 1441 04ea C267     		ld	a5,16(sp)
 1442 04ec B3898701 		add	s3,a5,s8
 1443              	.LVL141:
 1444 04f0 09C8     		beq	s0,zero,.L95
 1445              	.LVL142:
 1446              	.L94:
 162:P3GEMM.c      **** 	free(b);
 1447              		.loc 1 162 3
 1448 04f2 8860     		ld	a0,0(s1)
 161:P3GEMM.c      **** 		free(b[i]);
 1449              		.loc 1 161 18 is_stmt 0 discriminator 1
 1450 04f4 A104     		addi	s1,s1,8
 162:P3GEMM.c      **** 	free(b);
 1451              		.loc 1 162 3
 1452 04f6 97000000 		call	free@plt
 1452      E7800000 
 1453              	.LVL143:
 161:P3GEMM.c      **** 		free(b[i]);
 1454              		.loc 1 161 22 is_stmt 1 discriminator 3
 161:P3GEMM.c      **** 		free(b[i]);
 1455              		.loc 1 161 18 discriminator 1
 1456 04fe E39A34FF 		bne	s1,s3,.L94
 1457              	.L95:
 1458              	.LBE192:
 163:P3GEMM.c      **** 	for(size_t i=0;i<n;i++)
 1459              		.loc 1 163 2
 1460 0502 6285     		mv	a0,s8
 1461 0504 97000000 		call	free@plt
 1461      E7800000 
 1462              	.LVL144:
 164:P3GEMM.c      **** 		free(c[i]);
 1463              		.loc 1 164 2
 1464              	.LBB193:
 164:P3GEMM.c      **** 		free(c[i]);
 1465              		.loc 1 164 6
 164:P3GEMM.c      **** 		free(c[i]);
 1466              		.loc 1 164 18 discriminator 1
 164:P3GEMM.c      **** 		free(c[i]);
 1467              		.loc 1 164 13 is_stmt 0
 1468 050c 0144     		li	s0,0
 1469              	.LVL145:
 1470              	.L93:
 165:P3GEMM.c      **** 	free(c);
 1471              		.loc 1 165 3 is_stmt 1
 1472 050e 03B50A00 		ld	a0,0(s5)
 164:P3GEMM.c      **** 		free(c[i]);
 1473              		.loc 1 164 22 is_stmt 0 discriminator 3
 1474 0512 0504     		addi	s0,s0,1
 1475              	.LVL146:
 164:P3GEMM.c      **** 		free(c[i]);
 1476              		.loc 1 164 18 discriminator 1
 1477 0514 A10A     		addi	s5,s5,8
 165:P3GEMM.c      **** 	free(c);
 1478              		.loc 1 165 3
 1479 0516 97000000 		call	free@plt
 1479      E7800000 
 1480              	.LVL147:
 164:P3GEMM.c      **** 		free(c[i]);
 1481              		.loc 1 164 22 is_stmt 1 discriminator 3
 164:P3GEMM.c      **** 		free(c[i]);
 1482              		.loc 1 164 18 discriminator 1
 1483 051e E36824FF 		bltu	s0,s2,.L93
 1484              	.LBE193:
 166:P3GEMM.c      **** 
 1485              		.loc 1 166 2
 1486 0522 6A85     		mv	a0,s10
 1487 0524 97000000 		call	free@plt
 1487      E7800000 
 1488              	.LVL148:
 168:P3GEMM.c      **** }
 1489              		.loc 1 168 2
 169:P3GEMM.c      **** 
 1490              		.loc 1 169 1 is_stmt 0
 1491 052c 97070000 		la	a5,__stack_chk_guard
 1491      83B70700 
 1492 0534 6667     		ld	a4, 88(sp)
 1493 0536 9C63     		ld	a5, 0(a5)
 1494 0538 B98F     		xor	a5, a4, a5
 1495 053a 0147     		li	a4, 0
 1496 053c ADEB     		bne	a5,zero,.L152
 1497 053e 4E64     		ld	s0,208(sp)
 1498              		.cfi_remember_state
 1499              		.cfi_restore 8
 1500              	.LVL149:
 1501 0540 EE60     		ld	ra,216(sp)
 1502              		.cfi_restore 1
 1503 0542 AE64     		ld	s1,200(sp)
 1504              		.cfi_restore 9
 1505 0544 EA79     		ld	s3,184(sp)
 1506              		.cfi_restore 19
 1507 0546 4A7A     		ld	s4,176(sp)
 1508              		.cfi_restore 20
 1509 0548 AA7A     		ld	s5,168(sp)
 1510              		.cfi_restore 21
 1511 054a 0A7B     		ld	s6,160(sp)
 1512              		.cfi_restore 22
 1513 054c EA6B     		ld	s7,152(sp)
 1514              		.cfi_restore 23
 1515 054e 4A6C     		ld	s8,144(sp)
 1516              		.cfi_restore 24
 1517              	.LVL150:
 1518 0550 0A6D     		ld	s10,128(sp)
 1519              		.cfi_restore 26
 1520              	.LVL151:
 1521 0552 E67D     		ld	s11,120(sp)
 1522              		.cfi_restore 27
 1523 0554 2634     		fld	fs0,104(sp)
 1524              		.cfi_restore 40
 1525 0556 0E69     		ld	s2,192(sp)
 1526              		.cfi_restore 18
 1527              	.LVL152:
 1528 0558 0145     		li	a0,0
 1529 055a 2D61     		addi	sp,sp,224
 1530              		.cfi_def_cfa_offset 0
 1531              	.LVL153:
 1532 055c 8280     		jr	ra
 1533              	.LVL154:
 1534              	.L150:
 1535              		.cfi_restore_state
 1536              	.LBB194:
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1537              		.loc 1 141 31 discriminator 1
 1538 055e 3E8B     		mv	s6,a5
 141:P3GEMM.c      ****         printf("%.4f ",b[0][i]);
 1539              		.loc 1 141 19 discriminator 1
 1540 0560 E39404E8 		bne	s1,zero,.L85
 1541              	.L151:
 1542              	.LBE194:
 145:P3GEMM.c      ****     fprintf(rfile,"\n");
 1543              		.loc 1 145 2 is_stmt 1
 1544              	.LVL155:
 1545              	.LBB195:
 1546              	.LBB167:
 1547              		.loc 2 118 3
 1548              		.loc 2 118 10 is_stmt 0
 1549 0564 2945     		li	a0,10
 1550 0566 97000000 		call	putchar@plt
 1550      E7800000 
 1551              	.LVL156:
 1552              	.LBE167:
 1553              	.LBE195:
 146:P3GEMM.c      **** 
 1554              		.loc 1 146 5 is_stmt 1
 1555              	.LBB196:
 1556              	.LBB170:
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1557              		.loc 2 111 3
 111:/usr/include/riscv64-linux-gnu/bits/stdio2.h **** 			__va_arg_pack ());
 1558              		.loc 2 111 10 is_stmt 0
 1559 056e CE85     		mv	a1,s3
 1560 0570 2945     		li	a0,10
 1561 0572 97000000 		call	fputc@plt
 1561      E7800000 
 1562              	.LVL157:
 1563              	.LBE170:
 1564              	.LBE196:
 148:P3GEMM.c      ****     for(int i=0; i< ((m>10)?10:m); i++) {
 1565              		.loc 1 148 2 is_stmt 1
 1566              	.LBB197:
 1567              	.LBB173:
 1568              		.loc 2 118 3
 1569              		.loc 2 118 10 is_stmt 0
 1570 057a 97050000 		lla	a1,.LC16
 1570      93850500 
 1571 0582 0945     		li	a0,2
 1572 0584 97000000 		call	__printf_chk@plt
 1572      E7800000 
 1573              	.LVL158:
 1574              	.LBE173:
 1575              	.LBE197:
 149:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 1576              		.loc 1 149 5 is_stmt 1
 1577              	.LBB198:
 149:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 1578              		.loc 1 149 9
 149:P3GEMM.c      ****         printf("%.4f ",c[0][i]);
 1579              		.loc 1 149 19 discriminator 1
 1580 058c 31BF     		j	.L96
 1581              	.LVL159:
 1582              	.L149:
 1583              	.LBE198:
 1584              	.LBB199:
 133:P3GEMM.c      ****         printf("%.4f ",a[0][i]);
 1585              		.loc 1 133 31 is_stmt 0 discriminator 1
 1586 058e 3E8B     		mv	s6,a5
 1587 0590 D1BB     		j	.L82
 1588              	.LVL160:
 1589              	.L145:
 1590              		.cfi_restore 19
 1591              		.cfi_restore 20
 1592              		.cfi_restore 21
 1593              		.cfi_restore 22
 1594              		.cfi_restore 24
 1595              		.cfi_restore 26
 1596              		.cfi_restore 27
 1597              		.cfi_restore 40
 1598              	.LBE199:
  47:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 1599              		.loc 1 47 19 discriminator 1
 1600 0592 03C71600 		lbu	a4,1(a3)
 1601 0596 39B6     		j	.L59
 1602              	.LVL161:
 1603              	.L144:
 1604              		.cfi_restore 9
  42:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 1605              		.loc 1 42 19 discriminator 1
 1606 0598 03C71600 		lbu	a4,1(a3)
 1607 059c E9BC     		j	.L58
 1608              	.LVL162:
 1609              	.L143:
 1610              		.cfi_restore 8
  37:P3GEMM.c      ****         printf("El argumento debe ser mayor que 0\n");
 1611              		.loc 1 37 19 discriminator 1
 1612 059e 03C71600 		lbu	a4,1(a3)
 1613 05a2 5DB4     		j	.L56
 1614              	.LVL163:
 1615              	.L148:
 1616              		.cfi_offset 8, -16
 1617              		.cfi_offset 9, -24
 1618              		.cfi_offset 19, -40
 1619              		.cfi_offset 20, -48
 1620              		.cfi_offset 21, -56
 1621              		.cfi_offset 22, -64
 1622              		.cfi_offset 24, -80
 1623              		.cfi_offset 26, -96
 1624              		.cfi_offset 27, -104
 1625              		.cfi_offset 40, -120
 1626              	.LBB200:
 102:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 1627              		.loc 1 102 17 is_stmt 1 discriminator 1
 1628              	.LBE200:
 1629              	.LBB201:
 107:P3GEMM.c      **** 		for(int j=0; j<m; j++) {
 1630              		.loc 1 107 17 discriminator 1
 1631 05a4 E39D04C6 		bne	s1,zero,.L80
 1632 05a8 49B9     		j	.L77
 1633              	.LVL164:
 1634              	.L136:
 1635              		.cfi_offset 25, -88
 1636 05aa AA6C     		ld	s9,136(sp)
 1637              		.cfi_restore 25
 1638 05ac 79B1     		j	.L77
 1639              	.LVL165:
 1640              	.L152:
 1641 05ae 66E5     		sd	s9,136(sp)
 1642              		.cfi_offset 25, -88
 1643              	.LBE201:
 169:P3GEMM.c      **** 
 1644              		.loc 1 169 1 is_stmt 0
 1645 05b0 97000000 		call	__stack_chk_fail@plt
 1645      E7800000 
 1646              	.LVL166:
 1647              	.L134:
 1648              		.cfi_restore 8
 1649              		.cfi_restore 9
 1650              		.cfi_restore 19
 1651              		.cfi_restore 20
 1652              		.cfi_restore 21
 1653              		.cfi_restore 22
 1654              		.cfi_restore 24
 1655              		.cfi_restore 25
 1656              		.cfi_restore 26
 1657              		.cfi_restore 27
 1658              		.cfi_restore 40
 1659 05b8 A2E9     		sd	s0,208(sp)
 1660 05ba A6E5     		sd	s1,200(sp)
 1661              		.cfi_offset 8, -16
 1662              		.cfi_offset 9, -24
 1663              	.L55:
 1664              	.LBB202:
 1665              	.LBB203:
 1666              		.loc 2 118 10
 1667 05bc 17050000 		lla	a0,.LC8
 1667      13050500 
 1668 05c4 4EFD     		sd	s3,184(sp)
 1669 05c6 52F9     		sd	s4,176(sp)
 1670 05c8 56F5     		sd	s5,168(sp)
 1671 05ca 5AF1     		sd	s6,160(sp)
 1672 05cc 62E9     		sd	s8,144(sp)
 1673 05ce 66E5     		sd	s9,136(sp)
 1674 05d0 6AE1     		sd	s10,128(sp)
 1675 05d2 EEFC     		sd	s11,120(sp)
 1676 05d4 A2B4     		fsd	fs0,104(sp)
 1677              	.LBE203:
 1678              	.LBE202:
  38:P3GEMM.c      ****         exit(EXIT_FAILURE);
 1679              		.loc 1 38 9 is_stmt 1
 1680              	.LVL167:
 1681              	.LBB205:
 1682              	.LBB204:
 1683              		.loc 2 118 3
 1684              		.cfi_offset 19, -40
 1685              		.cfi_offset 20, -48
 1686              		.cfi_offset 21, -56
 1687              		.cfi_offset 22, -64
 1688              		.cfi_offset 24, -80
 1689              		.cfi_offset 25, -88
 1690              		.cfi_offset 26, -96
 1691              		.cfi_offset 27, -104
 1692              		.cfi_offset 40, -120
 1693              		.loc 2 118 10 is_stmt 0
 1694 05d6 97000000 		call	puts@plt
 1694      E7800000 
 1695              	.LVL168:
 1696              	.LBE204:
 1697              	.LBE205:
  39:P3GEMM.c      ****     }
 1698              		.loc 1 39 9 is_stmt 1
 1699 05de 0545     		li	a0,1
 1700 05e0 97000000 		call	exit@plt
 1700      E7800000 
 1701              	.LVL169:
 1702              	.L142:
 1703              		.cfi_restore 8
 1704              		.cfi_restore 9
 1705              		.cfi_restore 19
 1706              		.cfi_restore 20
 1707              		.cfi_restore 21
 1708              		.cfi_restore 22
 1709              		.cfi_restore 23
 1710              		.cfi_restore 24
 1711              		.cfi_restore 25
 1712              		.cfi_restore 26
 1713              		.cfi_restore 27
 1714              		.cfi_restore 40
  31:P3GEMM.c      **** 			   "    GEMM. General Matrix Multiply. Multiplicación de matrices aleatorias.\n"
 1715              		.loc 1 31 3
 1716              	.LBB206:
 1717              	.LBB207:
 1718              		.loc 2 118 3
 1719              		.loc 2 118 10 is_stmt 0
 1720 05e8 9061     		ld	a2,0(a1)
 1721 05ea 0945     		li	a0,2
 1722              	.LVL170:
 1723 05ec 97050000 		lla	a1,.LC7
 1723      93850500 
 1724              	.LVL171:
 1725 05f4 A2E9     		sd	s0,208(sp)
 1726 05f6 A6E5     		sd	s1,200(sp)
 1727 05f8 4EFD     		sd	s3,184(sp)
 1728 05fa 52F9     		sd	s4,176(sp)
 1729 05fc 56F5     		sd	s5,168(sp)
 1730 05fe 5AF1     		sd	s6,160(sp)
 1731 0600 5EED     		sd	s7,152(sp)
 1732 0602 62E9     		sd	s8,144(sp)
 1733 0604 66E5     		sd	s9,136(sp)
 1734 0606 6AE1     		sd	s10,128(sp)
 1735 0608 EEFC     		sd	s11,120(sp)
 1736 060a A2B4     		fsd	fs0,104(sp)
 1737              		.cfi_offset 8, -16
 1738              		.cfi_offset 9, -24
 1739              		.cfi_offset 19, -40
 1740              		.cfi_offset 20, -48
 1741              		.cfi_offset 21, -56
 1742              		.cfi_offset 22, -64
 1743              		.cfi_offset 23, -72
 1744              		.cfi_offset 24, -80
 1745              		.cfi_offset 25, -88
 1746              		.cfi_offset 26, -96
 1747              		.cfi_offset 27, -104
 1748              		.cfi_offset 40, -120
 1749 060c 97000000 		call	__printf_chk@plt
 1749      E7800000 
 1750              	.LVL172:
 1751              	.LBE207:
 1752              	.LBE206:
  34:P3GEMM.c      **** 	}
 1753              		.loc 1 34 3 is_stmt 1
 1754 0614 0545     		li	a0,1
 1755 0616 97000000 		call	exit@plt
 1755      E7800000 
 1756              	.LVL173:
 1757              	.L146:
 1758              		.cfi_restore 20
 1759              		.cfi_restore 21
 1760              		.cfi_restore 22
 1761              		.cfi_restore 24
 1762              		.cfi_restore 25
 1763              		.cfi_restore 26
 1764              		.cfi_restore 27
 1765              		.cfi_restore 40
  56:P3GEMM.c      **** 
 1766              		.loc 1 56 16 is_stmt 0 discriminator 1
 1767 061e 0545     		li	a0,1
 1768              	.LVL174:
 1769 0620 52F9     		sd	s4,176(sp)
 1770 0622 56F5     		sd	s5,168(sp)
 1771 0624 5AF1     		sd	s6,160(sp)
 1772 0626 62E9     		sd	s8,144(sp)
 1773 0628 66E5     		sd	s9,136(sp)
 1774 062a 6AE1     		sd	s10,128(sp)
 1775 062c EEFC     		sd	s11,120(sp)
 1776 062e A2B4     		fsd	fs0,104(sp)
  56:P3GEMM.c      **** 
 1777              		.loc 1 56 16 is_stmt 1 discriminator 1
 1778              		.cfi_offset 20, -48
 1779              		.cfi_offset 21, -56
 1780              		.cfi_offset 22, -64
 1781              		.cfi_offset 24, -80
 1782              		.cfi_offset 25, -88
 1783              		.cfi_offset 26, -96
 1784              		.cfi_offset 27, -104
 1785              		.cfi_offset 40, -120
 1786 0630 97000000 		call	exit@plt
 1786      E7800000 
 1787              	.LVL175:
 1788              	.L135:
 1789              		.cfi_restore 9
 1790              		.cfi_restore 19
 1791              		.cfi_restore 20
 1792              		.cfi_restore 21
 1793              		.cfi_restore 22
 1794              		.cfi_restore 24
 1795              		.cfi_restore 25
 1796              		.cfi_restore 26
 1797              		.cfi_restore 27
 1798              		.cfi_restore 40
 1799 0638 A6E5     		sd	s1,200(sp)
 1800              		.cfi_offset 9, -24
 1801 063a 49B7     		j	.L55
 1802              	.LVL176:
 1803              	.L64:
 1804              		.cfi_offset 19, -40
 1805              		.cfi_offset 20, -48
 1806              		.cfi_offset 21, -56
 1807              		.cfi_offset 22, -64
 1808              		.cfi_offset 24, -80
 1809 063c 66E5     		sd	s9,136(sp)
 1810 063e 6AE1     		sd	s10,128(sp)
 1811 0640 EEFC     		sd	s11,120(sp)
 1812              	.LVL177:
 1813              		.cfi_offset 25, -88
 1814              		.cfi_offset 26, -96
 1815              		.cfi_offset 27, -104
 1816              	.L140:
  85:P3GEMM.c      **** 		fclose(rfile);
 1817              		.loc 1 85 3 is_stmt 0
 1818 0642 17050000 		lla	a0,.LC3
 1818      13050500 
 1819 064a A2B4     		fsd	fs0,104(sp)
  85:P3GEMM.c      **** 		fclose(rfile);
 1820              		.loc 1 85 3 is_stmt 1
 1821              		.cfi_offset 40, -120
 1822 064c 97000000 		call	perror@plt
 1822      E7800000 
 1823              	.LVL178:
  86:P3GEMM.c      **** 		exit(EXIT_FAILURE);
 1824              		.loc 1 86 3
 1825 0654 4E85     		mv	a0,s3
 1826 0656 97000000 		call	fclose@plt
 1826      E7800000 
 1827              	.LVL179:
  87:P3GEMM.c      **** 	}
 1828              		.loc 1 87 3
 1829 065e 0545     		li	a0,1
 1830 0660 97000000 		call	exit@plt
 1830      E7800000 
 1831              	.LVL180:
 1832              	.L147:
 1833              		.cfi_restore 25
 1834              		.cfi_restore 40
 1835 0668 66E5     		sd	s9,136(sp)
 1836              		.cfi_offset 25, -88
 1837 066a E1BF     		j	.L140
 1838              	.LVL181:
 1839              	.L141:
 1840              		.cfi_restore 25
 1841              		.cfi_restore 27
 1842 066c 66E5     		sd	s9,136(sp)
 1843 066e EEFC     		sd	s11,120(sp)
 1844              		.cfi_offset 25, -88
 1845              		.cfi_offset 27, -104
 1846 0670 C9BF     		j	.L140
 1847              		.cfi_endproc
 1848              	.LFE66:
 1850              		.section	.rodata.cst4,"aM",@progbits,4
 1851              		.align	2
 1852              	.LC9:
 1853 0000 00008030 		.word	813694976
 1854              		.section	.rodata.cst8,"aM",@progbits,8
 1855              		.align	3
 1856              	.LC10:
 1857 0000 00000000 		.word	0
 1858 0004 80842E41 		.word	1093567616
 1859              		.text
 1860              	.Letext0:
 1861              		.file 4 "/usr/lib/gcc/riscv64-linux-gnu/14/include/stddef.h"
 1862              		.file 5 "/usr/include/riscv64-linux-gnu/bits/types.h"
 1863              		.file 6 "/usr/include/riscv64-linux-gnu/bits/types/struct_FILE.h"
 1864              		.file 7 "/usr/include/riscv64-linux-gnu/bits/types/FILE.h"
 1865              		.file 8 "/usr/include/riscv64-linux-gnu/sys/types.h"
 1866              		.file 9 "/usr/include/riscv64-linux-gnu/bits/types/time_t.h"
 1867              		.file 10 "/usr/include/riscv64-linux-gnu/bits/types/struct_timeval.h"
 1868              		.file 11 "/usr/include/riscv64-linux-gnu/bits/types/struct_timespec.h"
 1869              		.file 12 "/usr/include/riscv64-linux-gnu/bits/struct_stat.h"
 1870              		.file 13 "/usr/include/riscv64-linux-gnu/bits/types/struct_tm.h"
 1871              		.file 14 "/usr/include/stdio.h"
 1872              		.file 15 "/usr/include/time.h"
 1873              		.file 16 "/usr/include/riscv64-linux-gnu/sys/stat.h"
 1874              		.file 17 "/usr/include/riscv64-linux-gnu/bits/stdio2-decl.h"
 1875              		.file 18 "/usr/include/unistd.h"
 1876              		.file 19 "/usr/include/riscv64-linux-gnu/sys/time.h"
 1877              		.file 20 "/usr/include/string.h"
 1878              		.file 21 "<built-in>"
