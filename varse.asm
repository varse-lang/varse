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
%define T_SETTEXT 34
%define T_SETNUM 35
%define T_SETCOLOR 36
%define T_SETHIDE 37
%define T_NETTEXT 38
%define T_NETPRINT 39
%define T_NETSAVE 40
%define T_HTTPGET 41
%define T_PRINTS 42
%define T_INPUT 43
%define T_PANEL 44
%define T_HTMLSTRIP 45
%define T_HTMLTITLE 46
%define T_HTMLBLOCK 47
%define T_RESETUI 48
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
%define WIDGET_SIZE 4352
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
%define WD_HIDDEN 104
%define WD_TBUF 128
%define WD_TBUF_MAX 4096
%define WM_PAINT 0x000F
%define WM_LBUTTONDOWN 0x0201
%define WM_DESTROY 0x0002
%define WM_CHAR 0x0102
%define WS_OVERLAPPEDWINDOW 0x00CF0000
%define SW_SHOW 5
%define COLOR_WINDOW 5
%define IDC_ARROW 32512
%define DT_LEFT 0x00000000
%define DT_CENTER 0x00000001
%define DT_VCENTER 0x00000004
%define DT_SINGLELINE 0x00000020
%define DT_WORDBREAK 0x00000010
%define DT_NOPREFIX 0x00008000
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
    agent_name db "Varse/1.0", 0
    bi_netstatus db "netstatus", 0
    bi_netlength db "netlength", 0
    bi_cssbg db "cssbg", 0
    bi_cssfg db "cssfg", 0
    bi_htmlblocks db "htmlblocks", 0
    bi_blocklen db "blocklen", 0
    bi_blocktag db "blocktag", 0
    tag_script db "script", 0
    tag_style db "style", 0
    tag_head db "head", 0
    tag_noscript db "noscript", 0
    tag_svg db "svg", 0
    tag_iframe db "iframe", 0
    tag_template db "template", 0
    blktab:
    db "html",0
    db 0
    db "body",0
    db 0
    db "div",0
    db 0
    db "p",0
    db 0
    db "h1",0
    db 1
    db "h2",0
    db 2
    db "h3",0
    db 3
    db "h4",0
    db 4
    db "h5",0
    db 5
    db "h6",0
    db 6
    db "li",0
    db 7
    db "ul",0
    db 0
    db "ol",0
    db 0
    db "pre",0
    db 8
    db "blockquote",0
    db 9
    db "figure",0
    db 0
    db "figcaption",0
    db 0
    db "table",0
    db 10
    db "tr",0
    db 10
    db "td",0
    db 10
    db "th",0
    db 10
    db "thead",0
    db 10
    db "tbody",0
    db 10
    db "header",0
    db 0
    db "footer",0
    db 0
    db "main",0
    db 0
    db "section",0
    db 0
    db "article",0
    db 0
    db "aside",0
    db 0
    db "nav",0
    db 0
    db "form",0
    db 0
    db "fieldset",0
    db 0
    db "hr",0
    db 0
    db "br",0
    db 11
    db 0
    needle_title db "<title", 0
    needle_script db "</script", 0
    needle_style db "</style", 0
    needle_comment db "-->", 0
    needle_bg1 db "background-color:", 0
    needle_bg2 db "background:", 0
    needle_fg db "color:", 0
    empty_str db 0
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
    netbuf resb 262144
    netlen resq 1
    netstatus resq 1
    netbytes resq 1
    qlen resd 1
    fmtscratch resb 64
    hwnd_main resq 1
    paintstruct resb 72
    clientrect resb 16
    drawrect resb 16
    wndclass resb 80
    msgbuf resb 256
    cb_idx resq 1
    cb_tcur resq 1
    focus_wid resq 1
    focus_fresh resq 1
    tagtmp resb 16
    blksrc resq 1
    blklen resq 1
    blkspace resq 1
    blkcount resq 1
    blkopen resq 1
    blkcurtag resq 1
    blkclosing resq 1
    blkmode resq 1
    blkidx resq 1
    blkdest resq 1
    blkres resq 1
    blktmp resb 16
    blkneedle resb 16
    blkbuf resb 4096
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
extern InvalidateRect
extern InternetOpenA
extern InternetOpenUrlA
extern InternetReadFile
extern InternetCloseHandle
extern HttpQueryInfoA
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
    movzx r8d, byte [rdx]
    cmp al, r8b
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
    sub rsp, 56
    xor ecx, ecx
    lea rdx, [selfpath]
    mov r8d, 1024
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
    add rsp, 56
    ret
.eclose:
    mov rcx, [hfile]
    call CloseHandle
.enone:
    xor eax, eax
    add rsp, 56
    ret
build_exe:
    push rbx
    push rsi
    push rdi
    sub rsp, 32
    mov rbx, rcx
    mov rsi, rdx
    xor ecx, ecx
    lea rdx, [selfpath]
    mov r8d, 1024
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
    sub rsp, 48
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
    add rsp, 48
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
    cmp rcx, 8
    je .chk8
    cmp rcx, 9
    je .chk9
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
    jne .chk5panel
    cmp byte [r13+2], 'i'
    jne .store_ident
    cmp byte [r13+3], 'n'
    jne .store_ident
    cmp byte [r13+4], 't'
    jne .store_ident
    mov byte [rdi], T_PRINT
    jmp .store_kw
.chk5panel:
    cmp byte [r13+1], 'a'
    jne .store_ident
    cmp byte [r13+2], 'n'
    jne .store_ident
    cmp byte [r13+3], 'e'
    jne .store_ident
    cmp byte [r13+4], 'l'
    jne .store_ident
    mov byte [rdi], T_PANEL
    jmp .store_kw
.chk5label:
    cmp byte [r13], 'l'
    jne .chk5input
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
.chk5input:
    cmp byte [r13], 'i'
    jne .store_ident
    cmp byte [r13+1], 'n'
    jne .store_ident
    cmp byte [r13+2], 'p'
    jne .store_ident
    cmp byte [r13+3], 'u'
    jne .store_ident
    cmp byte [r13+4], 't'
    jne .store_ident
    mov byte [rdi], T_INPUT
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
    jne .chk6setnum
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
.chk6setnum:
    cmp byte [r13], 's'
    jne .chk6prints
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 't'
    jne .store_ident
    cmp byte [r13+3], 'n'
    jne .store_ident
    cmp byte [r13+4], 'u'
    jne .store_ident
    cmp byte [r13+5], 'm'
    jne .store_ident
    mov byte [rdi], T_SETNUM
    jmp .store_kw
.chk6prints:
    cmp byte [r13], 'p'
    jne .store_ident
    cmp byte [r13+1], 'r'
    jne .store_ident
    cmp byte [r13+2], 'i'
    jne .store_ident
    cmp byte [r13+3], 'n'
    jne .store_ident
    cmp byte [r13+4], 't'
    jne .store_ident
    cmp byte [r13+5], 's'
    jne .store_ident
    mov byte [rdi], T_PRINTS
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
    mov rbx, rsi
.tstrloop:
    movzx eax, byte [rsi]
    test al, al
    jz .tstrdone
    cmp al, '"'
    je .tstrdone
    cmp al, 10
    jne .tstresc
    inc qword [curline]
    jmp .tstrcopy
.tstresc:
    cmp al, '\'
    jne .tstrcopy
    movzx ecx, byte [rsi+1]
    test cl, cl
    jz .tstrcopy
    cmp cl, 'n'
    je .tstr_n
    cmp cl, 't'
    je .tstr_t
    cmp cl, 'r'
    je .tstr_r
    cmp cl, '\'
    je .tstr_bs
    cmp cl, '"'
    je .tstr_q
    jmp .tstrcopy
.tstr_n:
    mov al, 10
    jmp .tstr_emit
.tstr_t:
    mov al, 9
    jmp .tstr_emit
.tstr_r:
    mov al, 13
    jmp .tstr_emit
.tstr_bs:
    mov al, '\'
    jmp .tstr_emit
.tstr_q:
    mov al, '"'
.tstr_emit:
    mov [rbx], al
    inc rbx
    add rsi, 2
    jmp .tstrloop
.tstrcopy:
    mov [rbx], al
    inc rbx
    inc rsi
    jmp .tstrloop
.tstrdone:
    mov byte [rdi], T_STRING
    mov qword [rdi+8], 0
    mov [rdi+16], r13
    mov rcx, rbx
    sub rcx, r13
    mov [rdi+24], rcx
    cmp byte [rsi], '"'
    jne .tstrbad
    mov byte [rbx], 0
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
    jne .chk7settext
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
.chk7settext:
    cmp byte [r13], 's'
    jne .chk7httpget
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 't'
    jne .store_ident
    cmp byte [r13+3], 't'
    jne .chk7sethide
    cmp byte [r13+4], 'e'
    jne .store_ident
    cmp byte [r13+5], 'x'
    jne .store_ident
    cmp byte [r13+6], 't'
    jne .store_ident
    mov byte [rdi], T_SETTEXT
    jmp .store_kw
.chk7sethide:
    cmp byte [r13+3], 'h'
    jne .store_ident
    cmp byte [r13+4], 'i'
    jne .store_ident
    cmp byte [r13+5], 'd'
    jne .store_ident
    cmp byte [r13+6], 'e'
    jne .store_ident
    mov byte [rdi], T_SETHIDE
    jmp .store_kw
.chk7httpget:
    cmp byte [r13], 'h'
    jne .chk7net
    cmp byte [r13+1], 't'
    jne .store_ident
    cmp byte [r13+2], 't'
    jne .store_ident
    cmp byte [r13+3], 'p'
    jne .store_ident
    cmp byte [r13+4], 'g'
    jne .store_ident
    cmp byte [r13+5], 'e'
    jne .store_ident
    cmp byte [r13+6], 't'
    jne .store_ident
    mov byte [rdi], T_HTTPGET
    jmp .store_kw
.chk7net:
    cmp byte [r13], 'n'
    jne .chk7reset
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 't'
    jne .store_ident
    cmp byte [r13+3], 's'
    jne .chk7nettext
    cmp byte [r13+4], 'a'
    jne .store_ident
    cmp byte [r13+5], 'v'
    jne .store_ident
    cmp byte [r13+6], 'e'
    jne .store_ident
    mov byte [rdi], T_NETSAVE
    jmp .store_kw
.chk7nettext:
    cmp byte [r13+3], 't'
    jne .store_ident
    cmp byte [r13+4], 'e'
    jne .store_ident
    cmp byte [r13+5], 'x'
    jne .store_ident
    cmp byte [r13+6], 't'
    jne .store_ident
    mov byte [rdi], T_NETTEXT
    jmp .store_kw
.chk7reset:
    cmp byte [r13], 'r'
    jne .store_ident
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 's'
    jne .store_ident
    cmp byte [r13+3], 'e'
    jne .store_ident
    cmp byte [r13+4], 't'
    jne .store_ident
    cmp byte [r13+5], 'u'
    jne .store_ident
    cmp byte [r13+6], 'i'
    jne .store_ident
    mov byte [rdi], T_RESETUI
    jmp .store_kw
.chk8:
    cmp byte [r13], 's'
    jne .chk8netprint
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 't'
    jne .store_ident
    cmp byte [r13+3], 'c'
    jne .store_ident
    cmp byte [r13+4], 'o'
    jne .store_ident
    cmp byte [r13+5], 'l'
    jne .store_ident
    cmp byte [r13+6], 'o'
    jne .store_ident
    cmp byte [r13+7], 'r'
    jne .store_ident
    mov byte [rdi], T_SETCOLOR
    jmp .store_kw
.chk8netprint:
    cmp byte [r13], 'n'
    jne .store_ident
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 't'
    jne .store_ident
    cmp byte [r13+3], 'p'
    jne .store_ident
    cmp byte [r13+4], 'r'
    jne .store_ident
    cmp byte [r13+5], 'i'
    jne .store_ident
    cmp byte [r13+6], 'n'
    jne .store_ident
    cmp byte [r13+7], 't'
    jne .store_ident
    mov byte [rdi], T_NETPRINT
    jmp .store_kw
.chk9:
    cmp byte [r13], 'h'
    jne .store_ident
    cmp byte [r13+1], 't'
    jne .store_ident
    cmp byte [r13+2], 'm'
    jne .store_ident
    cmp byte [r13+3], 'l'
    jne .store_ident
    cmp byte [r13+4], 's'
    jne .chk9block
    cmp byte [r13+5], 't'
    jne .store_ident
    cmp byte [r13+6], 'r'
    jne .store_ident
    cmp byte [r13+7], 'i'
    jne .store_ident
    cmp byte [r13+8], 'p'
    jne .store_ident
    mov byte [rdi], T_HTMLSTRIP
    jmp .store_kw
.chk9block:
    cmp byte [r13+4], 'b'
    jne .chk9title
    cmp byte [r13+5], 'l'
    jne .store_ident
    cmp byte [r13+6], 'o'
    jne .store_ident
    cmp byte [r13+7], 'c'
    jne .store_ident
    cmp byte [r13+8], 'k'
    jne .store_ident
    mov byte [rdi], T_HTMLBLOCK
    jmp .store_kw
.chk9title:
    cmp byte [r13+4], 't'
    jne .store_ident
    cmp byte [r13+5], 'i'
    jne .store_ident
    cmp byte [r13+6], 't'
    jne .store_ident
    cmp byte [r13+7], 'l'
    jne .store_ident
    cmp byte [r13+8], 'e'
    jne .store_ident
    mov byte [rdi], T_HTMLTITLE
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
    cmp al, T_SETTEXT
    je .stsettext
    cmp al, T_SETNUM
    je .stsetnum
    cmp al, T_SETCOLOR
    je .stsetcolor
    cmp al, T_SETHIDE
    je .stsethide
    cmp al, T_NETTEXT
    je .stnettext
    cmp al, T_NETPRINT
    je .stnetprint
    cmp al, T_NETSAVE
    je .stnetsave
    cmp al, T_HTTPGET
    je .sthttpget
    cmp al, T_PRINTS
    je .stprints
    cmp al, T_INPUT
    je .stinput
    cmp al, T_PANEL
    je .stpanel
    cmp al, T_HTMLSTRIP
    je .sthtmlstrip
    cmp al, T_HTMLTITLE
    je .sthtmltitle
    cmp al, T_HTMLBLOCK
    je .sthtmlblock
    cmp al, T_RESETUI
    je .stresetui
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
.stsettext:
    call do_settext
    jmp .done
.stsetnum:
    call do_setnum
    jmp .done
.stsetcolor:
    call do_setcolor
    jmp .done
.stsethide:
    call do_sethide
    jmp .done
.stnettext:
    call do_nettext
    jmp .done
.stnetprint:
    call do_netprint
    jmp .done
.stnetsave:
    call do_netsave
    jmp .done
.sthttpget:
    call do_httpget
    jmp .done
.stprints:
    call do_prints
    jmp .done
.stinput:
    mov ecx, 3
    call parse_rect_widget
    jmp .done
.stpanel:
    mov ecx, 4
    call parse_rect_widget
    jmp .done
.sthtmlstrip:
    call do_htmlstrip
    jmp .done
.sthtmltitle:
    call do_htmltitle
    jmp .done
.sthtmlblock:
    call do_htmlblock
    jmp .done
.stresetui:
    call do_resetui
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
    mov r12, rcx
    mov r13, rdx
    call advance
    lea r8, [bi_netstatus]
    call mem_eq
    test rax, rax
    jnz .pbsts
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_netlength]
    call mem_eq
    test rax, rax
    jnz .pblen
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_cssbg]
    call mem_eq
    test rax, rax
    jnz .pbcssbg
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_cssfg]
    call mem_eq
    test rax, rax
    jnz .pbcssfg
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_htmlblocks]
    call mem_eq
    test rax, rax
    jnz .pbblocks
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_blocklen]
    call mem_eq
    test rax, rax
    jnz .pbblocklen
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_blocktag]
    call mem_eq
    test rax, rax
    jnz .pbblocktag
    mov rcx, r12
    mov rdx, r13
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
.pbsts:
    mov r13, [netstatus]
    jmp .pbparen
.pblen:
    mov r13, [netlen]
    jmp .pbparen
.pbcssbg:
    lea rcx, [needle_bg1]
    xor edx, edx
    call css_lookup
    test rax, rax
    jnz .pbcsbgot
    lea rcx, [needle_bg2]
    xor edx, edx
    call css_lookup
.pbcsbgot:
    test rax, rax
    jnz .pbcsbret
    mov eax, 0x00FFFFFF
.pbcsbret:
    mov r13, rax
    jmp .pbparen
.pbcssfg:
    lea rcx, [needle_fg]
    mov edx, '-'
    call css_lookup
    mov r13, rax
    jmp .pbparen
.pbblocks:
    xor ecx, ecx
    xor edx, edx
    xor r8d, r8d
    call blk_scan
    mov r13, rax
    jmp .pbparen
.pbblocklen:
    call blk_arg
    mov rdx, rax
    mov ecx, 2
    xor r8d, r8d
    call blk_scan
    mov r13, rax
    jmp .pbret
.pbblocktag:
    call blk_arg
    mov rdx, rax
    mov ecx, 3
    xor r8d, r8d
    call blk_scan
    mov r13, rax
    jmp .pbret
.pbparen:
    call curtype
    cmp al, T_LPAREN
    jne .pbret
    call advance
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
.pbret:
    mov rax, r13
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
    call eval_expr
    mov [rbx+WD_X], rax
    call eval_expr
    mov [rbx+WD_Y], rax
    call eval_expr
    mov [rbx+WD_W], rax
    call eval_expr
    mov [rbx+WD_H], rax
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
    call eval_expr
    mov [rbx+WD_X], rax
    call eval_expr
    mov [rbx+WD_Y], rax
    call eval_expr
    mov [rbx+WD_W], rax
    call eval_expr
    mov [rbx+WD_H], rax
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
mem_eq:
    push rbx
    xor eax, eax
.me_loop:
    test rdx, rdx
    jz .me_check
    movzx ebx, byte [rcx]
    cmp bl, [r8]
    jne .me_no
    inc rcx
    inc r8
    dec rdx
    jmp .me_loop
.me_check:
    cmp byte [r8], 0
    jne .me_no
    mov rax, 1
.me_no:
    pop rbx
    ret
fmt_num:
    push rbx
    push rdi
    push rsi
    push r12
    mov rax, rcx
    mov r12, rdx
    xor r9, r9
    test rax, rax
    jns .fn_pos
    neg rax
    mov r9, 1
.fn_pos:
    lea rdi, [fmtscratch+31]
    mov byte [rdi], 0
    mov rbx, 10
.fn_cv:
    xor rdx, rdx
    div rbx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    test rax, rax
    jnz .fn_cv
    test r9, r9
    jz .fn_nneg
    dec rdi
    mov byte [rdi], '-'
.fn_nneg:
    lea rsi, [fmtscratch+31]
    mov rax, rsi
    sub rax, rdi
    mov rcx, rax
    mov rsi, rdi
    mov rdi, r12
    test rcx, rcx
    jz .fn_term
    rep movsb
.fn_term:
    mov byte [rdi], 0
    pop r12
    pop rsi
    pop rdi
    pop rbx
    ret
wset_text:
    push rbx
    push rsi
    push rdi
    mov rbx, rcx
    mov rsi, rdx
    mov rcx, r8
    cmp rcx, WD_TBUF_MAX
    jbe .wt_ok
    mov rcx, WD_TBUF_MAX
.wt_ok:
    mov [rbx+WD_TEXT_LEN], rcx
    lea rdi, [rbx+WD_TBUF]
    mov [rbx+WD_TEXT_PTR], rdi
    test rcx, rcx
    jz .wt_term
    rep movsb
.wt_term:
    mov byte [rdi], 0
    pop rdi
    pop rsi
    pop rbx
    ret
wrefresh:
    push rbx
    sub rsp, 48
    mov rcx, [hwnd_main]
    test rcx, rcx
    jz .wr_done
    xor edx, edx
    xor r8d, r8d
    call InvalidateRect
.wr_done:
    add rsp, 48
    pop rbx
    ret
do_settext:
    push rbx
    push r12
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .undef
    mov r12, rax
    call advance
    call curtype
    cmp al, T_STRING
    jne .bad
    mov rbx, [tcur]
    mov rcx, r12
    mov rdx, [rbx+16]
    mov r8, [rbx+24]
    call wset_text
    call advance
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    call wrefresh
    add rsp, 40
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
.undef:
    lea r8, [msg_undef]
    call fatal
do_setnum:
    push rbx
    push r12
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .undef
    mov r12, rax
    call advance
    call eval_expr
    mov rcx, rax
    lea rdx, [r12+WD_TBUF]
    call fmt_num
    mov [r12+WD_TEXT_LEN], rax
    lea rcx, [r12+WD_TBUF]
    mov [r12+WD_TEXT_PTR], rcx
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    call wrefresh
    add rsp, 40
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
.undef:
    lea r8, [msg_undef]
    call fatal
do_setcolor:
    push rbx
    push r12
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .undef
    mov r12, rax
    call advance
    call eval_expr
    mov [r12+WD_COLOR], rax
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    call wrefresh
    add rsp, 40
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
.undef:
    lea r8, [msg_undef]
    call fatal
do_sethide:
    push rbx
    push r12
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .undef
    mov r12, rax
    call advance
    call eval_expr
    test rax, rax
    jz .show
    mov qword [r12+WD_HIDDEN], 1
    jmp .adv
.show:
    mov qword [r12+WD_HIDDEN], 0
.adv:
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    call wrefresh
    add rsp, 40
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
.undef:
    lea r8, [msg_undef]
    call fatal
do_prints:
    push rbx
    sub rsp, 48
    call advance
    call curtype
    cmp al, T_STRING
    jne .bad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    test rcx, rcx
    jz .adv
    call pstr
.adv:
    call advance
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    add rsp, 48
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
html_find_str:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 40
    mov r12, rcx
.hfs_outer:
    movzx eax, byte [r12]
    test al, al
    jz .hfs_none
    mov r13, r12
    mov r14, rdx
.hfs_inner:
    movzx eax, byte [r14]
    test al, al
    jz .hfs_hit
    movzx ecx, byte [r13]
    test cl, cl
    jz .hfs_none
    cmp al, 'A'
    jb .hfs_lo1
    cmp al, 'Z'
    ja .hfs_lo1
    add al, 32
.hfs_lo1:
    cmp cl, 'A'
    jb .hfs_lo2
    cmp cl, 'Z'
    ja .hfs_lo2
    add cl, 32
.hfs_lo2:
    cmp al, cl
    jne .hfs_next
    inc r13
    inc r14
    jmp .hfs_inner
.hfs_next:
    inc r12
    jmp .hfs_outer
.hfs_hit:
    mov rax, r12
    jmp .hfs_done
.hfs_none:
    xor eax, eax
.hfs_done:
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
css_lookup:
    push rbx
    push r12
    push r13
    sub rsp, 40
    mov r12, rcx
    mov r13, rdx
    lea rcx, [netbuf]
    mov rdx, r12
    call html_find_str
    test rax, rax
    jz .cl_none
    mov rbx, rax
    test r13, r13
    jz .cl_ok
    cmp rbx, netbuf
    jbe .cl_ok
    movzx eax, byte [rbx-1]
    cmp al, r13b
    jne .cl_ok
    lea rcx, [rbx+1]
    mov rdx, r12
    call html_find_str
    test rax, rax
    jz .cl_none
    mov rbx, rax
.cl_ok:
    mov r12, rbx
    xor r13, r13
.cl_findhash:
    cmp r13, 60
    jae .cl_none
    movzx eax, byte [r12+r13]
    test al, al
    jz .cl_none
    cmp al, '#'
    je .cl_hash
    inc r13
    jmp .cl_findhash
.cl_hash:
    lea r12, [r12+r13+1]
    xor r13, r13
    xor eax, eax
.cl_hexloop:
    cmp r13, 6
    jae .cl_hexdone
    movzx ecx, byte [r12+r13]
    cmp cl, '0'
    jb .cl_hexdone
    cmp cl, '9'
    jbe .cl_xdig
    mov dl, cl
    cmp dl, 'a'
    jb .cl_xupper
    cmp dl, 'f'
    ja .cl_hexdone
    sub cl, 'a'
    add cl, 10
    jmp .cl_xstore
.cl_xupper:
    cmp dl, 'A'
    jb .cl_hexdone
    cmp dl, 'F'
    ja .cl_hexdone
    sub cl, 'A'
    add cl, 10
    jmp .cl_xstore
.cl_xdig:
    sub cl, '0'
.cl_xstore:
    shl rax, 4
    movzx rcx, cl
    or rax, rcx
    inc r13
    jmp .cl_hexloop
.cl_hexdone:
    cmp r13, 6
    je .cl_done
    cmp r13, 3
    jne .cl_none
    movzx rcx, ax
    and rcx, 15
    mov r8, rcx
    movzx rcx, ax
    shr rcx, 4
    and rcx, 15
    mov r9, rcx
    movzx rcx, ax
    shr rcx, 8
    and rcx, 15
    imul rcx, rcx, 17
    shl rcx, 16
    imul r9, r9, 17
    shl r9, 8
    or rcx, r9
    imul r8, r8, 17
    or rcx, r8
    mov rax, rcx
    jmp .cl_done
.cl_none:
    xor eax, eax
.cl_done:
    add rsp, 40
    pop r13
    pop r12
    pop rbx
    ret
parse_rect_widget:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 40
    call advance
    mov rax, [nwidgets]
    cmp rax, MAX_WIDGETS
    jae .rwfull
    imul rbx, rax, WIDGET_SIZE
    lea rbx, [widgets + rbx]
    mov [rbx+WD_TYPE], rcx
    mov qword [rbx+WD_COLOR], 0x00303033
    mov qword [rbx+WD_RADIUS], 6
    cmp rcx, 4
    jne .rwdefs
    mov qword [rbx+WD_COLOR], 0x00FFFFFF
    mov qword [rbx+WD_RADIUS], 0
.rwdefs:
    mov qword [rbx+WD_CB_START], 0
    mov qword [rbx+WD_CB_END], 0
    mov qword [rbx+WD_HIDDEN], 0
    mov qword [rbx+WD_TEXT_PTR], 0
    mov qword [rbx+WD_TEXT_LEN], 0
    mov byte [rbx+WD_TBUF], 0
    call curtype
    cmp al, T_IDENT
    jne .rwbad
    mov r12, [tcur]
    mov rax, [r12+16]
    mov [rbx+WD_NAME_PTR], rax
    mov rax, [r12+24]
    mov [rbx+WD_NAME_LEN], rax
    call advance
    xor r13, r13
.rwgeom:
    cmp r13, 4
    jae .rwgeomdone
    call eval_expr
    cmp r13, 0
    je .rwgx
    cmp r13, 1
    je .rwgy
    cmp r13, 2
    je .rwgw
    mov [rbx+WD_H], rax
    jmp .rwgn
.rwgx:
    mov [rbx+WD_X], rax
    jmp .rwgn
.rwgy:
    mov [rbx+WD_Y], rax
    jmp .rwgn
.rwgw:
    mov [rbx+WD_W], rax
.rwgn:
    inc r13
    jmp .rwgeom
.rwgeomdone:
    cmp r13, 4
    jb .rwbad
    call curtype
    cmp al, T_STRING
    jne .rwprops
    mov r12, [tcur]
    mov rcx, rbx
    mov rdx, [r12+16]
    mov r8, [r12+24]
    call wset_text
    call advance
.rwprops:
    call curtype
    cmp al, T_SEMI
    je .rwdone
    cmp al, T_IDENT
    jne .rwdone
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    cmp rdx, 6
    jne .rwchkcol
    cmp byte [rcx], 'r'
    jne .rwchkcol
    cmp byte [rcx+1], 'a'
    jne .rwchkcol
    cmp byte [rcx+2], 'd'
    jne .rwchkcol
    cmp byte [rcx+3], 'i'
    jne .rwchkcol
    cmp byte [rcx+4], 'u'
    jne .rwchkcol
    cmp byte [rcx+5], 's'
    jne .rwchkcol
    call advance
    call curtype
    cmp al, T_EQ
    jne .rwbad
    call advance
    call curtype
    cmp al, T_NUM
    jne .rwbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_RADIUS], rax
    call advance
    jmp .rwprops
.rwchkcol:
    cmp rdx, 5
    jne .rwskip
    cmp byte [rcx], 'c'
    jne .rwskip
    cmp byte [rcx+1], 'o'
    jne .rwskip
    cmp byte [rcx+2], 'l'
    jne .rwskip
    cmp byte [rcx+3], 'o'
    jne .rwskip
    cmp byte [rcx+4], 'r'
    jne .rwskip
    call advance
    call curtype
    cmp al, T_EQ
    jne .rwbad
    call advance
    call eval_expr
    mov [rbx+WD_COLOR], rax
    jmp .rwprops
.rwskip:
    call advance
    call curtype
    cmp al, T_EQ
    jne .rwprops
    call advance
    call eval_expr
    jmp .rwprops
.rwdone:
    call curtype
    cmp al, T_SEMI
    jne .rwbad
    call advance
    inc qword [nwidgets]
    add rsp, 40
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.rwbad:
    lea r8, [msg_syntax]
    call fatal
.rwfull:
    lea r8, [msg_full]
    call fatal
do_htmlstrip:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_IDENT
    jne .hsbad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .hsundef
    mov rbx, rax
    call advance
    call curtype
    cmp al, T_SEMI
    jne .hsbad
    call advance
    lea r12, [netbuf]
    lea r13, [rbx+WD_TBUF]
    xor r14, r14
    xor r15, r15
.hsloop:
    movzx eax, byte [r12]
    test al, al
    jz .hsend
    cmp al, '<'
    je .hstag
    cmp al, '&'
    je .hsentity
    cmp al, ' '
    je .hsspace
    cmp al, 9
    je .hsspace
    cmp al, 10
    je .hsnl
    cmp al, 13
    je .hsnl
    jmp .hschar
.hsspace:
    inc r12
    mov r15, 1
    jmp .hsloop
.hsnl:
    inc r12
    cmp r14, 0
    je .hsloop
    cmp byte [r13+r14-1], 10
    je .hsloop
    cmp r14, WD_TBUF_MAX-2
    jae .hsend
    mov byte [r13+r14], 10
    inc r14
    xor r15, r15
    jmp .hsloop
.hschar:
    inc r12
.hsemit:
    cmp r14, WD_TBUF_MAX-2
    jae .hsend
    test r15, r15
    jz .hsemit2
    mov byte [r13+r14], ' '
    inc r14
    xor r15, r15
.hsemit2:
    mov [r13+r14], al
    inc r14
    jmp .hsloop
.hsentity:
    lea rdi, [r12+1]
    cmp byte [rdi], 'a'
    jne .hsent_lt
    cmp byte [rdi+1], 'm'
    jne .hsent_lt
    cmp byte [rdi+2], 'p'
    jne .hsent_lt
    cmp byte [rdi+3], ';'
    jne .hsent_lt
    lea r12, [r12+5]
    mov al, '&'
    jmp .hsemit
.hsent_lt:
    cmp byte [rdi], 'l'
    jne .hsent_gt
    cmp byte [rdi+1], 't'
    jne .hsent_gt
    cmp byte [rdi+2], ';'
    jne .hsent_gt
    lea r12, [r12+4]
    mov al, '<'
    jmp .hsemit
.hsent_gt:
    cmp byte [rdi], 'g'
    jne .hsent_quot
    cmp byte [rdi+1], 't'
    jne .hsent_quot
    cmp byte [rdi+2], ';'
    jne .hsent_quot
    lea r12, [r12+4]
    mov al, '>'
    jmp .hsemit
.hsent_quot:
    cmp byte [rdi], 'q'
    jne .hsent_nbsp
    cmp byte [rdi+1], 'u'
    jne .hsent_nbsp
    cmp byte [rdi+2], 'o'
    jne .hsent_nbsp
    cmp byte [rdi+3], 't'
    jne .hsent_nbsp
    cmp byte [rdi+4], ';'
    jne .hsent_nbsp
    lea r12, [r12+6]
    mov al, '"'
    jmp .hsemit
.hsent_nbsp:
    cmp byte [rdi], 'n'
    jne .hsent_num
    cmp byte [rdi+1], 'b'
    jne .hsent_num
    cmp byte [rdi+2], 's'
    jne .hsent_num
    cmp byte [rdi+3], 'p'
    jne .hsent_num
    cmp byte [rdi+4], ';'
    jne .hsent_num
    lea r12, [r12+6]
    mov al, ' '
    jmp .hsemit
.hsent_num:
    cmp byte [r12+1], '#'
    jne .hsent_amp
    lea rsi, [r12+2]
.hsent_nloop:
    movzx eax, byte [rsi]
    test al, al
    jz .hsend
    cmp al, ';'
    je .hsent_ndone
    inc rsi
    jmp .hsent_nloop
.hsent_ndone:
    lea r12, [rsi+1]
    jmp .hsloop
.hsent_amp:
    inc r12
    mov al, '&'
    jmp .hsemit
.hstag:
    cmp byte [r12+1], '!'
    je .hst_comment
    lea rsi, [r12+1]
    cmp byte [rsi], '/'
    jne .hst_ok
    inc rsi
.hst_ok:
    mov rdi, rsi
.hst_scan:
    movzx eax, byte [rdi]
    test al, al
    jz .hsend
    cmp al, '>'
    je .hst_scandone
    inc rdi
    jmp .hst_scan
.hst_scandone:
    xor rcx, rcx
    lea rdx, [tagtmp]
.hst_copy:
    cmp rcx, 8
    jae .hst_copied
    cmp rsi, rdi
    jae .hst_copied
    movzx eax, byte [rsi]
    cmp al, 'A'
    jb .hst_low
    cmp al, 'Z'
    ja .hst_low
    add al, 32
.hst_low:
    mov [rdx+rcx], al
    inc rcx
    inc rsi
    jmp .hst_copy
.hst_copied:
    mov byte [rdx+rcx], 0
    cmp byte [r12+1], '/'
    je .hst_block
    lea rcx, [tagtmp]
    cmp dword [rcx], 0x69726373
    jne .hst_chkstyle
    cmp word [rcx+4], 0x7470
    jne .hst_block
    lea rcx, [rdi+1]
    lea rdx, [needle_script]
    call html_find_str
    test rax, rax
    jz .hsend
    mov r12, rax
    jmp .hst_advgt
.hst_chkstyle:
    cmp dword [rcx], 0x6C797473
    jne .hst_block
    cmp byte [rcx+4], 'e'
    jne .hst_block
    lea rcx, [rdi+1]
    lea rdx, [needle_style]
    call html_find_str
    test rax, rax
    jz .hsend
    mov r12, rax
.hst_advgt:
    movzx eax, byte [r12]
    test al, al
    jz .hsend
    cmp al, '>'
    je .hst_advgtdone
    inc r12
    jmp .hst_advgt
.hst_advgtdone:
    inc r12
    jmp .hsloop
.hst_comment:
    lea rcx, [r12+4]
    lea rdx, [needle_comment]
    call html_find_str
    test rax, rax
    jz .hsend
    lea r12, [rax+3]
    jmp .hsloop
.hst_block:
    lea r12, [rdi+1]
    cmp r14, 0
    je .hsloop
    cmp byte [r13+r14-1], 10
    je .hsloop
    cmp r14, WD_TBUF_MAX-2
    jae .hsend
    mov byte [r13+r14], 10
    inc r14
    xor r15, r15
    jmp .hsloop
.hsend:
    cmp r14, 0
    je .hsterm
    movzx eax, byte [r13+r14-1]
    cmp al, 10
    je .hstrim1
    cmp al, ' '
    je .hstrim1
    jmp .hsterm
.hstrim1:
    dec r14
    jmp .hsend
.hsterm:
    mov byte [r13+r14], 0
    mov [rbx+WD_TEXT_LEN], r14
    mov [rbx+WD_TEXT_PTR], r13
    call wrefresh
    add rsp, 40
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.hsbad:
    lea r8, [msg_syntax]
    call fatal
.hsundef:
    lea r8, [msg_undef]
    call fatal
do_htmltitle:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_IDENT
    jne .htbad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .htundef
    mov rbx, rax
    call advance
    call curtype
    cmp al, T_SEMI
    jne .htbad
    call advance
    lea rcx, [netbuf]
    lea rdx, [needle_title]
    call html_find_str
    test rax, rax
    jz .htdone
    lea r12, [rax+6]
.htt_skip:
    movzx eax, byte [r12]
    test al, al
    jz .htdone
    cmp al, '>'
    je .htt_body
    inc r12
    jmp .htt_skip
.htt_body:
    inc r12
    lea r13, [rbx+WD_TBUF]
    xor r14, r14
.htt_loop:
    movzx eax, byte [r12]
    test al, al
    jz .htt_store
    cmp al, '<'
    je .htt_store
    cmp r14, 255
    jae .htt_store
    mov [r13+r14], al
    inc r14
    inc r12
    jmp .htt_loop
.htt_store:
    mov byte [r13+r14], 0
    mov [rbx+WD_TEXT_LEN], r14
    mov [rbx+WD_TEXT_PTR], r13
.htdone:
    call wrefresh
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.htbad:
    lea r8, [msg_syntax]
    call fatal
.htundef:
    lea r8, [msg_undef]
    call fatal
do_htmlblock:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_IDENT
    jne .hb_bad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .hb_undef
    mov r12, rax
    call advance
    call eval_expr
    mov rdx, rax
    mov ecx, 1
    lea r8, [r12 + WD_TBUF]
    call blk_scan
    mov r13, rax
    test r13, r13
    jnz .hb_ok
    mov byte [r12 + WD_TBUF], 0
.hb_ok:
    mov [r12 + WD_TEXT_LEN], r13
    lea rax, [r12 + WD_TBUF]
    mov [r12 + WD_TEXT_PTR], rax
    call curtype
    cmp al, T_SEMI
    jne .hb_bad
    call advance
    call wrefresh
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.hb_bad:
    lea r8, [msg_syntax]
    call fatal
.hb_undef:
    lea r8, [msg_undef]
    call fatal
do_resetui:
    push rbx
    push r12
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_SEMI
    je .ru_one
    call eval_expr
    mov r12, rax
    jmp .ru_have
.ru_one:
    mov r12, 1
.ru_have:
    cmp r12, [nwidgets]
    jbe .ru_ok
    mov r12, [nwidgets]
.ru_ok:
    mov [nwidgets], r12
    call curtype
    cmp al, T_SEMI
    jne .ru_bad
    call advance
    call wrefresh
    add rsp, 40
    pop r12
    pop rbx
    ret
.ru_bad:
    lea r8, [msg_syntax]
    call fatal
blk_arg:
    push rbx
    sub rsp, 32
    call curtype
    cmp al, T_LPAREN
    jne .ba_bad
    call advance
    mov rbx, [argmode]
    mov qword [argmode], 0
    call eval_expr
    mov [rsp+8], rax
    mov [argmode], rbx
    call curtype
    cmp al, T_RPAREN
    jne .ba_bad
    call advance
    mov rax, [rsp+8]
    add rsp, 32
    pop rbx
    ret
.ba_bad:
    lea r8, [msg_syntax]
    call fatal
blk_skip_tag:
    push rbx
    lea rbx, [blkneedle]
    mov byte [rbx], '<'
    mov byte [rbx+1], '/'
    lea rsi, [blktmp]
    xor rcx, rcx
.bst_cp:
    movzx eax, byte [rsi+rcx]
    test al, al
    jz .bst_cpdone
    mov [rbx+rcx+2], al
    inc rcx
    jmp .bst_cp
.bst_cpdone:
    mov byte [rbx+rcx+2], 0
    mov rcx, [blksrc]
    lea rdx, [blkneedle]
    call html_find_str
    test rax, rax
    jz .bst_end
.bst_gt:
    movzx ecx, byte [rax]
    test cl, cl
    jz .bst_end
    cmp cl, '>'
    je .bst_gtdone
    inc rax
    jmp .bst_gt
.bst_gtdone:
    inc rax
    mov [blksrc], rax
    pop rbx
    ret
.bst_end:
    mov rsi, [blksrc]
.bst_endl:
    cmp byte [rsi], 0
    je .bst_endd
    inc rsi
    jmp .bst_endl
.bst_endd:
    mov [blksrc], rsi
    pop rbx
    ret
tag_block_code:
    push rbx
    push rsi
    push rdi
    lea rbx, [blktab]
.tbc_loop:
    movzx eax, byte [rbx]
    test al, al
    jz .tbc_none
    mov rdi, rbx
    mov rsi, rcx
.tbc_cmp:
    movzx eax, byte [rdi]
    movzx edx, byte [rsi]
    cmp al, dl
    jne .tbc_skip
    test al, al
    jz .tbc_hit
    inc rdi
    inc rsi
    jmp .tbc_cmp
.tbc_skip:
    movzx eax, byte [rbx]
    test al, al
    jz .tbc_skdone
    inc rbx
    jmp .tbc_skip
.tbc_skdone:
    add rbx, 2
    jmp .tbc_loop
.tbc_hit:
    movzx eax, byte [rdi+1]
    jmp .tbc_out
.tbc_none:
    mov rax, -1
.tbc_out:
    pop rdi
    pop rsi
    pop rbx
    ret
blk_close:
    push rax
    push rbx
    cmp qword [blkopen], 0
    je .bc_out
    mov qword [blkopen], 0
    mov rcx, [blklen]
    lea rdi, [blkbuf]
.bc_trim:
    test rcx, rcx
    jz .bc_trimmed
    movzx eax, byte [rdi+rcx-1]
    cmp al, ' '
    jne .bc_trimmed
    dec rcx
    jmp .bc_trim
.bc_trimmed:
    mov [blklen], rcx
    test rcx, rcx
    jz .bc_reset
    mov rax, [blkcount]
    mov rbx, [blkmode]
    cmp rbx, 0
    je .bc_count
    cmp rax, [blkidx]
    jne .bc_count
    cmp rbx, 2
    je .bc_len
    cmp rbx, 3
    je .bc_tag
    mov rsi, rdi
    mov rdi, [blkdest]
    xor rdx, rdx
.bc_cp:
    cmp rdx, rcx
    jae .bc_cpdone
    movzx eax, byte [rsi+rdx]
    mov [rdi+rdx], al
    inc rdx
    jmp .bc_cp
.bc_cpdone:
    mov byte [rdi+rdx], 0
    mov [blkres], rcx
    jmp .bc_count
.bc_len:
    mov [blkres], rcx
    jmp .bc_count
.bc_tag:
    mov rax, [blkcurtag]
    mov [blkres], rax
.bc_count:
    inc qword [blkcount]
.bc_reset:
    mov qword [blklen], 0
    mov qword [blkspace], 0
    lea rdi, [blkbuf]
    mov byte [rdi], 0
.bc_out:
    pop rbx
    pop rax
    ret
blk_scan:
    push rbx
    push rsi
    push rdi
    sub rsp, 16
    mov [blkmode], rcx
    mov [blkidx], rdx
    mov [blkdest], r8
    mov qword [blkcount], 0
    mov qword [blkopen], 0
    mov qword [blkcurtag], 0
    mov qword [blkres], 0
    mov qword [blklen], 0
    mov qword [blkspace], 0
    mov byte [blktmp], 0
    mov byte [blkbuf], 0
    lea rax, [netbuf]
    mov [blksrc], rax
.bs_loop:
    mov rsi, [blksrc]
    movzx eax, byte [rsi]
    test al, al
    jz .bs_eof
    cmp al, '<'
    je .bs_tag
    cmp al, '&'
    je .bs_entity
    cmp al, ' '
    je .bs_space
    cmp al, 9
    je .bs_space
    cmp al, 10
    je .bs_space
    cmp al, 13
    je .bs_space
    add rsi, 1
    mov [blksrc], rsi
    jmp .bs_emit
.bs_space:
    add rsi, 1
    mov [blksrc], rsi
    mov qword [blkspace], 1
    jmp .bs_loop
.bs_emit:
    cmp qword [blkopen], 0
    jne .bs_emit_go
    call blk_close
    mov qword [blkcurtag], 0
    mov qword [blkopen], 1
.bs_emit_go:
    mov rcx, [blklen]
    cmp rcx, 4094
    jae .bs_loop
    cmp qword [blkspace], 0
    je .bs_emit_ch
    lea rdi, [blkbuf]
    mov byte [rdi+rcx], ' '
    inc rcx
    mov [blklen], rcx
    mov qword [blkspace], 0
.bs_emit_ch:
    lea rdi, [blkbuf]
    mov [rdi+rcx], al
    inc rcx
    mov [blklen], rcx
    jmp .bs_loop
.bs_entity:
    lea rdi, [rsi+1]
    cmp byte [rdi], 'a'
    jne .bsent_lt
    cmp byte [rdi+1], 'm'
    jne .bsent_lt
    cmp byte [rdi+2], 'p'
    jne .bsent_lt
    cmp byte [rdi+3], ';'
    jne .bsent_lt
    add rsi, 5
    mov [blksrc], rsi
    mov al, '&'
    jmp .bs_emit
.bsent_lt:
    cmp byte [rdi], 'l'
    jne .bsent_gt
    cmp byte [rdi+1], 't'
    jne .bsent_gt
    cmp byte [rdi+2], ';'
    jne .bsent_gt
    add rsi, 4
    mov [blksrc], rsi
    mov al, '<'
    jmp .bs_emit
.bsent_gt:
    cmp byte [rdi], 'g'
    jne .bsent_quot
    cmp byte [rdi+1], 't'
    jne .bsent_quot
    cmp byte [rdi+2], ';'
    jne .bsent_quot
    add rsi, 4
    mov [blksrc], rsi
    mov al, '>'
    jmp .bs_emit
.bsent_quot:
    cmp byte [rdi], 'q'
    jne .bsent_nbsp
    cmp byte [rdi+1], 'u'
    jne .bsent_nbsp
    cmp byte [rdi+2], 'o'
    jne .bsent_nbsp
    cmp byte [rdi+3], 't'
    jne .bsent_nbsp
    cmp byte [rdi+4], ';'
    jne .bsent_nbsp
    add rsi, 6
    mov [blksrc], rsi
    mov al, '"'
    jmp .bs_emit
.bsent_nbsp:
    cmp byte [rdi], 'n'
    jne .bsent_num
    cmp byte [rdi+1], 'b'
    jne .bsent_num
    cmp byte [rdi+2], 's'
    jne .bsent_num
    cmp byte [rdi+3], 'p'
    jne .bsent_num
    cmp byte [rdi+4], ';'
    jne .bsent_num
    add rsi, 6
    mov [blksrc], rsi
    mov al, ' '
    jmp .bs_emit
.bsent_num:
    cmp byte [rdi], '#'
    jne .bsent_amp
    mov rdi, rsi
.bsent_numl:
    movzx eax, byte [rdi]
    test al, al
    jz .bs_eof
    cmp al, ';'
    je .bsent_numd
    inc rdi
    jmp .bsent_numl
.bsent_numd:
    lea rax, [rdi+1]
    mov [blksrc], rax
    jmp .bs_loop
.bsent_amp:
    add rsi, 1
    mov [blksrc], rsi
    mov al, '&'
    jmp .bs_emit
.bs_bang:
    cmp byte [rsi+2], '-'
    jne .bs_doctype
    cmp byte [rsi+3], '-'
    jne .bs_doctype
    add rsi, 4
    mov [blksrc], rsi
    mov rcx, [blksrc]
    lea rdx, [needle_comment]
    call html_find_str
    test rax, rax
    jz .bs_eof
    add rax, 3
    mov [blksrc], rax
    jmp .bs_loop
.bs_doctype:
    add rsi, 1
.bs_dtl:
    movzx eax, byte [rsi]
    test al, al
    jz .bs_eof
    cmp al, '>'
    je .bs_dtdone
    inc rsi
    jmp .bs_dtl
.bs_dtdone:
    add rsi, 1
    mov [blksrc], rsi
    jmp .bs_loop
.bs_tag:
    cmp byte [rsi+1], '!'
    je .bs_bang
    xor edx, edx
    add rsi, 1
    cmp byte [rsi], '/'
    jne .bs_tgname
    mov edx, 1
    add rsi, 1
.bs_tgname:
    mov [blkclosing], rdx
    mov rdi, rsi
.bs_tgscan:
    movzx eax, byte [rdi]
    test al, al
    jz .bs_eof
    cmp al, '>'
    je .bs_tgfound
    inc rdi
    jmp .bs_tgscan
.bs_tgfound:
    xor rbx, rbx
.bs_tgcopy:
    cmp rbx, 9
    jae .bs_tgdone
    cmp rsi, rdi
    jae .bs_tgdone
    movzx eax, byte [rsi]
    cmp al, 'A'
    jb .bs_tglow
    cmp al, 'Z'
    ja .bs_tglow
    add al, 32
.bs_tglow:
    cmp al, 'a'
    jb .bs_tgdigit
    cmp al, 'z'
    jbe .bs_tgstore
.bs_tgdigit:
    cmp al, '0'
    jb .bs_tgstop
    cmp al, '9'
    jbe .bs_tgstore
    jmp .bs_tgstop
.bs_tgstore:
    lea rcx, [blktmp]
    mov [rcx+rbx], al
    inc rbx
    inc rsi
    jmp .bs_tgcopy
.bs_tgstop:
.bs_tgdone:
    lea rcx, [blktmp]
    mov byte [rcx+rbx], 0
    lea rax, [rdi+1]
    mov [blksrc], rax
    lea rcx, [blktmp]
    lea rdx, [tag_script]
    call streq
    test rax, rax
    jnz .bs_skip
    lea rcx, [blktmp]
    lea rdx, [tag_style]
    call streq
    test rax, rax
    jnz .bs_skip
    lea rcx, [blktmp]
    lea rdx, [tag_head]
    call streq
    test rax, rax
    jnz .bs_skip
    lea rcx, [blktmp]
    lea rdx, [tag_noscript]
    call streq
    test rax, rax
    jnz .bs_skip
    lea rcx, [blktmp]
    lea rdx, [tag_svg]
    call streq
    test rax, rax
    jnz .bs_skip
    lea rcx, [blktmp]
    lea rdx, [tag_iframe]
    call streq
    test rax, rax
    jnz .bs_skip
    lea rcx, [blktmp]
    lea rdx, [tag_template]
    call streq
    test rax, rax
    jnz .bs_skip
    lea rcx, [blktmp]
    call tag_block_code
    cmp rax, -1
    je .bs_loop
    cmp rax, 11
    je .bs_br
    cmp qword [blkclosing], 0
    jne .bs_closetag
    mov [rsp+8], rax
    call blk_close
    mov rax, [rsp+8]
    mov [blkcurtag], rax
    mov qword [blkopen], 1
    jmp .bs_loop
.bs_closetag:
    call blk_close
    jmp .bs_loop
.bs_br:
    mov qword [blkspace], 1
    jmp .bs_loop
.bs_skip:
    cmp qword [blkclosing], 0
    jne .bs_loop
    call blk_skip_tag
    jmp .bs_loop
.bs_eof:
    call blk_close
    mov rcx, [blkmode]
    test rcx, rcx
    jnz .bs_res
    mov rax, [blkcount]
    jmp .bs_out
.bs_res:
    mov rax, [blkres]
.bs_out:
    add rsp, 16
    pop rdi
    pop rsi
    pop rbx
    ret
net_fetch:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 56
    mov r12, rcx
    xor r13d, r13d
    xor r14d, r14d
    mov qword [netlen], 0
    mov qword [netstatus], 0
    mov byte [netbuf], 0
    lea rcx, [agent_name]
    xor edx, edx
    xor r8d, r8d
    xor r9d, r9d
    mov qword [rsp+32], 0
    call InternetOpenA
    test rax, rax
    jz .nf_done
    mov r13, rax
    mov rcx, r13
    mov rdx, r12
    xor r8d, r8d
    xor r9d, r9d
    mov eax, 0x84000000
    mov [rsp+32], rax
    mov qword [rsp+40], 0
    call InternetOpenUrlA
    test rax, rax
    jz .nf_close
    mov r14, rax
    mov dword [qlen], 4
    mov rcx, r14
    mov edx, 0x20000013
    lea r8, [netstatus]
    lea r9, [qlen]
    mov qword [rsp+32], 0
    call HttpQueryInfoA
.nf_read:
    mov rcx, r14
    lea rdx, [netbuf]
    add rdx, [netlen]
    mov r8, 262000
    sub r8, [netlen]
    lea r9, [netbytes]
    call InternetReadFile
    test eax, eax
    jz .nf_rclosed
    mov rax, [netbytes]
    test rax, rax
    jz .nf_rclosed
    add [netlen], rax
    mov rax, [netlen]
    cmp rax, 261000
    jb .nf_read
.nf_rclosed:
    lea rdi, [netbuf]
    add rdi, [netlen]
    mov byte [rdi], 0
    mov rcx, r14
    call InternetCloseHandle
.nf_close:
    test r13, r13
    jz .nf_done
    mov rcx, r13
    call InternetCloseHandle
.nf_done:
    add rsp, 56
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
do_httpget:
    push rbx
    push r12
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_STRING
    je .hstr
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .undef
    mov rcx, [rax+WD_TEXT_PTR]
    test rcx, rcx
    jz .adv
    call net_fetch
    jmp .adv
.hstr:
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    test rcx, rcx
    jz .adv
    call net_fetch
.adv:
    call advance
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
.undef:
    lea r8, [msg_undef]
    call fatal
do_netprint:
    push rbx
    sub rsp, 48
    call advance
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    lea rcx, [netbuf]
    call pstr
    add rsp, 48
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
do_netsave:
    push rbx
    push r12
    push r13
    sub rsp, 64
    call advance
    call curtype
    cmp al, T_STRING
    jne .bad
    mov rbx, [tcur]
    mov r12, [rbx+16]
    test r12, r12
    jz .adv
    mov rcx, r12
    mov edx, 0x40000000
    xor r8d, r8d
    xor r9d, r9d
    mov qword [rsp+32], 2
    mov qword [rsp+40], 0
    mov qword [rsp+48], 0
    call CreateFileA
    mov r13, rax
    cmp r13, -1
    je .adv
    mov rcx, r13
    lea rdx, [netbuf]
    mov r8, [netlen]
    lea r9, [netbytes]
    mov qword [rsp+32], 0
    call WriteFile
    mov rcx, r13
    call CloseHandle
.adv:
    call advance
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    add rsp, 64
    pop r13
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
do_nettext:
    push rbx
    push r12
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .undef
    mov r12, rax
    mov rcx, r12
    lea rdx, [netbuf]
    mov r8, [netlen]
    call wset_text
    call advance
    call curtype
    cmp al, T_SEMI
    jne .bad
    call advance
    call wrefresh
    add rsp, 40
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
    call fatal
.undef:
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
    cmp esi, WM_CHAR
    je .wchar
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
    cmp qword [r15+WD_HIDDEN], 0
    jne .wpdrawnext
    cmp qword [r15+WD_TYPE], 1
    je .wpdrawbtn
    cmp qword [r15+WD_TYPE], 2
    je .wpdrawlbl
    cmp qword [r15+WD_TYPE], 3
    je .wpdrawinp
    cmp qword [r15+WD_TYPE], 4
    je .wpdrawpan
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
    mov dword [rsp+32], (DT_WORDBREAK | DT_NOPREFIX)
    call DrawTextA
    jmp .wpdrawnext
.wpdrawpan:
    mov rcx, [r15+WD_COLOR]
    call CreateSolidBrush
    mov r13, rax
    mov rax, [r15+WD_RADIUS]
    test rax, rax
    jz .wppanrect
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
    mov rcx, r12
    mov rdx, r14
    mov r8, r13
    call FillRgn
    mov rcx, r14
    call DeleteObject
    mov rcx, r13
    call DeleteObject
    jmp .wpdrawnext
.wppanrect:
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
    jmp .wpdrawnext
.wpdrawinp:
    mov rcx, [r15+WD_COLOR]
    mov rax, [focus_wid]
    imul rax, rax, WIDGET_SIZE
    lea rax, [widgets + rax]
    cmp rax, r15
    jne .winpnf
    add rcx, 0x00181818
.winpnf:
    call CreateSolidBrush
    mov r13, rax
    mov rax, [r15+WD_RADIUS]
    test rax, rax
    jz .winprect
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
    mov rcx, r12
    mov rdx, r14
    mov r8, r13
    call FillRgn
    mov rcx, r14
    call DeleteObject
    jmp .winptxt
.winprect:
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
.winptxt:
    mov rcx, r13
    call DeleteObject
    mov rcx, r12
    mov edx, TRANSPARENT
    call SetBkMode
    mov rcx, r12
    mov edx, 0x00FFFFFF
    call SetTextColor
    mov eax, [r15+WD_X]
    add eax, 12
    mov [drawrect], eax
    mov eax, [r15+WD_Y]
    mov [drawrect+4], eax
    mov eax, [r15+WD_X]
    add eax, [r15+WD_W]
    sub eax, 12
    mov [drawrect+8], eax
    mov eax, [r15+WD_Y]
    add eax, [r15+WD_H]
    mov [drawrect+12], eax
    mov rcx, r12
    mov rdx, [r15+WD_TEXT_PTR]
    test rdx, rdx
    jnz .winptxt2
    lea rdx, [empty_str]
.winptxt2:
    mov r8, -1
    lea r9, [drawrect]
    mov dword [rsp+32], (DT_LEFT | DT_VCENTER | DT_SINGLELINE)
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
    mov qword [focus_wid], -1
    xor rbp, rbp
.wpclkloop:
    cmp rbp, [nwidgets]
    jae .wpclkdone
    imul r15, rbp, WIDGET_SIZE
    lea r15, [widgets + r15]
    cmp qword [r15+WD_HIDDEN], 0
    jne .wpclknext
    mov rax, [r15+WD_TYPE]
    cmp rax, 1
    je .wpclkbox
    cmp rax, 3
    jne .wpclknext
.wpclkbox:
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
    cmp qword [r15+WD_TYPE], 3
    jne .wpclkcb
    mov [focus_wid], rbp
    mov qword [focus_fresh], 1
    call wrefresh
    jmp .wpclkdone
.wpclkcb:
    mov rax, [r15+WD_CB_START]
    test rax, rax
    jz .wpclknext
    mov [cb_idx], rbp
    mov r13, [retflag]
    mov rax, [tcur]
    mov [cb_tcur], rax
    call frame_push
    mov rax, [r15+WD_CB_START]
    imul rax, rax, TOK_SIZE
    add rax, toks
    mov [tcur], rax
    mov qword [retflag], 0
    mov qword [retval], 0
    call run_block
    mov [retflag], r13
    call frame_pop
    mov rax, [cb_tcur]
    mov [tcur], rax
    mov rbp, [cb_idx]
.wpclknext:
    inc rbp
    jmp .wpclkloop
.wpclkdone:
    xor eax, eax
    jmp .wdone
.wchar:
    mov rax, [focus_wid]
    test rax, rax
    js .wcharout
    cmp rax, [nwidgets]
    jae .wcharout
    imul r15, rax, WIDGET_SIZE
    lea r15, [widgets + r15]
    cmp qword [r15+WD_TYPE], 3
    jne .wcharout
    mov r12, [r15+WD_TEXT_LEN]
    cmp r13, 8
    je .wcharbs
    cmp r13, 32
    jb .wcharout
    cmp r13, 126
    ja .wcharout
    cmp qword [focus_fresh], 0
    je .wcharadd
    xor r12, r12
    mov qword [focus_fresh], 0
.wcharadd:
    cmp r12, WD_TBUF_MAX-1
    jae .wcharout
    lea rdi, [r15+WD_TBUF]
    mov [rdi+r12], r13b
    inc r12
    mov byte [rdi+r12], 0
    mov [r15+WD_TEXT_LEN], r12
    mov [r15+WD_TEXT_PTR], rdi
    jmp .wcharrep
.wcharbs:
    mov qword [focus_fresh], 0
    test r12, r12
    jz .wcharout
    dec r12
    lea rdi, [r15+WD_TBUF]
    mov byte [rdi+r12], 0
    mov [r15+WD_TEXT_LEN], r12
    mov [r15+WD_TEXT_PTR], rdi
.wcharrep:
    call wrefresh
.wcharout:
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
