; Listing generated by Microsoft (R) Optimizing Compiler Version 19.00.23026.0 

include listing.inc

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

_DATA	SEGMENT
COMM	decoflags:BYTE
COMM	broadflags:BYTE
_DATA	ENDS
_DATA	SEGMENT
$SG10611 DB	'coff', 00H
	ORG $+3
$SG10614 DB	'safeseh', 00H
_DATA	ENDS
PUBLIC	SafeSEHDirective
EXTRN	EmitErr:PROC
EXTRN	EmitWarn:PROC
EXTRN	QAddItem:PROC
EXTRN	SymCreate:PROC
EXTRN	SymFind:PROC
EXTRN	Options:BYTE
EXTRN	ModuleInfo:BYTE
EXTRN	Parse_Pass:DWORD
pdata	SEGMENT
$pdata$SafeSEHDirective DD imagerel $LN32
	DD	imagerel $LN32+95
	DD	imagerel $unwind$SafeSEHDirective
$pdata$0$SafeSEHDirective DD imagerel $LN32+95
	DD	imagerel $LN32+146
	DD	imagerel $chain$0$SafeSEHDirective
$pdata$2$SafeSEHDirective DD imagerel $LN32+146
	DD	imagerel $LN32+204
	DD	imagerel $chain$2$SafeSEHDirective
$pdata$4$SafeSEHDirective DD imagerel $LN32+204
	DD	imagerel $LN32+284
	DD	imagerel $chain$4$SafeSEHDirective
$pdata$6$SafeSEHDirective DD imagerel $LN32+284
	DD	imagerel $LN32+357
	DD	imagerel $chain$6$SafeSEHDirective
$pdata$8$SafeSEHDirective DD imagerel $LN32+357
	DD	imagerel $LN32+375
	DD	imagerel $chain$8$SafeSEHDirective
pdata	ENDS
xdata	SEGMENT
$unwind$SafeSEHDirective DD 040a01H
	DD	07340aH
	DD	06006320aH
$chain$0$SafeSEHDirective DD 020521H
	DD	067405H
	DD	imagerel $LN32
	DD	imagerel $LN32+95
	DD	imagerel $unwind$SafeSEHDirective
$chain$2$SafeSEHDirective DD 020021H
	DD	067400H
	DD	imagerel $LN32
	DD	imagerel $LN32+95
	DD	imagerel $unwind$SafeSEHDirective
$chain$4$SafeSEHDirective DD 020021H
	DD	067400H
	DD	imagerel $LN32
	DD	imagerel $LN32+95
	DD	imagerel $unwind$SafeSEHDirective
$chain$6$SafeSEHDirective DD 020021H
	DD	067400H
	DD	imagerel $LN32
	DD	imagerel $LN32+95
	DD	imagerel $unwind$SafeSEHDirective
$chain$8$SafeSEHDirective DD 020021H
	DD	067400H
	DD	imagerel $LN32
	DD	imagerel $LN32+95
	DD	imagerel $unwind$SafeSEHDirective
xdata	ENDS
; Function compile flags: /Ogtpy
; File d:\hjwasm\hjwasm2.13.1s\hjwasm2.13.1s\safeseh.c
_TEXT	SEGMENT
i$ = 48
tokenarray$ = 56
SafeSEHDirective PROC

; 28   : {

$LN32:
	mov	QWORD PTR [rsp+16], rbx
	push	rsi
	sub	rsp, 32					; 00000020H

; 29   :     struct asym    *sym;
; 30   :     struct qnode   *node;
; 31   : 
; 32   :     if ( Options.output_format != OFORMAT_COFF ) {

	cmp	DWORD PTR Options+144, 2
	mov	rsi, rdx
	mov	ebx, ecx
	je	SHORT $LN5@SafeSEHDir

; 33   :         if ( Parse_Pass == PASS_1)

	cmp	DWORD PTR Parse_Pass, 0
	jne	SHORT $LN6@SafeSEHDir

; 34   :             EmitWarn( 2, DIRECTIVE_IGNORED_WITHOUT_X, "coff" );

	lea	r8, OFFSET FLAT:$SG10611
$LN30@SafeSEHDir:
	mov	edx, 261				; 00000105H
	mov	ecx, 2
	call	EmitWarn
$LN6@SafeSEHDir:

; 35   :         return( NOT_ERROR );

	xor	eax, eax

; 89   : }

	mov	rbx, QWORD PTR [rsp+56]
	add	rsp, 32					; 00000020H
	pop	rsi
	ret	0
$LN5@SafeSEHDir:

; 36   :     }
; 37   :     if ( Options.safeseh == FALSE ) {

	cmp	BYTE PTR Options+139, 0
	jne	SHORT $LN7@SafeSEHDir

; 38   :         if ( Parse_Pass == PASS_1)

	cmp	DWORD PTR Parse_Pass, 0
	jne	SHORT $LN6@SafeSEHDir

; 39   :             EmitWarn( 2, DIRECTIVE_IGNORED_WITHOUT_X, "safeseh" );

	lea	r8, OFFSET FLAT:$SG10614

; 40   :         return( NOT_ERROR );

	jmp	SHORT $LN30@SafeSEHDir
$LN7@SafeSEHDir:
	mov	QWORD PTR [rsp+48], rdi

; 41   :     }
; 42   :     i++;

	inc	ebx

; 43   :     if ( tokenarray[i].token != T_ID ) {

	movsxd	rdi, ebx
	shl	rdi, 5
	add	rdi, rdx
	cmp	BYTE PTR [rdi], 8
	je	SHORT $LN9@SafeSEHDir

; 44   :         return( EmitErr( SYNTAX_ERROR_EX, tokenarray[i].string_ptr ) );

	mov	rdx, QWORD PTR [rdi+8]
	mov	ecx, 209				; 000000d1H
	mov	rdi, QWORD PTR [rsp+48]

; 89   : }

	mov	rbx, QWORD PTR [rsp+56]
	add	rsp, 32					; 00000020H
	pop	rsi

; 44   :         return( EmitErr( SYNTAX_ERROR_EX, tokenarray[i].string_ptr ) );

	jmp	EmitErr
$LN9@SafeSEHDir:

; 45   :     }
; 46   :     sym = SymSearch( tokenarray[i].string_ptr );

	mov	rcx, QWORD PTR [rdi+8]
	call	SymFind
	mov	rdx, rax

; 47   : 
; 48   :     /* make sure the argument is a true PROC */
; 49   :     if ( sym == NULL || sym->state == SYM_UNDEFINED ) {

	test	rax, rax
	je	SHORT $LN12@SafeSEHDir
	cmp	DWORD PTR [rax+32], 0
	je	SHORT $LN12@SafeSEHDir

; 52   :         }
; 53   :     } else if ( sym->isproc == FALSE ) {

	test	BYTE PTR [rax+41], 8
	jne	SHORT $LN13@SafeSEHDir

; 54   :         return( EmitErr( SAFESEH_ARGUMENT_MUST_BE_A_PROC, tokenarray[i].string_ptr ) );

	mov	rdx, QWORD PTR [rdi+8]
	mov	ecx, 260				; 00000104H
	mov	rdi, QWORD PTR [rsp+48]

; 89   : }

	mov	rbx, QWORD PTR [rsp+56]
	add	rsp, 32					; 00000020H
	pop	rsi

; 54   :         return( EmitErr( SAFESEH_ARGUMENT_MUST_BE_A_PROC, tokenarray[i].string_ptr ) );

	jmp	EmitErr
$LN13@SafeSEHDir:

; 55   :     }
; 56   : 
; 57   :     if ( Parse_Pass == PASS_1 ) {

	cmp	DWORD PTR Parse_Pass, 0
	jne	SHORT $LN19@SafeSEHDir
$LN28@SafeSEHDir:

; 58   :         if ( sym ) {

	test	rax, rax
	je	SHORT $LN16@SafeSEHDir

; 59   :             for ( node = ModuleInfo.g.SafeSEHQueue.head; node; node = node->next )

	mov	rax, QWORD PTR ModuleInfo+48
	test	rax, rax
	je	SHORT $LN27@SafeSEHDir
$LL4@SafeSEHDir:

; 60   :                 if ( node->elmt == sym )

	cmp	QWORD PTR [rax+8], rdx
	je	SHORT $LN19@SafeSEHDir

; 59   :             for ( node = ModuleInfo.g.SafeSEHQueue.head; node; node = node->next )

	mov	rax, QWORD PTR [rax]
	test	rax, rax
	jne	SHORT $LL4@SafeSEHDir

; 61   :                     break;
; 62   :         } else {

	jmp	SHORT $LN27@SafeSEHDir
$LN12@SafeSEHDir:

; 50   :         if ( Parse_Pass != PASS_1 ) {

	cmp	DWORD PTR Parse_Pass, 0
	je	SHORT $LN28@SafeSEHDir

; 51   :             return( EmitErr( SYMBOL_NOT_DEFINED, tokenarray[i].string_ptr ) );

	mov	rdx, QWORD PTR [rdi+8]
	mov	ecx, 102				; 00000066H
	mov	rdi, QWORD PTR [rsp+48]

; 89   : }

	mov	rbx, QWORD PTR [rsp+56]
	add	rsp, 32					; 00000020H
	pop	rsi

; 51   :             return( EmitErr( SYMBOL_NOT_DEFINED, tokenarray[i].string_ptr ) );

	jmp	EmitErr
$LN16@SafeSEHDir:

; 63   :             sym = SymCreate( tokenarray[i].string_ptr );

	mov	rcx, QWORD PTR [rdi+8]
	call	SymCreate
	mov	rdx, rax
$LN27@SafeSEHDir:

; 64   :             node = NULL;
; 65   :         }
; 66   :         if ( node == NULL ) {
; 67   :             sym->used = TRUE; /* make sure an external reference will become strong */

	or	BYTE PTR [rdx+40], 1

; 68   : #if 0 /* v2.11: use QAddItem() */
; 69   :             node = LclAlloc( sizeof( struct qnode ) );
; 70   :             node->elmt = sym;
; 71   :             node->next = NULL;
; 72   :             if ( ModuleInfo.g.SafeSEHQueue.head == 0 )
; 73   :                 ModuleInfo.g.SafeSEHQueue.head = ModuleInfo.g.SafeSEHQueue.tail = node;
; 74   :             else {
; 75   :                 ((struct qnode *)ModuleInfo.g.SafeSEHQueue.tail)->next = node;
; 76   :                 ModuleInfo.g.SafeSEHQueue.tail = node;
; 77   :             }
; 78   : #else
; 79   :             QAddItem( &ModuleInfo.g.SafeSEHQueue, sym );

	lea	rcx, OFFSET FLAT:ModuleInfo+48
	call	QAddItem
$LN19@SafeSEHDir:

; 80   : #endif
; 81   :         }
; 82   :     }
; 83   :     i++;

	lea	eax, DWORD PTR [rbx+1]

; 84   :     if ( tokenarray[i].token != T_FINAL ) {

	cdqe
	shl	rax, 5
	cmp	BYTE PTR [rax+rsi], 0
	je	SHORT $LN20@SafeSEHDir

; 85   :         return( EmitErr( SYNTAX_ERROR_EX, tokenarray[i].string_ptr ) );

	mov	rdx, QWORD PTR [rax+rsi+8]
	mov	ecx, 209				; 000000d1H
	mov	rdi, QWORD PTR [rsp+48]

; 89   : }

	mov	rbx, QWORD PTR [rsp+56]
	add	rsp, 32					; 00000020H
	pop	rsi

; 85   :         return( EmitErr( SYNTAX_ERROR_EX, tokenarray[i].string_ptr ) );

	jmp	EmitErr
$LN20@SafeSEHDir:
	mov	rdi, QWORD PTR [rsp+48]

; 86   :     }
; 87   : 
; 88   :     return( NOT_ERROR );

	xor	eax, eax

; 89   : }

	mov	rbx, QWORD PTR [rsp+56]
	add	rsp, 32					; 00000020H
	pop	rsi
	ret	0
SafeSEHDirective ENDP
_TEXT	ENDS
END
