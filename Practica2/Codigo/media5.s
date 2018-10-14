.section .data
lista:		.int 1,2,1,2
          .int 1,2,1,2
          .int 1,2,1,2
          .int 1,2,1,2
longlista:	.int   (.-lista)/4
media:      .int 0
resto:      .int 0
formato:    .ascii "media \t = %11d \t resto \t = %11d   \n"
            .asciz "\t = 0x %08x        \t\ = 0x %08x\n"

.section .text
main: .global  main

  	mov     $lista, %rbx
  	mov  longlista, %ecx
  	call suma		# == suma(&lista, longlista);
  	mov  %rax, media
    mov  %rdx, resto

    movq   $formato, %rdi
    movq   %rax,%rsi
    movq   resto,%rdx
    mov   media,%ecx
    mov   media+4,%r8d
    mov          $0,%eax	# varargin sin xmm
    call  printf		# == printf(formato, res, res);

    mov  media, %edi
    call _exit		# ==  exit(resultado)

suma:
	push     %rbp
	mov  $0, %eax
  mov  $0, %edx
	mov  $0, %rbp
  mov  $0, %rdi
bucle:
  mov (%rbx,%rbp,4), %eax
  cltq
  add  %rax, %rdi
  inc  %rbp
	cmp   %rbp,%rcx
	jne   bucle

  mov  %rdi, %rax

  # Division
  idiv %rcx
	pop  %rbp
  ret
