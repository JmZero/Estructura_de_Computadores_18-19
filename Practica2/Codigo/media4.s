.section .data
#ifndef TEST
#define TEST 19
#endif
      .macro linea
      #if TEST==1
          .int 1,2,1,2
      #elif TEST==2
          .int -1,-2,-1,-2
      #elif TEST==3
          .int 0x7FFFFFFF,0x7FFFFFFF,0x7FFFFFFF,0x7FFFFFFF
      #elif TEST==4
          .int 0x80000000,0x80000000,0x80000000,0x80000000
      #elif TEST==5
          .int 0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF
      #elif TEST==6
          .int 2000000000,2000000000,2000000000,2000000000
      #elif TEST==7
          .int 3000000000,3000000000,3000000000,3000000000
      #elif TEST==8
          .int -2000000000,-2000000000,-2000000000,-2000000000
      #elif TEST==9
          .int -3000000000,-3000000000,-3000000000,-3000000000
      #elif TEST>=10 && TEST<=14
          .int 1,1,1,1
      #elif TEST>=15 && TEST<=19
          .int -1,-1,-1,-1
      #else
          .error "Definir TEST entre 1..19"
      #endif
      .endm

      .macro linea0
      #if TEST>=1 && TEST<=9
          linea
      #elif TEST==10
          .int 0,2,1,1
      #elif TEST==11
          .int 1,2,1,1
      #elif TEST==12
          .int 8,2,1,1
      #elif TEST==13
          .int 15,2,1,1
      #elif TEST==14
          .int 16,2,1,1
      #elif TEST==15
          .int 0,-2,-1,-1
      #elif TEST==16
          .int -1,-2,-1,-1
      #elif TEST==17
          .int -8,-2,-1,-1
      #elif TEST==18
          .int -15,-2,-1,-1
      #elif TEST==19
          .int -16,-2,-1,-1
      #else
          .error "Definir TEST entre 1..19"
      #endif
      .endm

lista:      linea0
      .irpc i,123
            linea
       .endr
longlista:	.int   (.-lista)/4
media:      .int 0
resto:      .int 0
formato:    .ascii "media \t = %11d \t resto \t = %11d   \n"
            .asciz "\t = 0x %08x        \t\ = 0x %08x\n"

.section .text
main: .global  main

  	mov     $lista, %rbx
  	mov  longlista, %ecx
  	call suma		              # == suma(&lista, longlista);
  	mov  %eax, media          #Movemos el resultado de la media
    mov  %edx, resto          #Movemos el resto de la división

    mov   $formato, %rdi
    mov   media,%rsi
    mov   resto,%rdx
    mov   media,%ecx
    mov   media+4,%r8d
    mov          $0,%eax	    # varargin sin xmm
    call  printf		          # == printf(formato, res, res);

    mov  media, %edi
    call _exit		            # ==  exit(resultado)

suma:
	push     %rbp
	mov  $0, %eax               #Inicializamos los registros a 0
  mov  $0, %edx
	mov  $0, %rbp
  mov  $0, %esi               #Registros auxiliares
  mov  $0, %edi
bucle:
  mov (%rbx,%rbp,4), %eax     #Acumulamos el resultado
  cltd                        #Combierte EAX en EDX:EAX (Extendión de signo)
  add  %eax, %esi             #Guardamos contenido en los registros auxiliares
  adc  %edx, %edi
  inc  %rbp
	cmp   %rbp,%rcx
	jne   bucle

  mov  %esi, %eax             #Devolvemos el resultado a los registros
  mov  %edi, %edx

  idiv %ecx                   #Dividimos entre el numero de elementos
	pop   %rbp
  ret
