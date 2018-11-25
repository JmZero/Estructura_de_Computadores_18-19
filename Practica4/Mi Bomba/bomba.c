// gcc -Og bomba.c -o bomba -no-pie -fno-guess-branch-probability

#include <stdio.h>	// para printf(), fgets(), scanf()
#include <stdlib.h>	// para exit()
#include <string.h>	// para strncmp()
#include <sys/time.h>	// para gettimeofday(), struct timeval

/*
Esta bomba estara codificada de manera que la contraseña que entre se le aplicara el numero del Cesar.
A los valores pares les sumaremos 1 y a los impares le restaremos 1.
Para el codigo aplicaremos un transformacion de cada valor entero introducido a su correspondiente valor
en la tabla ASCII.
La contraseña que hay que introducir es: lbkjbjnvr
El código que hay que introducir es: 6948
*/

#define SIZE 100
#define TLIM 60

char password[]="malicious\n";	// contraseña
int  passcode  = 13896;			// pin

void boom(void){
	printf(	"\n"
		"***************\n"
		"*** BOOM!!! ***\n"
		"***************\n"
		"\n");
	exit(-1);
}

void defused(void){
	printf(	"\n"
		"·························\n"
		"··· bomba desactivada ···\n"
		"·························\n"
		"\n");
	exit(0);
}

void decodificar(char contra[]){
	int i;

	for( i = 0; i < strlen(contra) && contra[i] != '\n'; i++){
		if( i == 0 || i % 2 == 0)
			contra[i] = contra[i] + 1;
		else
			contra[i] = contra[i] - 1;
	}
}

int main(){
	char pw[SIZE];
	int  pc, n;

	struct timeval tv1,tv2;	// gettimeofday() secs-usecs
	gettimeofday(&tv1,NULL);

	do	printf("\nIntroduce la contraseña: ");
	while (	fgets(pw, SIZE, stdin) == NULL );
	decodificar(pw);
	if (strncmp(pw,password,sizeof(password)))
		boom();

	gettimeofday(&tv2,NULL);
	if (tv2.tv_sec - tv1.tv_sec > TLIM)
	  boom();

	do  {	printf("\nIntroduce el pin: ");
	 if ((n=scanf("%i",&pc))==0)
		scanf("%*s")    ==1;         }
	while (	n!=1 );
	pc*=2;
	if    (	pc != passcode )
	    boom();

	gettimeofday(&tv1,NULL);
	if    ( tv1.tv_sec - tv2.tv_sec > TLIM )
	    boom();

	defused();
}
