.section .data
lista:		.int 0x10000000,0x10000000,0x10000000,0x10000000
          .int 0x10000000,0x10000000,0x10000000,0x10000000
          .int 0x10000000,0x10000000,0x10000000,0x10000000
          .int 0x10000000,0x10000000,0x10000000,0x10000000
longlista:	.int   (.-lista)/4
resultado:	.quad   0
  formato: 	.asciz	"suma = %lu = 0x%lx hex\n"

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
    mov          $0,%eax	  #varargin sin xmm
    call  printf		        # == printf(formato, res, res);

    mov  resultado, %edi
    call _exit		          # ==  exit(resultado)

suma:
	push     %rsi
	mov  $0, %eax             #Inicializamos los registros a 0
  mov  $0, %edx
	mov  $0, %rsi
bucle:
	add  (%rbx,%rsi,4), %eax  #Acumulamos el resultado
  jnc  incremento           #Si no hay acarreo saltamos a la etiqueta
  inc  %edx                 #Incrementamos en 1 la parte más significativa por acarreo

incremento:
	inc   %rsi
	cmp   %rsi,%rcx
	jne   bucle

	pop   %rsi
  ret
