.section .data
#ifndef TEST
#define TEST 9
#endif
      .macro linea
      #if TEST==1
          .int -1,-1,-1,-1
      #elif TEST==2
          .int 0x04000000,0x04000000,0x04000000,0x04000000
      #elif TEST==3
          .int 0x08000000,0x08000000,0x08000000,0x08000000
      #elif TEST==4
          .int 0x10000000,0x10000000,0x10000000,0x10000000
      #elif TEST==5
          .int 0x7FFFFFFF,0x7FFFFFFF,0x7FFFFFFF,0x7FFFFFFF
      #elif TEST==6
          .int 0x80000000,0x80000000,0x80000000,0x80000000
      #elif TEST==7
          .int 0xF0000000,0xF0000000,0xF0000000,0xF0000000
      #elif TEST==8
          .int 0xF8000000,0xF8000000,0xF8000000,0xF8000000
      #elif TEST==9
          .int 0xF7FFFFFF,0xF7FFFFFF,0xF7FFFFFF,0xF7FFFFFF
      #elif TEST==10
          .int 100000000,100000000,100000000,100000000
      #elif TEST==11
          .int 200000000,200000000,200000000,200000000
      #elif TEST==12
          .int 300000000,300000000,300000000,300000000
      #elif TEST==13
          .int 2000000000,2000000000,2000000000,2000000000
      #elif TEST==14
          .int 3000000000,3000000000,3000000000,3000000000
      #elif TEST==15
          .int -100000000,-100000000,-100000000,-100000000
      #elif TEST==16
          .int -200000000,-200000000,-200000000,-200000000
      #elif TEST==17
          .int -300000000,-300000000,-300000000,-300000000
      #elif TEST==18
          .int -2000000000,-2000000000,-2000000000,-2000000000
      #elif TEST==19
          .int -3000000000,-3000000000,-3000000000,-3000000000
      #else
          .error "Definir TEST entre 1..19"
      #endif
      .endm
lista: .irpc i,1234
              linea
       .endr
longlista:	.int   (.-lista)/4
resultado:	.quad   0
formato:    .ascii  "resultado \t = %18ld (sgn)\n"
            .ascii        "\t\t = 0x%18lx (hex)\n"
            .asciz        "\t\t = 0x %08x %08x \n"

.section .text
main: .global  main

  	mov     $lista, %rbx
  	mov  longlista, %ecx
  	call suma		            # == suma(&lista, longlista);
  	mov  %eax, resultado    #Movemos la parte menos significativa
    mov  %edx, resultado+4  #Movemos la parte más significativa (acarreo)

    mov   $formato, %rdi
    mov   resultado,%rsi
    mov   resultado,%rdx
    mov   resultado+4,%ecx
    mov   resultado,%r8d
    mov          $0,%eax	  # varargin sin xmm
    call  printf		        # == printf(formato, res, res);

    mov  resultado, %edi
    call _exit		          # ==  exit(resultado)

suma:
	push     %rbp
	mov  $0, %eax             #Inicializamos los registros a 0
  mov  $0, %edx
	mov  $0, %rbp
  mov  $0, %esi             #Registros auxiliares
  mov  $0, %edi
bucle:
  mov (%rbx,%rbp,4), %eax   #Acumulamos el resultado
  cltd                      #Combierte EAX en EDX:EAX (Extendión de signo)
  add  %eax, %esi           #Guardamos contenido en los registros auxiliares
  adc  %edx, %edi
  inc  %rbp
	cmp   %rbp,%rcx
	jne   bucle

  mov  %esi, %eax           #Devolvemos el resultado a los registros
  mov  %edi, %edx
	pop   %rbp
  ret
