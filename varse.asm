bits 64
default rel
%define FILE_MAX 2097152
%define TOK_SIZE 32
%define SYM_SIZE 256
%define MAX_SYMS 512
%define MAX_TOKS 32767
%define T_EOF 0
%define T_DEF 1
%define T_FN 2
%define T_LET 3
%define T_RET 4
%define T_PRINT 5
%define T_IDENT 6
%define T_NUM 7
%define T_PLUS 8
%define T_MINUS 9
%define T_STAR 10
%define T_SLASH 11
%define T_LPAREN 12
%define T_RPAREN 13
%define T_LBRACE 14
%define T_RBRACE 15
%define T_COLON 16
%define T_SEMI 17
%define T_EQ 18
%define T_COMMA 19
%define T_IF 20
%define T_ELSE 21
%define T_LT 22
%define T_GT 23
%define T_LE 24
%define T_GE 25
%define T_EQEQ 26
%define T_NE 27
%define T_STRING 28
%define T_WINDOW 29
%define T_BUTTON 30
%define T_LABEL 31
%define T_SHOW 32
%define T_ONCLICK 33
%define SYM_VAR 0
%define SYM_FN 1
%define SD_NAME_PTR 0
%define SD_NAME_LEN 8
%define SD_VALUE 16
%define SD_TYPE 24
%define SD_BODY_START 32
%define SD_BODY_END 40
%define SD_PARAM_COUNT 48
%define SD_PARAMS 56
%define WIDGET_SIZE 512
%define MAX_WIDGETS 128
%define WD_NAME_PTR 0
%define WD_NAME_LEN 8
%define WD_TYPE 16
%define WD_X 24
%define WD_Y 32
%define WD_W 40
%define WD_H 48
%define WD_TEXT_PTR 56
%define WD_TEXT_LEN 64
%define WD_COLOR 72
%define WD_RADIUS 80
%define WD_CB_START 88
%define WD_CB_END 96
%define WM_PAINT 0x000F
%define WM_LBUTTONDOWN 0x0201
%define WM_DESTROY 0x0002
%define WS_OVERLAPPEDWINDOW 0x00CF0000
%define SW_SHOW 5
%define COLOR_WINDOW 5
%define IDC_ARROW 32512
%define DT_CENTER 0x00000001
%define DT_VCENTER 0x00000004
%define DT_SINGLELINE 0x00000020
%define TRANSPARENT 1
%define CS_VREDRAW 0x0001
%define CS_HREDRAW 0x0002
section .data
    msg_usage db "usage: varse file.var", 13, 10, 9, "or:   varse --build file.var -o out.exe", 13, 10, 0
    msg_openfail db "cannot open that file", 13, 10, 0
    msg_readfail db "could not read that file", 13, 10, 0
    msg_toobig db "file too big for this little interpreter", 13, 10, 0
    msg_nomain db "no fn main() found anywhere", 13, 10, 0
    msg_err db "error: ", 0
    msg_line db " at line ", 0
    msg_nl db 13, 10, 0
    msg_sp db ' ', 0
    msg_syntax db "syntax error", 0
    msg_eoi db "ran out of code, missing a } or ) somewhere", 0
    msg_undef db "undefined thing '", 0
    msg_notfn db "thing is not callable", 0
    msg_wrongargs db "wrong number of arguments", 0
    msg_divzero db "division by zero", 0
    msg_full db "too many symbols, compiler is full", 0
    msg_built db "built ", 0
    msg_appendfail db "could not build the output exe", 13, 10, 0
    flag_build db "--build", 0
    flag_o db "-o", 0
    magic db "VARSESRC"
    wndclass_name db "VarseWndClass", 0
    default_title db "Varse Window", 0
section .bss
    hout resq 1
    hfile resq 1
    src resb FILE_MAX
    srclen resq 1
    toks resb 1048576
    ntoks resq 1
    syms resb 131072
    nsyms resq 1
    tcur resq 1
    retflag resq 1
    retval resq 1
    fstack resq 512
    fdepth resq 1
    argmode resq 1
    lines resq MAX_TOKS
    curline resq 1
    nbuf resb 40
    iop resq 1
    argcount resq 1
    args resq 16
    argbuf resb 4096
    selfpath resb 1024
    selfsize resq 1
    trailer resb 16
    widgets resb WIDGET_SIZE * MAX_WIDGETS
    nwidgets resq 1
    hwnd_main resq 1
    paintstruct resb 64
    clientrect resb 16
    drawrect resb 16
    wndclass resb 80
    msgbuf resb 256
section .text
    global main
extern GetCommandLineA
extern GetStdHandle
extern GetModuleFileNameA
extern CopyFileA
extern CreateFileA
extern GetFileSize
extern SetFilePointerEx
extern ReadFile
extern WriteFile
extern CloseHandle
extern RegisterClassExA
extern CreateWindowExA
extern ShowWindow
extern UpdateWindow
extern GetMessageA
extern TranslateMessage
extern DispatchMessageA
extern DefWindowProcA
extern PostQuitMessage
extern LoadCursorA
extern GetModuleHandleA
extern BeginPaint
extern EndPaint
extern GetClientRect
extern CreateSolidBrush
extern FillRect
extern DeleteObject
extern CreateRoundRectRgn
extern FillRgn
extern SetBkMode
extern SetTextColor
extern DrawTextA
extern ExitProcess
main:
    sub rsp, 56
    mov ecx, -11
    call GetStdHandle
    mov [hout], rax
    call GetCommandLineA
    mov rcx, rax
    call parse_args
    mov [argcount], rax
    call try_embedded
    test rax, rax
    jnz .runit
    mov rax, [argcount]
    cmp rax, 2
    jl .usage
    mov rcx, [args+8]
    lea rdx, [flag_build]
    call streq
    test rax, rax
    jz .runfile
    mov rax, [argcount]
    cmp rax, 5
    jne .usage
    mov rcx, [args+24]
    lea rdx, [flag_o]
    call streq
    test rax, rax
    jz .usage
    mov rcx, [args+16]
    mov rdx, [args+32]
    call build_exe
    test rax, rax
    jz .appendfail
    lea rcx, [msg_built]
    call pstr
    mov rcx, [args+32]
    call pstr
    lea rcx, [msg_nl]
    call pstr
    xor ecx, ecx
    call ExitProcess
.runfile:
    mov rcx, [args+8]
    call load_file
    test rax, rax
    jz .openfail
    call tokenize
    call interpret
    xor ecx, ecx
    call ExitProcess
.runit:
    call tokenize
    call interpret
    xor ecx, ecx
    call ExitProcess
.usage:
    lea rcx, [msg_usage]
    call pstr
    mov ecx, 1
    call ExitProcess
.openfail:
    lea rcx, [msg_openfail]
    call pstr
    mov ecx, 1
    call ExitProcess
.appendfail:
    lea rcx, [msg_appendfail]
    call pstr
    mov ecx, 1
    call ExitProcess
parse_args:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 40
    mov rsi, rcx
    lea r12, [args]
    lea r13, [argbuf]
    lea rbx, [argbuf+4096]
    xor r14d, r14d
.anew:
    cmp r14, 16
    jae .adone
.askip:
    movzx eax, byte [rsi]
    test al, al
    jz .adone
    cmp al, ' '
    je .anx
    cmp al, 9
    je .anx
    jmp .atok
.anx:
    inc rsi
    jmp .askip
.atok:
    mov [r12 + r14*8], r13
    cmp al, '"'
    je .aq
.aucopy:
    movzx eax, byte [rsi]
    test al, al
    jz .aend
    cmp al, ' '
    je .aend
    cmp al, 9
    je .aend
    mov [r13], al
    inc r13
    inc rsi
    cmp r13, rbx
    jae .aend
    jmp .aucopy
.aq:
    inc rsi
.aqcopy:
    movzx eax, byte [rsi]
    test al, al
    jz .aend
    cmp al, '"'
    je .aqdone
    mov [r13], al
    inc r13
    inc rsi
    cmp r13, rbx
    jae .aend
    jmp .aqcopy
.aqdone:
    inc rsi
.aend:
    mov byte [r13], 0
    inc r13
    inc r14
    jmp .anew
.adone:
    mov rax, r14
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
streq:
    push rbx
    sub rsp, 32
.sl:
    movzx eax, byte [rcx]
    movzx edx, byte [rdx]
    cmp al, dl
    jne .sno
    test al, al
    jz .syes
    inc rcx
    inc rdx
    jmp .sl
.syes:
    mov eax, 1
    add rsp, 32
    pop rbx
    ret
.sno:
    xor eax, eax
    add rsp, 32
    pop rbx
    ret
load_file:
    push rbx
    push r12
    push r13
    sub rsp, 32
    mov rbx, rcx
    mov rcx, rbx
    mov edx, 0x80000000
    xor r8d, r8d
    xor r9d, r9d
    mov dword [rsp+32], 3
    mov qword [rsp+40], 0
    mov qword [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    je .lbad
    mov [hfile], rax
    mov rcx, rax
    xor edx, edx
    call GetFileSize
    cmp rax, FILE_MAX
    jae .lbad
    mov [srclen], rax
    mov rcx, [hfile]
    lea rdx, [src]
    mov r8, [srclen]
    lea r9, [iop]
    mov qword [rsp+32], 0
    call ReadFile
    test eax, eax
    jz .lbad
    mov rax, [iop]
    mov [srclen], rax
    lea rax, [src]
    add rax, [srclen]
    mov byte [rax], 0
    mov rcx, [hfile]
    call CloseHandle
    mov eax, 1
    add rsp, 32
    pop r13
    pop r12
    pop rbx
    ret
.lbad:
    xor eax, eax
    add rsp, 32
    pop r13
    pop r12
    pop rbx
    ret
try_embedded:
    sub rsp, 40
    lea rcx, [selfpath]
    mov edx, 1024
    xor r8d, r8d
    call GetModuleFileNameA
    test eax, eax
    jz .enone
    lea rcx, [selfpath]
    mov edx, 0x80000000
    xor r8d, r8d
    xor r9d, r9d
    mov dword [rsp+32], 3
    mov qword [rsp+40], 0
    mov qword [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    je .enone
    mov [hfile], rax
    mov rcx, rax
    xor edx, edx
    call GetFileSize
    cmp rax, 16
    jb .eclose
    mov [selfsize], rax
    mov rcx, [hfile]
    mov rdx, rax
    sub rdx, 16
    xor r8d, r8d
    xor r9d, r9d
    call SetFilePointerEx
    mov rcx, [hfile]
    lea rdx, [trailer]
    mov r8d, 16
    lea r9, [iop]
    mov qword [rsp+32], 0
    call ReadFile
    test eax, eax
    jz .eclose
    lea rsi, [trailer]
    lea rdi, [magic]
    mov ecx, 8
    repe cmpsb
    jne .eclose
    mov rax, [trailer+8]
    cmp rax, [selfsize]
    jae .eclose
    neg rax
    add rax, [selfsize]
    sub rax, 16
    jb .eclose
    mov [selfsize], rax
    mov rax, [trailer+8]
    cmp rax, FILE_MAX
    jae .eclose
    mov [srclen], rax
    mov rcx, [hfile]
    mov rdx, [selfsize]
    xor r8d, r8d
    xor r9d, r9d
    call SetFilePointerEx
    mov rcx, [hfile]
    lea rdx, [src]
    mov r8, [srclen]
    lea r9, [iop]
    mov qword [rsp+32], 0
    call ReadFile
    test eax, eax
    jz .eclose
    mov rax, [iop]
    mov [srclen], rax
    lea rax, [src]
    add rax, [srclen]
    mov byte [rax], 0
    mov rcx, [hfile]
    call CloseHandle
    mov eax, 1
    add rsp, 40
    ret
.eclose:
    mov rcx, [hfile]
    call CloseHandle
.enone:
    xor eax, eax
    add rsp, 40
    ret
build_exe:
    push rbx
    push rsi
    push rdi
    sub rsp, 32
    mov rbx, rcx
    mov rsi, rdx
    lea rcx, [selfpath]
    mov edx, 1024
    xor r8d, r8d
    call GetModuleFileNameA
    test eax, eax
    jz .bbad
    lea rcx, [selfpath]
    mov rdx, rsi
    xor r8d, r8d
    call CopyFileA
    test eax, eax
    jz .bbad
    mov rcx, rbx
    call load_file
    test rax, rax
    jz .bbad
    mov rcx, rsi
    mov edx, 4
    xor r8d, r8d
    xor r9d, r9d
    mov dword [rsp+32], 4
    mov qword [rsp+40], 0
    mov qword [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    je .bbad
    mov [hfile], rax
    mov rcx, rax
    lea rdx, [src]
    mov r8, [srclen]
    lea r9, [iop]
    mov qword [rsp+32], 0
    call WriteFile
    test eax, eax
    jz .bbad
    mov rcx, [hfile]
    lea rdx, [magic]
    mov r8d, 8
    lea r9, [iop]
    mov qword [rsp+32], 0
    call WriteFile
    test eax, eax
    jz .bbad
    mov rax, [srclen]
    mov [trailer], rax
    mov rcx, [hfile]
    lea rdx, [trailer]
    mov r8d, 8
    lea r9, [iop]
    mov qword [rsp+32], 0
    call WriteFile
    test eax, eax
    jz .bbad
    mov rcx, [hfile]
    call CloseHandle
    mov eax, 1
    add rsp, 32
    pop rdi
    pop rsi
    pop rbx
    ret
.bbad:
    xor eax, eax
    add rsp, 32
    pop rdi
    pop rsi
    pop rbx
    ret
pstr:
    push rbx
    push rsi
    sub rsp, 40
    mov rsi, rcx
    mov rdx, rcx
    xor rbx, rbx
.plen:
    lodsb
    test al, al
    jz .pdone
    inc rbx
    jmp .plen
.pdone:
    mov r8, rbx
    lea r9, [iop]
    mov rcx, [hout]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
    pop rsi
    pop rbx
    ret
pint:
    push rbx
    push rsi
    push rdi
    sub rsp, 32
    mov rax, rcx
    lea rdi, [nbuf+39]
    mov byte [rdi], 0
    test rax, rax
    jns .positive
    neg rax
    mov rsi, 1
    jmp .convert
.positive:
    xor rsi, rsi
.convert:
    mov rbx, 10
    xor rdx, rdx
    div rbx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    test rax, rax
    jnz .convert
    test rsi, rsi
    jz .noneg
    dec rdi
    mov byte [rdi], '-'
.noneg:
    mov rdx, rdi
    lea rbx, [nbuf+39]
    sub rbx, rdi
    mov r8, rbx
    lea r9, [iop]
    mov rcx, [hout]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 32
    pop rdi
    pop rsi
    pop rbx
    ret
fatal:
    push rbx
    sub rsp, 48
    mov rbx, r8
    lea rcx, [msg_err]
    call pstr
    mov rcx, rbx
    call pstr
    mov rax, [tcur]
    sub rax, toks
    cqo
    mov rcx, 32
    idiv rcx
    mov rax, [lines + rax*8]
    mov rcx, rax
    push rcx
    lea rcx, [msg_line]
    call pstr
    pop rcx
    call pint
    lea rcx, [msg_nl]
    call pstr
    add rsp, 48
    pop rbx
    mov ecx, 1
    call ExitProcess
tokenize:
    push rbx
    push rsi
    push rdi
    push r12
    push r13
    push r14
    sub rsp, 40
    lea rsi, [src]
    lea rdi, [toks]
    xor r12, r12
    mov qword [curline], 1
    mov qword [lines], 1
.tloop:
    cmp r12, MAX_TOKS
    jae .eof
    movzx eax, byte [rsi]
    test al, al
    jz .eof
    cmp al, ' '
    je .wskip
    cmp al, 9
    je .wskip
    cmp al, 13
    je .wskip
    cmp al, 10
    je .wnewline
    cmp al, '/'
    je .maybcomment
    jmp .tok
.wnewline:
    inc qword [curline]
    inc rsi
    jmp .tloop
.wskip:
    inc rsi
    jmp .tloop
.maybcomment:
    cmp byte [rsi+1], '/'
    je .linecomment
    cmp byte [rsi+1], '*'
    je .blockcomment
    jmp .tok
.linecomment:
    add rsi, 2
.lc:
    movzx eax, byte [rsi]
    test al, al
    jz .eof
    cmp al, 10
    je .wnewline
    inc rsi
    jmp .lc
.blockcomment:
    add rsi, 2
.bc:
    movzx eax, byte [rsi]
    test al, al
    jz .eof
    cmp al, '*'
    jne .bcbody
    cmp byte [rsi+1], '/'
    jne .bcbody
    add rsi, 2
    jmp .tloop
.bcbody:
    cmp al, 10
    jne .bcnonew
    inc qword [curline]
.bcnonew:
    inc rsi
    jmp .bc
.eof:
    mov byte [rdi], T_EOF
    mov qword [rdi+8], 0
    mov qword [rdi+16], 0
    mov qword [rdi+24], 0
    inc r12
    mov [ntoks], r12
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rdi
    pop rsi
    pop rbx
    ret
.tok:
    mov r13, rsi
    movzx eax, byte [rsi]
    cmp al, '"'
    je .tstring
    cmp al, '#'
    je .thex
    cmp al, '0'
    jb .fnonum
    cmp al, '9'
    jbe .tnum
.fnonum:
    cmp al, '_'
    je .tident
    cmp al, 'a'
    jb .fop
    cmp al, 'z'
    jbe .tident
    cmp al, 'A'
    jb .fop
    cmp al, 'Z'
    jbe .tident
    jmp .fop
.tnum:
    xor rax, rax
.tnloop:
    movzx ecx, byte [rsi]
    cmp ecx, '0'
    jb .tndone
    cmp ecx, '9'
    ja .tndone
    imul rax, rax, 10
    sub ecx, '0'
    add rax, rcx
    inc rsi
    jmp .tnloop
.tndone:
    mov byte [rdi], T_NUM
    mov qword [rdi+8], rax
    mov qword [rdi+16], r13
    mov rcx, rsi
    sub rcx, r13
    mov qword [rdi+24], rcx
    call store_line
    add rdi, TOK_SIZE
    inc r12
    jmp .tloop
.tident:
    inc rsi
    movzx eax, byte [rsi]
    cmp al, '_'
    je .tident
    cmp al, '0'
    jb .identdone
    cmp al, '9'
    jbe .tident
    cmp al, 'a'
    jb .identdone
    cmp al, 'z'
    jbe .tident
    cmp al, 'A'
    jb .identdone
    cmp al, 'Z'
    jbe .tident
.identdone:
    mov rcx, rsi
    sub rcx, r13
    cmp rcx, 2
    je .chk2
    cmp rcx, 3
    je .chk3
    cmp rcx, 4
    je .chk4
    cmp rcx, 5
    je .chk5
    cmp rcx, 6
    je .chk6
    cmp rcx, 7
    je .chk7
    jmp .store_ident
.chk2:
    cmp byte [r13], 'f'
    jne .chk2if
    cmp byte [r13+1], 'n'
    jne .store_ident
    mov byte [rdi], T_FN
    jmp .store_kw
.chk2if:
    cmp byte [r13], 'i'
    jne .store_ident
    cmp byte [r13+1], 'f'
    jne .store_ident
    mov byte [rdi], T_IF
    jmp .store_kw
.chk3:
    cmp byte [r13], 'd'
    je .chkdef
    cmp byte [r13], 'l'
    je .chklet
    jmp .store_ident
.chkdef:
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 'f'
    jne .store_ident
    mov byte [rdi], T_DEF
    jmp .store_kw
.chklet:
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 't'
    jne .store_ident
    mov byte [rdi], T_LET
    jmp .store_kw
.chk4:
    cmp byte [r13], 'e'
    jne .chk4show
    cmp byte [r13+1], 'l'
    jne .store_ident
    cmp byte [r13+2], 's'
    jne .store_ident
    cmp byte [r13+3], 'e'
    jne .store_ident
    mov byte [rdi], T_ELSE
    jmp .store_kw
.chk4show:
    cmp byte [r13], 's'
    jne .store_ident
    cmp byte [r13+1], 'h'
    jne .store_ident
    cmp byte [r13+2], 'o'
    jne .store_ident
    cmp byte [r13+3], 'w'
    jne .store_ident
    mov byte [rdi], T_SHOW
    jmp .store_kw
.chk5:
    cmp byte [r13], 'p'
    jne .chk5label
    cmp byte [r13+1], 'r'
    jne .store_ident
    cmp byte [r13+2], 'i'
    jne .store_ident
    cmp byte [r13+3], 'n'
    jne .store_ident
    cmp byte [r13+4], 't'
    jne .store_ident
    mov byte [rdi], T_PRINT
    jmp .store_kw
.chk5label:
    cmp byte [r13], 'l'
    jne .store_ident
    cmp byte [r13+1], 'a'
    jne .store_ident
    cmp byte [r13+2], 'b'
    jne .store_ident
    cmp byte [r13+3], 'e'
    jne .store_ident
    cmp byte [r13+4], 'l'
    jne .store_ident
    mov byte [rdi], T_LABEL
    jmp .store_kw
.chk6:
    cmp byte [r13], 'r'
    jne .chk6win
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 't'
    jne .store_ident
    cmp byte [r13+3], 'u'
    jne .store_ident
    cmp byte [r13+4], 'r'
    jne .store_ident
    cmp byte [r13+5], 'n'
    jne .store_ident
    mov byte [rdi], T_RET
    jmp .store_kw
.chk6win:
    cmp byte [r13], 'w'
    jne .chk6btn
    cmp byte [r13+1], 'i'
    jne .store_ident
    cmp byte [r13+2], 'n'
    jne .store_ident
    cmp byte [r13+3], 'd'
    jne .store_ident
    cmp byte [r13+4], 'o'
    jne .store_ident
    cmp byte [r13+5], 'w'
    jne .store_ident
    mov byte [rdi], T_WINDOW
    jmp .store_kw
.chk6btn:
    cmp byte [r13], 'b'
    jne .store_ident
    cmp byte [r13+1], 'u'
    jne .store_ident
    cmp byte [r13+2], 't'
    jne .store_ident
    cmp byte [r13+3], 't'
    jne .store_ident
    cmp byte [r13+4], 'o'
    jne .store_ident
    cmp byte [r13+5], 'n'
    jne .store_ident
    mov byte [rdi], T_BUTTON
    jmp .store_kw
.store_ident:
    mov byte [rdi], T_IDENT
    mov qword [rdi+8], 0
    mov qword [rdi+16], r13
    mov rcx, rsi
    sub rcx, r13
    mov qword [rdi+24], rcx
    call store_line
    add rdi, TOK_SIZE
    inc r12
    jmp .tloop
.store_kw:
    mov qword [rdi+8], 0
    mov qword [rdi+16], r13
    mov rcx, rsi
    sub rcx, r13
    mov qword [rdi+24], rcx
    call store_line
    add rdi, TOK_SIZE
    inc r12
    jmp .tloop
.fop:
    movzx eax, byte [rsi]
    cmp al, '+'
    je .op_plus
    cmp al, '-'
    je .op_minus
    cmp al, '*'
    je .op_star
    cmp al, '/'
    je .op_slash
    cmp al, '('
    je .op_lparen
    cmp al, ')'
    je .op_rparen
    cmp al, '{'
    je .op_lbrace
    cmp al, '}'
    je .op_rbrace
    cmp al, ':'
    je .op_colon
    cmp al, ';'
    je .op_semi
    cmp al, ','
    je .op_comma
    cmp al, '='
    je .op_eqmaybe
    cmp al, '<'
    je .op_lt
    cmp al, '>'
    je .op_gt
    cmp al, '!'
    je .op_bang
    jmp .op_bad
.op_plus:
    mov byte [rdi], T_PLUS
    inc rsi
    jmp .op_store
.op_minus:
    mov byte [rdi], T_MINUS
    inc rsi
    jmp .op_store
.op_star:
    mov byte [rdi], T_STAR
    inc rsi
    jmp .op_store
.op_slash:
    mov byte [rdi], T_SLASH
    inc rsi
    jmp .op_store
.op_lparen:
    mov byte [rdi], T_LPAREN
    inc rsi
    jmp .op_store
.op_rparen:
    mov byte [rdi], T_RPAREN
    inc rsi
    jmp .op_store
.op_lbrace:
    mov byte [rdi], T_LBRACE
    inc rsi
    jmp .op_store
.op_rbrace:
    mov byte [rdi], T_RBRACE
    inc rsi
    jmp .op_store
.op_colon:
    mov byte [rdi], T_COLON
    inc rsi
    jmp .op_store
.op_semi:
    mov byte [rdi], T_SEMI
    inc rsi
    jmp .op_store
.op_comma:
    mov byte [rdi], T_COMMA
    inc rsi
    jmp .op_store
.op_eqmaybe:
    cmp byte [rsi+1], '='
    jne .op_eq
    mov byte [rdi], T_EQEQ
    add rsi, 2
    jmp .op_store
.op_eq:
    mov byte [rdi], T_EQ
    inc rsi
    jmp .op_store
.op_lt:
    cmp byte [rsi+1], '='
    jne .op_ltp
    mov byte [rdi], T_LE
    add rsi, 2
    jmp .op_store
.op_ltp:
    mov byte [rdi], T_LT
    inc rsi
    jmp .op_store
.op_gt:
    cmp byte [rsi+1], '='
    jne .op_gtp
    mov byte [rdi], T_GE
    add rsi, 2
    jmp .op_store
.op_gtp:
    mov byte [rdi], T_GT
    inc rsi
    jmp .op_store
.op_bang:
    cmp byte [rsi+1], '='
    jne .op_bad
    mov byte [rdi], T_NE
    add rsi, 2
    jmp .op_store
.op_store:
    mov qword [rdi+8], 0
    mov qword [rdi+16], r13
    mov rcx, rsi
    sub rcx, r13
    mov qword [rdi+24], rcx
    call store_line
    add rdi, TOK_SIZE
    inc r12
    jmp .tloop
.op_bad:
    inc rsi
    jmp .tloop
.tstring:
    inc rsi
    mov r13, rsi
.tstrloop:
    movzx eax, byte [rsi]
    test al, al
    jz .tstrdone
    cmp al, '"'
    je .tstrdone
    cmp al, 10
    jne .tstrnonl
    inc qword [curline]
.tstrnonl:
    inc rsi
    jmp .tstrloop
.tstrdone:
    mov byte [rdi], T_STRING
    mov qword [rdi+8], 0
    mov [rdi+16], r13
    mov rcx, rsi
    sub rcx, r13
    mov [rdi+24], rcx
    cmp byte [rsi], '"'
    jne .tstrbad
    mov byte [rsi], 0
    inc rsi
.tstrbad:
    call store_line
    add rdi, TOK_SIZE
    inc r12
    jmp .tloop
.thex:
    inc rsi
    xor rax, rax
.thexloop:
    movzx ecx, byte [rsi]
    test cl, cl
    jz .thexdone
    cmp cl, '0'
    jb .thexdone
    cmp cl, '9'
    jbe .thexdigit
    cmp cl, 'A'
    jb .thexdone
    cmp cl, 'F'
    jbe .thexupper
    cmp cl, 'a'
    jb .thexdone
    cmp cl, 'f'
    ja .thexdone
    sub cl, 'a'
    add cl, 10
    jmp .thexstore
.thexupper:
    sub cl, 'A'
    add cl, 10
    jmp .thexstore
.thexdigit:
    sub cl, '0'
.thexstore:
    shl rax, 4
    movzx rcx, cl
    or rax, rcx
    inc rsi
    jmp .thexloop
.thexdone:
    mov byte [rdi], T_NUM
    mov [rdi+8], rax
    mov qword [rdi+16], 0
    mov qword [rdi+24], 0
    call store_line
    add rdi, TOK_SIZE
    inc r12
    jmp .tloop
.chk7:
    cmp byte [r13], 'o'
    jne .store_ident
    cmp byte [r13+1], 'n'
    jne .store_ident
    cmp byte [r13+2], 'c'
    jne .store_ident
    cmp byte [r13+3], 'l'
    jne .store_ident
    cmp byte [r13+4], 'i'
    jne .store_ident
    cmp byte [r13+5], 'c'
    jne .store_ident
    cmp byte [r13+6], 'k'
    jne .store_ident
    mov byte [rdi], T_ONCLICK
    jmp .store_kw
store_line:
    push rax
    push rcx
    mov rax, [curline]
    mov [lines + r12*8], rax
    pop rcx
    pop rax
    ret
advance:
    add qword [tcur], TOK_SIZE
    ret
curtype:
    mov rax, [tcur]
    movzx eax, byte [rax]
    ret
interpret:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 32
    lea rax, [toks]
    mov [tcur], rax
    mov qword [retflag], 0
    mov qword [nsyms], 0
.pass1:
    call curtype
    cmp al, T_EOF
    je .pass1done
    cmp al, T_DEF
    je .dodef
    cmp al, T_FN
    je .dofndef
    call advance
    jmp .pass1
.dodef:
    call do_def
    jmp .pass1
.dofndef:
    call do_fndef
    jmp .pass1
.pass1done:
    lea rax, [toks]
    mov [tcur], rax
    xor r12, r12
.findmain:
    cmp r12, [nsyms]
    jae .nomain
    imul r13, r12, SYM_SIZE
    lea r14, [syms + r13]
    cmp qword [r14+SD_TYPE], SYM_FN
    jne .nextsym
    mov rax, [r14+SD_NAME_PTR]
    mov rcx, [r14+SD_NAME_LEN]
    cmp rcx, 4
    jne .nextsym
    cmp dword [rax], 0x6E69616D
    jne .nextsym
    mov rax, [r14+SD_BODY_START]
    imul rax, TOK_SIZE
    add rax, toks
    mov [tcur], rax
    call frame_push
    call run_block
    call frame_pop
    jmp .done
.nextsym:
    inc r12
    jmp .findmain
.nomain:
    lea r8, [msg_nomain]
    call fatal
.done:
    add rsp, 32
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
frame_push:
    sub rsp, 40
    mov rax, [nsyms]
    mov rcx, [fdepth]
    mov [fstack + rcx*8], rax
    inc qword [fdepth]
    add rsp, 40
    ret
frame_pop:
    sub rsp, 40
    dec qword [fdepth]
    mov rcx, [fdepth]
    mov rax, [fstack + rcx*8]
    mov [nsyms], rax
    add rsp, 40
    ret
do_def:
    push rbx
    push r12
    push r13
    sub rsp, 32
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov r12, [rbx+16]
    mov r13, [rbx+24]
    call advance
    call curtype
    cmp al, T_COLON
    jne .bad
    call advance
    call eval_expr
    mov r8, rax
    mov rcx, r12
    mov rdx, r13
    call sym_add_var
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    add rsp, 32
    pop r13
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
do_fndef:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 192
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov r13, [rbx+16]
    mov r14, [rbx+24]
    call advance
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    xor r12, r12
.ploop:
    call curtype
    cmp al, T_RPAREN
    je .pdone
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov rax, [rbx+16]
    mov rcx, [rbx+24]
    lea r15, [rsp+48]
    mov rax, r12
    shl rax, 4
    mov [r15 + rax], rbx
    mov rax, [rbx+16]
    mov rcx, [rbx+24]
    mov rdx, r12
    shl rdx, 4
    mov [r15 + rdx], rax
    mov [r15 + rdx + 8], rcx
    inc r12
    cmp r12, 8
    jae .bad
    call advance
    call curtype
    cmp al, T_RPAREN
    je .pdone
    cmp al, T_PLUS
    je .psep
    cmp al, T_COMMA
    je .psep
    jmp .bad
.psep:
    call advance
    jmp .ploop
.pdone:
    call advance
    call curtype
    cmp al, T_LBRACE
    jne .bad
    call advance
    mov r15, [tcur]
    mov rcx, 1
.fend:
    call curtype
    cmp al, T_EOF
    je .bad
    cmp al, T_LBRACE
    jne .fnotopen
    inc rcx
.fnotopen:
    cmp al, T_RBRACE
    jne .fnotclose
    dec rcx
    jz .fendfound
.fnotclose:
    call advance
    jmp .fend
.fendfound:
    mov rax, r15
    sub rax, toks
    cqo
    mov rcx, TOK_SIZE
    idiv rcx
    push rax
    mov rax, [tcur]
    sub rax, toks
    cqo
    mov rcx, TOK_SIZE
    idiv rcx
    mov rdx, rax
    pop rcx
    mov rax, [nsyms]
    cmp rax, MAX_SYMS
    jae .full
    imul rdi, rax, SYM_SIZE
    lea rdi, [syms + rdi]
    mov [rdi+SD_NAME_PTR], r13
    mov [rdi+SD_NAME_LEN], r14
    mov qword [rdi+SD_VALUE], 0
    mov qword [rdi+SD_TYPE], SYM_FN
    mov [rdi+SD_BODY_START], rcx
    mov [rdi+SD_BODY_END], rdx
    mov [rdi+SD_PARAM_COUNT], r12
    lea rsi, [rsp+48]
    xor rbx, rbx
.pcopy:
    cmp rbx, r12
    jge .pcopied
    mov rdx, rbx
    shl rdx, 4
    mov rax, [rsi + rdx]
    mov r8, [rsi + rdx + 8]
    mov [rdi + SD_PARAMS + rdx], rax
    mov [rdi + SD_PARAMS + rdx + 8], r8
    inc rbx
    jmp .pcopy
.pcopied:
    inc qword [nsyms]
    call advance
    add rsp, 192
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
.full:
    lea r8, [msg_full]
    call fatal
run_block:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 40
.loop:
    mov rax, [retflag]
    test rax, rax
    jnz .rdone
    call curtype
    cmp al, T_RBRACE
    je .done
    cmp al, T_EOF
    je .done
    call run_stmt
    jmp .loop
.rdone:
.done:
    call advance
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
run_stmt:
    push r12
    push r13
    sub rsp, 40
    call curtype
    cmp al, T_LET
    je .stlet
    cmp al, T_PRINT
    je .stprint
    cmp al, T_RET
    je .stret
    cmp al, T_FN
    je .stfn
    cmp al, T_DEF
    je .stdef
    cmp al, T_IF
    je .stif
    cmp al, T_SEMI
    je .stsemi
    cmp al, T_IDENT
    je .maybe_assign
    cmp al, T_WINDOW
    je .stwindow
    cmp al, T_BUTTON
    je .stbutton
    cmp al, T_LABEL
    je .stlabel
    cmp al, T_SHOW
    je .stshow
    cmp al, T_ONCLICK
    je .stonclick
    jmp .stexpr
.stlet:
    call do_let
    jmp .done
.stprint:
    call do_print
    jmp .done
.stret:
    call do_ret
    jmp .done
.stfn:
    call do_fndef
    jmp .done
.stdef:
    call do_def
    jmp .done
.stif:
    call do_if
    jmp .done
.stsemi:
    call advance
    jmp .done
.stwindow:
    call do_window
    jmp .done
.stbutton:
    call do_button
    jmp .done
.stlabel:
    call do_label
    jmp .done
.stshow:
    call do_show
    jmp .done
.stonclick:
    call do_onclick
    jmp .done
.maybe_assign:
    mov rax, [tcur]
    movzx eax, byte [rax+TOK_SIZE]
    cmp al, T_EQ
    jne .stexpr
    call do_assign
    jmp .done
.stexpr:
    call eval_expr
.done:
    add rsp, 40
    pop r13
    pop r12
    ret
do_assign:
    push rbx
    push r12
    sub rsp, 40
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call sym_find_name
    test rax, rax
    jz .bad
    mov r12, rax
    call advance
    call advance
    call eval_expr
    mov [r12+SD_VALUE], rax
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    add rsp, 40
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
do_let:
    push rbx
    push r12
    push r13
    sub rsp, 32
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov r12, [rbx+16]
    mov r13, [rbx+24]
    call advance
    call curtype
    cmp al, T_EQ
    jne .bad
    call advance
    call eval_expr
    mov r8, rax
    mov rcx, r12
    mov rdx, r13
    call sym_add_var
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    add rsp, 32
    pop r13
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
do_print:
    push rbx
    sub rsp, 32
    call advance
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov rcx, rax
    call pint
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    add rsp, 32
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
do_ret:
    push rbx
    sub rsp, 32
    call advance
    call eval_expr
    mov [retval], rax
    mov qword [retflag], 1
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    add rsp, 32
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
do_if:
    push rbx
    push r12
    push r13
    sub rsp, 32
    call advance
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov rbx, rax
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    call curtype
    cmp al, T_LBRACE
    jne .bad
    test rbx, rbx
    jnz .runtrue
    call skip_block
    jmp .after
.runtrue:
    call advance
    call run_block
.after:
    call curtype
    cmp al, T_ELSE
    jne .done
    test rbx, rbx
    jnz .elseskip
    call advance
    call curtype
    cmp al, T_IF
    je .elseif
    cmp al, T_LBRACE
    jne .bad
    call advance
    call run_block
    jmp .done
.elseif:
    call do_if
    jmp .done
.elseskip:
    call advance
    call curtype
    cmp al, T_IF
    je .skipchain
    cmp al, T_LBRACE
    jne .bad
    call skip_block
    jmp .done
.skipchain:
    call skip_if_chain
    jmp .done
.bad:
    lea r8, [msg_syntax]
    call fatal
.done:
    add rsp, 32
    pop r13
    pop r12
    pop rbx
    ret
skip_block:
    push rbx
    sub rsp, 32
    call advance
    mov rbx, 1
.bloop:
    call curtype
    cmp al, T_EOF
    je .bad
    cmp al, T_LBRACE
    jne .bnotopen
    inc rbx
.bnotopen:
    cmp al, T_RBRACE
    jne .bnotclose
    dec rbx
    jz .bdone
.bnotclose:
    call advance
    jmp .bloop
.bdone:
    call advance
    add rsp, 32
    pop rbx
    ret
.bad:
    lea r8, [msg_eoi]
    call fatal
skip_if_chain:
    push rbx
    push r12
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call skip_to_rparen
    call advance
    call skip_block
    call curtype
    cmp al, T_ELSE
    jne .done
    call advance
    call curtype
    cmp al, T_IF
    je .loopback
    cmp al, T_LBRACE
    jne .bad
    call skip_block
    jmp .done
.loopback:
    call skip_if_chain
    jmp .done
.bad:
    lea r8, [msg_syntax]
    call fatal
.done:
    add rsp, 40
    pop r12
    pop rbx
    ret
skip_to_rparen:
    push rbx
    sub rsp, 32
    mov rbx, 1
.rloop:
    call advance
    call curtype
    cmp al, T_EOF
    je .bad
    cmp al, T_LPAREN
    jne .rnotopen
    inc rbx
.rnotopen:
    cmp al, T_RPAREN
    jne .rnotclose
    dec rbx
    jz .rdone
.rnotclose:
    jmp .rloop
.rdone:
    add rsp, 32
    pop rbx
    ret
.bad:
    lea r8, [msg_eoi]
    call fatal
eval_expr:
    sub rsp, 40
    call eval_compare
    add rsp, 40
    ret
eval_compare:
    push rbx
    push rsi
    sub rsp, 40
    call eval_addsub
    mov rbx, rax
.cloop:
    call curtype
    cmp al, T_LT
    je .cgot
    cmp al, T_GT
    je .cgot
    cmp al, T_LE
    je .cgot
    cmp al, T_GE
    je .cgot
    cmp al, T_EQEQ
    je .cgot
    cmp al, T_NE
    je .cgot
    jmp .cdone
.cgot:
    mov rsi, rax
    call advance
    call eval_addsub
    mov rcx, rax
    mov rax, rbx
    cmp sil, T_EQEQ
    je .seq
    cmp sil, T_NE
    je .sne
    cmp sil, T_LT
    je .slt
    cmp sil, T_GT
    je .sgt
    cmp sil, T_LE
    je .sle
    jmp .sge
.seq:
    cmp rax, rcx
    sete al
    jmp .cfin
.sne:
    cmp rax, rcx
    setne al
    jmp .cfin
.slt:
    cmp rax, rcx
    setl al
    jmp .cfin
.sgt:
    cmp rax, rcx
    setg al
    jmp .cfin
.sle:
    cmp rax, rcx
    setle al
    jmp .cfin
.sge:
    cmp rax, rcx
    setge al
.cfin:
    movzx rax, al
    mov rbx, rax
    jmp .cloop
.cdone:
    mov rax, rbx
    add rsp, 40
    pop rsi
    pop rbx
    ret
eval_addsub:
    push rbx
    push rsi
    sub rsp, 40
    call eval_muldiv
    mov rbx, rax
.aloop:
    call curtype
    cmp al, T_PLUS
    je .apls
    cmp al, T_MINUS
    je .aop
    jmp .adone
.apls:
    mov rcx, [argmode]
    test rcx, rcx
    jnz .adone
    jmp .aop
.aop:
    mov rsi, rax
    call advance
    call eval_muldiv
    cmp sil, T_PLUS
    jne .asub
    add rbx, rax
    jmp .aloop
.asub:
    sub rbx, rax
    jmp .aloop
.adone:
    mov rax, rbx
    add rsp, 40
    pop rsi
    pop rbx
    ret
eval_muldiv:
    push rbx
    push rsi
    sub rsp, 40
    call eval_primary
    mov rbx, rax
.mloop:
    call curtype
    cmp al, T_STAR
    je .mop
    cmp al, T_SLASH
    je .mop
    jmp .mdone
.mop:
    mov rsi, rax
    call advance
    call eval_primary
    mov rcx, rax
    cmp sil, T_STAR
    jne .mdiv
    mov rax, rbx
    imul rax, rcx
    mov rbx, rax
    jmp .mloop
.mdiv:
    test rcx, rcx
    jz .zerodiv
    mov rax, rbx
    cqo
    idiv rcx
    mov rbx, rax
    jmp .mloop
.mdone:
    mov rax, rbx
    add rsp, 40
    pop rsi
    pop rbx
    ret
.zerodiv:
    lea r8, [msg_divzero]
    call fatal
eval_primary:
    push rbx
    push r12
    push r13
    sub rsp, 32
    call curtype
    cmp al, T_NUM
    je .pnum
    cmp al, T_IDENT
    je .pident
    cmp al, T_LPAREN
    je .pparen
    cmp al, T_MINUS
    je .pneg
    jmp .bad
.pnum:
    mov rax, [tcur]
    mov rax, [rax+8]
    call advance
    jmp .done
.pident:
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call advance
    call sym_find_name
    test rax, rax
    jz .undef
    mov r13, rax
    call curtype
    cmp al, T_LPAREN
    jne .pvarval
    mov rcx, r13
    call eval_call
    jmp .done
.pvarval:
    mov rax, [r13+SD_VALUE]
    jmp .done
.pparen:
    mov rbx, [argmode]
    mov qword [argmode], 0
    call advance
    call eval_expr
    mov [argmode], rbx
    push rax
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    pop rax
    jmp .done
.pneg:
    call advance
    call eval_primary
    neg rax
    jmp .done
.bad:
    lea r8, [msg_syntax]
    call fatal
.undef:
    lea r8, [msg_undef]
    call fatal
.done:
    add rsp, 32
    pop r13
    pop r12
    pop rbx
    ret
eval_call:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 160
    mov rax, [argmode]
    mov [rsp+144], rax
    mov r12, rcx
    call advance
    xor rbx, rbx
    call curtype
    cmp al, T_RPAREN
    je .argsdone
.argloop:
    mov qword [argmode], 1
    call eval_expr
    mov [rsp + 48 + rbx*8], rax
    mov qword [argmode], 0
    inc rbx
    cmp rbx, 8
    jae .argsdone
    call curtype
    cmp al, T_PLUS
    je .amore
    cmp al, T_COMMA
    je .amore
    jmp .argsdone
.amore:
    call advance
    jmp .argloop
.argsdone:
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    mov rax, [tcur]
    mov [rsp+152], rax
    mov rax, [r12+SD_PARAM_COUNT]
    cmp rax, rbx
    jne .wargs
    call frame_push
    lea r15, [r12 + SD_PARAMS]
    xor r14, r14
.bind:
    cmp r14, [r12+SD_PARAM_COUNT]
    jge .bound
    mov rax, r14
    shl rax, 4
    mov rcx, [r15 + rax]
    mov rdx, [r15 + rax + 8]
    mov r8, [rsp + 48 + r14*8]
    call sym_add_var
    inc r14
    jmp .bind
.bound:
    mov rax, [retflag]
    mov [rsp+136], rax
    mov rax, [r12+SD_BODY_START]
    imul rax, TOK_SIZE
    add rax, toks
    mov [tcur], rax
    mov qword [retflag], 0
    mov qword [retval], 0
    call run_block
    call frame_pop
    mov rax, [rsp+136]
    mov [retflag], rax
    mov rax, [rsp+152]
    mov [tcur], rax
    mov rax, [rsp+144]
    mov [argmode], rax
    mov rax, [retval]
    jmp .done
.bad:
    lea r8, [msg_syntax]
    call fatal
.wargs:
    lea r8, [msg_wrongargs]
    call fatal
.done:
    add rsp, 160
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
sym_find_name:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 48
    mov rbx, rcx
    mov r13, rdx
    mov rax, [nsyms]
    test rax, rax
    jz .notfound
    lea r12, [rax-1]
.floop:
    imul r14, r12, SYM_SIZE
    lea r14, [syms + r14]
    mov rax, [r14+SD_NAME_LEN]
    cmp rax, r13
    jne .fnext
    mov rsi, rbx
    mov rdi, [r14+SD_NAME_PTR]
    mov rcx, r13
    repe cmpsb
    jne .fnext
    mov rax, r14
    jmp .done
.fnext:
    test r12, r12
    jz .notfound
    dec r12
    jmp .floop
.notfound:
    xor eax, eax
.done:
    add rsp, 48
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
sym_add_var:
    push rbx
    push r12
    sub rsp, 40
    mov rax, [nsyms]
    cmp rax, MAX_SYMS
    jae .full
    imul r12, rax, SYM_SIZE
    lea r12, [syms + r12]
    mov [r12+SD_NAME_PTR], rcx
    mov [r12+SD_NAME_LEN], rdx
    mov [r12+SD_VALUE], r8
    mov qword [r12+SD_TYPE], SYM_VAR
    inc qword [nsyms]
    mov rax, r12
    jmp .done
.full:
    xor eax, eax
.done:
    add rsp, 40
    pop r12
    pop rbx
    ret
find_widget_by_name:
    push rbx
    push rsi
    push rdi
    push r12
    push r13
    push r14
    sub rsp, 40
    mov rbx, rcx
    mov r13, rdx
    xor r12, r12
.fwloop:
    cmp r12, [nwidgets]
    jae .fwnotfound
    imul r14, r12, WIDGET_SIZE
    lea r14, [widgets + r14]
    mov rax, [r14+WD_NAME_LEN]
    cmp rax, r13
    jne .fwnext
    mov rsi, rbx
    mov rdi, [r14+WD_NAME_PTR]
    mov rcx, r13
    repe cmpsb
    jne .fwnext
    mov rax, r14
    jmp .fwdone
.fwnext:
    inc r12
    jmp .fwloop
.fwnotfound:
    xor eax, eax
.fwdone:
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rdi
    pop rsi
    pop rbx
    ret
do_window:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 40
    call advance
    mov rax, [nwidgets]
    cmp rax, MAX_WIDGETS
    jae .wfull
    imul rbx, rax, WIDGET_SIZE
    lea rbx, [widgets + rbx]
    mov qword [rbx+WD_TYPE], 0
    mov qword [rbx+WD_COLOR], 0x00FFFFFF
    mov qword [rbx+WD_RADIUS], 0
    mov qword [rbx+WD_CB_START], 0
    mov qword [rbx+WD_CB_END], 0
    mov qword [rbx+WD_NAME_PTR], 0
    mov qword [rbx+WD_NAME_LEN], 0
    mov [rsp+32], rbx
    call curtype
    cmp al, T_STRING
    jne .wbad
    mov r12, [tcur]
    mov rax, [r12+16]
    mov [rbx+WD_TEXT_PTR], rax
    mov rax, [r12+24]
    mov [rbx+WD_TEXT_LEN], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .wbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_W], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .wbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_H], rax
    call advance
.wproloop:
    call curtype
    cmp al, T_SEMI
    je .wdone
    cmp al, T_IDENT
    jne .wdone
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    cmp rdx, 2
    jne .wskipprop
    cmp byte [rcx], 'b'
    jne .wskipprop
    cmp byte [rcx+1], 'g'
    jne .wskipprop
    call advance
    call curtype
    cmp al, T_EQ
    jne .wbad
    call advance
    call curtype
    cmp al, T_NUM
    jne .wbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_COLOR], rax
    call advance
    jmp .wproloop
.wskipprop:
    call advance
    call curtype
    cmp al, T_EQ
    jne .wproloop
    call advance
    call eval_expr
    jmp .wproloop
.wdone:
    call curtype
    cmp al, T_SEMI
    jne .wbad
    call advance
    inc qword [nwidgets]
    add rsp, 40
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.wbad:
    lea r8, [msg_syntax]
    call fatal
.wfull:
    lea r8, [msg_full]
    call fatal
do_button:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 40
    call advance
    mov rax, [nwidgets]
    cmp rax, MAX_WIDGETS
    jae .bfull
    imul rbx, rax, WIDGET_SIZE
    lea rbx, [widgets + rbx]
    mov qword [rbx+WD_TYPE], 1
    mov qword [rbx+WD_COLOR], 0x00CC4422
    mov qword [rbx+WD_RADIUS], 8
    mov qword [rbx+WD_CB_START], 0
    mov qword [rbx+WD_CB_END], 0
    mov [rsp+32], rbx
    call curtype
    cmp al, T_IDENT
    jne .bbad
    mov r12, [tcur]
    mov rax, [r12+16]
    mov [rbx+WD_NAME_PTR], rax
    mov rax, [r12+24]
    mov [rbx+WD_NAME_LEN], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .bbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_X], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .bbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_Y], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .bbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_W], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .bbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_H], rax
    call advance
    call curtype
    cmp al, T_STRING
    jne .bbad
    mov r12, [tcur]
    mov rax, [r12+16]
    mov [rbx+WD_TEXT_PTR], rax
    mov rax, [r12+24]
    mov [rbx+WD_TEXT_LEN], rax
    call advance
.bproloop:
    call curtype
    cmp al, T_SEMI
    je .bdone
    cmp al, T_IDENT
    jne .bdone
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    cmp rdx, 6
    jne .bchkcol
    cmp byte [rcx], 'r'
    jne .bchkcol
    cmp byte [rcx+1], 'a'
    jne .bchkcol
    cmp byte [rcx+2], 'd'
    jne .bchkcol
    cmp byte [rcx+3], 'i'
    jne .bchkcol
    cmp byte [rcx+4], 'u'
    jne .bchkcol
    cmp byte [rcx+5], 's'
    jne .bchkcol
    call advance
    call curtype
    cmp al, T_EQ
    jne .bbad
    call advance
    call curtype
    cmp al, T_NUM
    jne .bbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_RADIUS], rax
    call advance
    jmp .bproloop
.bchkcol:
    cmp rdx, 5
    jne .bskipprop
    cmp byte [rcx], 'c'
    jne .bskipprop
    cmp byte [rcx+1], 'o'
    jne .bskipprop
    cmp byte [rcx+2], 'l'
    jne .bskipprop
    cmp byte [rcx+3], 'o'
    jne .bskipprop
    cmp byte [rcx+4], 'r'
    jne .bskipprop
    call advance
    call curtype
    cmp al, T_EQ
    jne .bbad
    call advance
    call curtype
    cmp al, T_NUM
    jne .bbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_COLOR], rax
    call advance
    jmp .bproloop
.bskipprop:
    call advance
    call curtype
    cmp al, T_EQ
    jne .bproloop
    call advance
    call eval_expr
    jmp .bproloop
.bdone:
    call curtype
    cmp al, T_SEMI
    jne .bbad
    call advance
    inc qword [nwidgets]
    add rsp, 40
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.bbad:
    lea r8, [msg_syntax]
    call fatal
.bfull:
    lea r8, [msg_full]
    call fatal
do_label:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 40
    call advance
    mov rax, [nwidgets]
    cmp rax, MAX_WIDGETS
    jae .lfull
    imul rbx, rax, WIDGET_SIZE
    lea rbx, [widgets + rbx]
    mov qword [rbx+WD_TYPE], 2
    mov qword [rbx+WD_COLOR], 0x00000000
    mov qword [rbx+WD_RADIUS], 0
    mov qword [rbx+WD_CB_START], 0
    mov qword [rbx+WD_CB_END], 0
    mov [rsp+32], rbx
    call curtype
    cmp al, T_IDENT
    jne .lbad
    mov r12, [tcur]
    mov rax, [r12+16]
    mov [rbx+WD_NAME_PTR], rax
    mov rax, [r12+24]
    mov [rbx+WD_NAME_LEN], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .lbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_X], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .lbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_Y], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .lbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_W], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .lbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_H], rax
    call advance
    call curtype
    cmp al, T_STRING
    jne .lbad
    mov r12, [tcur]
    mov rax, [r12+16]
    mov [rbx+WD_TEXT_PTR], rax
    mov rax, [r12+24]
    mov [rbx+WD_TEXT_LEN], rax
    call advance
.lproloop:
    call curtype
    cmp al, T_SEMI
    je .ldone
    cmp al, T_IDENT
    jne .ldone
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    cmp rdx, 5
    jne .lskipprop
    cmp byte [rcx], 'c'
    jne .lskipprop
    cmp byte [rcx+1], 'o'
    jne .lskipprop
    cmp byte [rcx+2], 'l'
    jne .lskipprop
    cmp byte [rcx+3], 'o'
    jne .lskipprop
    cmp byte [rcx+4], 'r'
    jne .lskipprop
    call advance
    call curtype
    cmp al, T_EQ
    jne .lbad
    call advance
    call curtype
    cmp al, T_NUM
    jne .lbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_COLOR], rax
    call advance
    jmp .lproloop
.lskipprop:
    call advance
    call curtype
    cmp al, T_EQ
    jne .lproloop
    call advance
    call eval_expr
    jmp .lproloop
.ldone:
    call curtype
    cmp al, T_SEMI
    jne .lbad
    call advance
    inc qword [nwidgets]
    add rsp, 40
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.lbad:
    lea r8, [msg_syntax]
    call fatal
.lfull:
    lea r8, [msg_full]
    call fatal
do_onclick:
    push rbx
    push r12
    push r13
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_IDENT
    jne .obad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .oundef
    mov r12, rax
    call advance
    call curtype
    cmp al, T_LBRACE
    jne .obad
    call advance
    mov rax, [tcur]
    sub rax, toks
    cqo
    mov rcx, TOK_SIZE
    idiv rcx
    mov [r12+WD_CB_START], rax
    mov rcx, 1
.ofindend:
    call curtype
    cmp al, T_EOF
    jne .onotEOF
    lea r8, [msg_eoi]
    call fatal
.onotEOF:
    cmp al, T_LBRACE
    jne .onotopen
    inc rcx
.onotopen:
    cmp al, T_RBRACE
    jne .onotclose
    dec rcx
    jz .ofound
.onotclose:
    call advance
    jmp .ofindend
.ofound:
    mov rax, [tcur]
    sub rax, toks
    cqo
    mov rcx, TOK_SIZE
    idiv rcx
    mov [r12+WD_CB_END], rax
    call advance
    call curtype
    cmp al, T_SEMI
    jne .obad
    call advance
    add rsp, 40
    pop r13
    pop r12
    pop rbx
    ret
.obad:
    lea r8, [msg_syntax]
    call fatal
.oundef:
    lea r8, [msg_undef]
    call fatal
do_show:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 112
    call advance
    call curtype
    cmp al, T_SEMI
    jne .sbad
    call advance
    xor r12, r12
.sfindwin:
    cmp r12, [nwidgets]
    jae .snoin
    imul rbx, r12, WIDGET_SIZE
    lea rbx, [widgets + rbx]
    cmp qword [rbx+WD_TYPE], 0
    je .swinok
    inc r12
    jmp .sfindwin
.swinok:
    mov [rsp+96], rbx
    jmp .shavewin
.snoin:
    lea rbx, [widgets]
    mov qword [rbx+WD_TYPE], 0
    mov qword [rbx+WD_X], 0
    mov qword [rbx+WD_Y], 0
    mov qword [rbx+WD_W], 800
    mov qword [rbx+WD_H], 600
    mov qword [rbx+WD_TEXT_PTR], 0
    mov qword [rbx+WD_TEXT_LEN], 0
    mov qword [rbx+WD_COLOR], 0x00F0F0F0
    mov qword [rbx+WD_RADIUS], 0
    mov qword [rbx+WD_CB_START], 0
    mov qword [rbx+WD_CB_END], 0
    mov qword [nwidgets], 1
    mov [rsp+96], rbx
.shavewin:
    mov r15, [rsp+96]
    xor eax, eax
    lea rdi, [wndclass]
    mov ecx, 10
    rep stosq
    mov dword [wndclass], 80
    mov dword [wndclass+4], (CS_HREDRAW | CS_VREDRAW)
    lea rax, [wndproc]
    mov [wndclass+8], rax
    xor ecx, ecx
    call GetModuleHandleA
    mov [wndclass+24], rax
    xor ecx, ecx
    mov edx, IDC_ARROW
    call LoadCursorA
    mov [wndclass+40], rax
    mov qword [wndclass+48], 0
    lea rax, [wndclass_name]
    mov [wndclass+64], rax
    lea rcx, [wndclass]
    call RegisterClassExA
    test eax, eax
    jz .sregfail
    xor ecx, ecx
    lea rdx, [wndclass_name]
    mov r8, [r15+WD_TEXT_PTR]
    test r8, r8
    jnz .shastitle
    lea r8, [default_title]
.shastitle:
    mov r9d, WS_OVERLAPPEDWINDOW
    mov rax, [r15+WD_X]
    mov [rsp+32], rax
    mov rax, [r15+WD_Y]
    mov [rsp+40], rax
    mov rax, [r15+WD_W]
    mov [rsp+48], rax
    mov rax, [r15+WD_H]
    mov [rsp+56], rax
    mov qword [rsp+64], 0
    mov qword [rsp+72], 0
    mov rax, [wndclass+24]
    mov [rsp+80], rax
    mov qword [rsp+88], 0
    call CreateWindowExA
    test rax, rax
    jz .screatefail
    mov [hwnd_main], rax
    mov rcx, rax
    mov edx, SW_SHOW
    call ShowWindow
    mov rcx, [hwnd_main]
    call UpdateWindow
.smsgloop:
    lea rcx, [msgbuf]
    xor edx, edx
    xor r8d, r8d
    xor r9d, r9d
    call GetMessageA
    test eax, eax
    jz .smsgdone
    lea rcx, [msgbuf]
    call TranslateMessage
    lea rcx, [msgbuf]
    call DispatchMessageA
    jmp .smsgloop
.smsgdone:
    add rsp, 112
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.sbad:
    lea r8, [msg_syntax]
    call fatal
.sregfail:
    lea r8, [msg_syntax]
    call fatal
.screatefail:
    lea r8, [msg_syntax]
    call fatal
wndproc:
    push rbx
    push rsi
    push r12
    push r13
    push r14
    push r15
    push rbp
    sub rsp, 48
    mov rbx, rcx
    mov esi, edx
    mov r13, r8
    mov r14, r9
    cmp esi, WM_PAINT
    je .wpaint
    cmp esi, WM_LBUTTONDOWN
    je .wclick
    cmp esi, WM_DESTROY
    je .wdestroy
    mov rcx, rbx
    mov rdx, rsi
    mov r8, r13
    mov r9, r14
    call DefWindowProcA
    jmp .wdone
.wpaint:
    mov rcx, rbx
    lea rdx, [paintstruct]
    call BeginPaint
    mov r12, rax
    mov rcx, rbx
    lea rdx, [clientrect]
    call GetClientRect
    xor ebp, ebp
.wpfindbg:
    cmp rbp, [nwidgets]
    jae .wpnobg
    imul r15, rbp, WIDGET_SIZE
    lea r15, [widgets + r15]
    cmp qword [r15+WD_TYPE], 0
    je .wpgotbg
    inc rbp
    jmp .wpfindbg
.wpgotbg:
    mov rbp, [r15+WD_COLOR]
    jmp .wphavbg
.wpnobg:
    mov rbp, 0x00F0F0F0
.wphavbg:
    mov rcx, rbp
    call CreateSolidBrush
    mov r15, rax
    mov rcx, r12
    lea rdx, [clientrect]
    mov r8, r15
    call FillRect
    mov rcx, r15
    call DeleteObject
    xor ebp, ebp
.wpdrawloop:
    cmp rbp, [nwidgets]
    jae .wpdrawdone
    imul r15, rbp, WIDGET_SIZE
    lea r15, [widgets + r15]
    cmp qword [r15+WD_TYPE], 1
    je .wpdrawbtn
    cmp qword [r15+WD_TYPE], 2
    je .wpdrawlbl
    jmp .wpdrawnext
.wpdrawbtn:
    mov rax, [r15+WD_RADIUS]
    test rax, rax
    jz .wpdrawrect
    shl rax, 1
    mov [rsp+32], rax
    mov [rsp+40], rax
    mov rcx, [r15+WD_X]
    mov rdx, [r15+WD_Y]
    mov r8, [r15+WD_X]
    add r8, [r15+WD_W]
    mov r9, [r15+WD_Y]
    add r9, [r15+WD_H]
    call CreateRoundRectRgn
    mov r14, rax
    mov rcx, [r15+WD_COLOR]
    call CreateSolidBrush
    mov r13, rax
    mov rcx, r12
    mov rdx, r14
    mov r8, r13
    call FillRgn
    mov rcx, r14
    call DeleteObject
    mov rcx, r13
    call DeleteObject
    jmp .wpdrawbtntxt
.wpdrawrect:
    mov rcx, [r15+WD_COLOR]
    call CreateSolidBrush
    mov r13, rax
    mov eax, [r15+WD_X]
    mov [drawrect], eax
    mov eax, [r15+WD_Y]
    mov [drawrect+4], eax
    mov eax, [r15+WD_X]
    add eax, [r15+WD_W]
    mov [drawrect+8], eax
    mov eax, [r15+WD_Y]
    add eax, [r15+WD_H]
    mov [drawrect+12], eax
    mov rcx, r12
    lea rdx, [drawrect]
    mov r8, r13
    call FillRect
    mov rcx, r13
    call DeleteObject
.wpdrawbtntxt:
    mov rcx, r12
    mov edx, TRANSPARENT
    call SetBkMode
    mov rcx, r12
    mov edx, 0x00FFFFFF
    call SetTextColor
    mov eax, [r15+WD_X]
    mov [drawrect], eax
    mov eax, [r15+WD_Y]
    mov [drawrect+4], eax
    mov eax, [r15+WD_X]
    add eax, [r15+WD_W]
    mov [drawrect+8], eax
    mov eax, [r15+WD_Y]
    add eax, [r15+WD_H]
    mov [drawrect+12], eax
    mov rcx, r12
    mov rdx, [r15+WD_TEXT_PTR]
    test rdx, rdx
    jnz .whastxt1
    lea rdx, [default_title]
.whastxt1:
    mov r8, -1
    lea r9, [drawrect]
    mov dword [rsp+32], (DT_CENTER | DT_VCENTER | DT_SINGLELINE)
    call DrawTextA
    jmp .wpdrawnext
.wpdrawlbl:
    mov rcx, r12
    mov edx, TRANSPARENT
    call SetBkMode
    mov rcx, r12
    mov rdx, [r15+WD_COLOR]
    call SetTextColor
    mov eax, [r15+WD_X]
    mov [drawrect], eax
    mov eax, [r15+WD_Y]
    mov [drawrect+4], eax
    mov eax, [r15+WD_X]
    add eax, [r15+WD_W]
    mov [drawrect+8], eax
    mov eax, [r15+WD_Y]
    add eax, [r15+WD_H]
    mov [drawrect+12], eax
    mov rcx, r12
    mov rdx, [r15+WD_TEXT_PTR]
    test rdx, rdx
    jnz .whastxt2
    lea rdx, [default_title]
.whastxt2:
    mov r8, -1
    lea r9, [drawrect]
    mov dword [rsp+32], 0
    call DrawTextA
.wpdrawnext:
    inc rbp
    jmp .wpdrawloop
.wpdrawdone:
    mov rcx, rbx
    lea rdx, [paintstruct]
    call EndPaint
    xor eax, eax
    jmp .wdone
.wclick:
    movzx eax, r14w
    mov [rsp+0], rax
    shr r14, 16
    movzx eax, r14w
    mov [rsp+8], rax
    xor rbp, rbp
.wpclkloop:
    cmp rbp, [nwidgets]
    jae .wpclkdone
    imul r15, rbp, WIDGET_SIZE
    lea r15, [widgets + r15]
    cmp qword [r15+WD_TYPE], 1
    jne .wpclknext
    mov rax, [rsp+0]
    cmp rax, [r15+WD_X]
    jl .wpclknext
    mov rcx, [r15+WD_X]
    add rcx, [r15+WD_W]
    cmp rax, rcx
    jge .wpclknext
    mov rax, [rsp+8]
    cmp rax, [r15+WD_Y]
    jl .wpclknext
    mov rcx, [r15+WD_Y]
    add rcx, [r15+WD_H]
    cmp rax, rcx
    jge .wpclknext
    mov rax, [r15+WD_CB_START]
    test rax, rax
    jz .wpclknext
    push rbp
    push r15
    call frame_push
    imul rax, rax, TOK_SIZE
    add rax, toks
    mov [tcur], rax
    mov rax, [retflag]
    push rax
    mov qword [retflag], 0
    mov qword [retval], 0
    call run_block
    pop rax
    mov [retflag], rax
    call frame_pop
    pop r15
    pop rbp
.wpclknext:
    inc rbp
    jmp .wpclkloop
.wpclkdone:
    xor eax, eax
    jmp .wdone
.wdestroy:
    xor ecx, ecx
    call PostQuitMessage
    xor eax, eax
.wdone:
    add rsp, 48
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rsi
    pop rbx
    ret
