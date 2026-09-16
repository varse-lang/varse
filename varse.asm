bits 64
default rel
%define FILE_MAX 2097152
%define TOK_SIZE 32
%define SYM_SIZE 256
%define MAX_SYMS 4096
%define MAX_TOKS 32767
%define FSTACK_MAX 2048
%define PDEPTH_MAX 1024
%define PAGE_RW 0x04
%define MAX_FONTS 24
%define FONT_SIZE 72
%define FN_NAME_PTR 0
%define FN_NAME_LEN 8
%define FN_HFONT 16
%define FN_HEIGHT 24
%define FN_PT 48
%define FN_WEIGHT 56
%define FN_ITALIC 64
%define FN_NAMEBUF 24
%define WD_COLOR2 112
%define WD_FONT 120
%define WD_IMGW 4224
%define WD_IMGH 4232
%define WD_IMG 4240
%define WD_BX 4248
%define WD_BY 4256
%define WD_BW 4264
%define WD_BH 4272
%define CLEARTYPE_QUALITY 5
%define DEFAULT_CHARSET 1
%define OUT_TT_PRECIS 5
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
%define T_IMPORT 49
%define T_INCLUDE 50
%define T_MODNAME 51
%define T_FONT 52
%define T_IMAGE 53
%define T_CIRCLE 54
%define T_LINE 55
%define T_GRADIENT 56
%define T_TRIANGLE 57
%define T_LBRACKET 58
%define T_RBRACKET 59
%define T_WHILE 60
%define T_MOD 61
%define T_WEBVIEW 62
%define T_NAVIGATE 63
%define T_WVHTML 64
%define T_WVEXEC 65
%define SYM_TABLE 3
%define MAX_MODS 32
%define MOD_SIZE 24
%define MD_NAME_PTR 0
%define MD_NAME_LEN 8
%define MD_HANDLE 16
%define SYM_VAR 0
%define SYM_FN 1
%define SYM_STR 2
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
%define WM_ERASEBKGND 0x0014
%define WM_SIZE 0x0005
%define SRCCOPY 0x00CC0020
%define HALFTONE 4
%define DIB_RGB_COLORS 0
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
%define DT_CALCRECT 0x00000400
%define MEASURE_H 8192
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
    msg_undef_end db "'", 0
    msg_notfn db "thing is not callable", 0
    msg_wrongargs db "wrong number of arguments", 0
    msg_divzero db "division by zero", 0
    msg_strmix db "cannot mix a string with a number", 0
    msg_notstr db "expected a string", 0
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
    bi_nsym db "nsym", 0
    bi_ncall db "ncall", 0
    bi_nalloc db "nalloc", 0
    bi_npeek db "npeek", 0
    bi_npoke db "npoke", 0
    bi_strlen db "strlen", 0
    bi_str db "str", 0
    bi_nstr db "nstr", 0
    bi_lower db "lower", 0
    bi_upper db "upper", 0
    bi_trim db "trim", 0
    bi_indexof db "indexof", 0
    bi_substr db "substr", 0
    bi_replace db "replace", 0
    bi_val db "val", 0
    bi_floatstr db "floatstr", 0
    bi_table db "table", 0
    bi_tlen db "len", 0
    bi_fopen db "fopen", 0
    bi_fread db "fread", 0
    bi_fwrite db "fwrite", 0
    bi_fclose db "fclose", 0
    bi_errmsg db "errmsg", 0
    msg_openfail2 db "cannot open that file", 0
    mod_wview db "wview", 0
    mod_gui db "gui", 0
    mod_webview db "webview", 0
    msg_needgui db "this needs include @gui", 0
    sty_bold db "bold", 0
    sty_italic db "italic", 0
    sty_bolditalic db "bolditalic", 0
    msg_noimage db "could not load that image", 0
    dll_user32 db "user32.dll", 0
    sym_dpictx db "SetProcessDpiAwarenessContext", 0
    sym_dpiaware db "SetProcessDPIAware", 0
    guid_bgra:
    dd 0x6FDDC324
    dw 0x4E03
    dw 0x4BFE
    db 0xB1, 0x85, 0x3D, 0x77, 0x76, 0x8D, 0xC9, 0x0F
    clsid_wicfac:
    dd 0xCACAF262
    dw 0x9370
    dw 0x4615
    db 0xA1, 0x3B, 0x9F, 0x55, 0x39, 0xDA, 0x4C, 0x0A
    iid_wicfac:
    dd 0xEC5EC8A9
    dw 0xC395
    dw 0x4314
    db 0x9C, 0x77, 0x54, 0xD7, 0xA9, 0x35, 0xFF, 0x70
    dll_ext db ".dll", 0
    msg_needwv db "this needs include @wview", 0
    msg_nomod db "that module was never imported", 0
    msg_dllfail db "could not load that dll", 0
    msg_symfail db "no such function in that dll", 0
    msg_nomodname db "no such module", 0
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
    hextab db "0123456789ABCDEF", 0
    msg_badprefix db "invalid byte 0x", 0
    msg_insrc db " in source code", 0
    msg_badhex db "need at least one hex digit after #", 0
    msg_deep db "expression nested too deeply", 0
    msg_recur db "too much recursion", 0
    msg_needwv2 db "this needs include @webview", 0
    dll_webview2 db "WebView2Loader.dll", 0
    fn_createenv db "CreateCoreWebView2EnvironmentWithOptions", 0
    env_cb_vtable:
        dq webview_env_qi
        dq webview_env_addref
        dq webview_env_release
        dq webview_env_invoke
    ctrl_cb_vtable:
        dq webview_ctrl_qi
        dq webview_ctrl_addref
        dq webview_ctrl_release
        dq webview_ctrl_invoke
    IID_ICoreWebView2:
        dd 0x408E2F57
        dw 0x11CF
        dw 0x9640
        db 0x00, 0x26, 0xF5, 0x1D, 0x74, 0xE0, 0x40, 0x01
section .bss
    hout resq 1
    hfile resq 1
    src resb FILE_MAX
    srclen resq 1
    toks resb 1048576
    ntoks resq 1
    syms resb MAX_SYMS * SYM_SIZE
    nsyms resq 1
    tcur resq 1
    retflag resq 1
    retval resq 1
    fstack resq FSTACK_MAX
    fdepth resq 1
    pdepth resq 1
    errbuf resb 64
    argmode resq 1
    vtag resq 1
    retstr resq 1
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
    nmods resq 1
    modtab resb MOD_SIZE * MAX_MODS
    nmodbuf resb 256
    nsymbuf resb 256
    wviewon resq 1
    guion resq 1
    nfonts resq 1
    fonts resb FONT_SIZE * MAX_FONTS
    dpiv resq 1
    dpinum resq 1
    gpstate resq 1
    gptoken resb 64
    gpinput resb 64
    memdc resq 1
    membmp resq 1
    oldbmp resq 1
    wpath16 resb 2080
    wicfac resq 1
    wicsrc resq 1
    wicconv resq 1
    wicdec resq 1
    picw resq 1
    pich resq 1
    painthdc resq 1
    gpinit resq 1
    picmemdc resq 1
    picoldbm resq 1
    picstride resq 1
    znum resq 1
    zden resq 1
    fitrect resq 2
    geombase resq 1
    picbits resq 1
    iestep resq 1
    bmi resb 128
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
    errmsg_buf resb 256
    last_error resq 1
    wview2on resq 1
    webview_env resq 1
    webview_ctrl resq 1
    webview_core resq 1
    webview_hchild resq 1
    webview_inited resq 1
    webview_cb_obj resq 2
    webview_ctrl_obj resq 2
    webview_x resd 1
    webview_y resd 1
    webview_w resd 1
    webview_h resd 1
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
extern LoadLibraryA
extern GetProcAddress
extern VirtualAlloc
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
extern GetDC
extern ReleaseDC
extern GetDeviceCaps
extern MulDiv
extern CreateFontA
extern SelectObject
extern DeleteDC
extern CreateCompatibleDC
extern CreateCompatibleBitmap
extern BitBlt
extern StretchBlt
extern SetStretchBltMode
extern CreateDIBSection
extern CoInitializeEx
extern CoCreateInstance
extern GdiplusStartup
extern GdiplusShutdown
extern GdipCreateFromHDC
extern GdipDeleteGraphics
extern GdipSetSmoothingMode
extern GdipSetInterpolationMode
extern GdipCreateSolidFill
extern GdipDeleteBrush
extern GdipFillRectangleI
extern GdipFillEllipseI
extern GdipCreatePen1
extern GdipDeletePen
extern GdipDrawLineI
extern GdipCreatePath
extern GdipAddPathArcI
extern GdipClosePathFigure
extern GdipAddPathLineI
extern GdipFillPath
extern GdipDeletePath
extern GdipCreateLineBrushFromRectI
extern GdipCreateBitmapFromScan0
extern GdipDisposeImage
extern GdipDrawImageRectI
extern WICConvertBitmapSource
main:
    sub rsp, 56
    call dpi_init
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
str_num:
    push rbx
    push r12
    sub rsp, 24
    mov rbx, rcx
    mov rcx, 32
    call str_alloc
    test rax, rax
    jz .sn_fail
    mov r12, rax
    mov rcx, rbx
    mov rdx, r12
    call fmt_num
    mov rax, r12
    jmp .sn_out
.sn_fail:
    xor eax, eax
.sn_out:
    add rsp, 24
    pop r12
    pop rbx
    ret
str_len:
    mov rax, rcx
.sl_l:
    cmp byte [rax], 0
    je .sl_d
    inc rax
    jmp .sl_l
.sl_d:
    sub rax, rcx
    ret
str_cmp:
    push rbx
.sc_l:
    movzx eax, byte [rcx]
    movzx ebx, byte [rdx]
    cmp al, bl
    jne .sc_diff
    test al, al
    jz .sc_eq
    inc rcx
    inc rdx
    jmp .sc_l
.sc_diff:
    cmp al, bl
    jb .sc_lt
    mov rax, 1
    jmp .sc_out
.sc_lt:
    mov rax, -1
    jmp .sc_out
.sc_eq:
    xor eax, eax
.sc_out:
    pop rbx
    ret
str_alloc:
    sub rsp, 40
    mov rdx, rcx
    xor ecx, ecx
    mov r8d, 0x3000
    mov r9d, PAGE_RW
    call VirtualAlloc
    add rsp, 40
    ret
str_cat:
    push rbx
    push rsi
    push rdi
    push r12
    push r13
    push r14
    sub rsp, 40
    mov r12, rcx
    mov r13, rdx
    mov r14, rcx
    xor rbx, rbx
.ct_l1:
    cmp byte [r14], 0
    je .ct_l2
    inc r14
    inc rbx
    jmp .ct_l1
.ct_l2:
    mov r14, r13
.ct_l3:
    cmp byte [r14], 0
    je .ct_l4
    inc r14
    inc rbx
    jmp .ct_l3
.ct_l4:
    inc rbx
    mov rcx, rbx
    call str_alloc
    test rax, rax
    jz .ct_fail
    mov r14, rax
    mov rsi, r12
    mov rdi, rax
.ct_c1:
    movzx eax, byte [rsi]
    test al, al
    jz .ct_c2
    mov [rdi], al
    inc rdi
    inc rsi
    jmp .ct_c1
.ct_c2:
    mov rsi, r13
.ct_c3:
    movzx eax, byte [rsi]
    mov [rdi], al
    test al, al
    jz .ct_c4
    inc rdi
    inc rsi
    jmp .ct_c3
.ct_c4:
    mov rax, r14
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rdi
    pop rsi
    pop rbx
    ret
.ct_fail:
    lea r8, [msg_strmix]
    call fatal

str_lower:
    push rbx
    push rsi
    mov rbx, rcx
.sl_l:
    movzx eax, byte [rcx]
    test al, al
    jz .sl_d
    cmp al, 'A'
    jb .sl_n
    cmp al, 'Z'
    ja .sl_n
    add al, 32
    mov [rcx], al
.sl_n:
    inc rcx
    jmp .sl_l
.sl_d:
    mov rax, rbx
    pop rsi
    pop rbx
    ret

str_upper:
    push rbx
    push rsi
    mov rbx, rcx
.su_l:
    movzx eax, byte [rcx]
    test al, al
    jz .su_d
    cmp al, 'a'
    jb .su_n
    cmp al, 'z'
    ja .su_n
    sub al, 32
    mov [rcx], al
.su_n:
    inc rcx
    jmp .su_l
.su_d:
    mov rax, rbx
    pop rsi
    pop rbx
    ret

str_trim:
    push rbx
    push rsi
    push rdi
    mov rbx, rcx
.sl_l:
    movzx eax, byte [rcx]
    test al, al
    jz .st_done
    cmp al, ' '
    je .sl_skip
    cmp al, 9
    je .sl_skip
    jmp .sl_end
.sl_skip:
    inc rcx
    jmp .sl_l
.sl_end:
    mov rdi, rcx
.se_loop:
    movzx eax, byte [rdi]
    test al, al
    jz .se_found
    inc rdi
    jmp .se_loop
.se_found:
    dec rdi
.st_tloop:
    cmp rdi, rcx
    jb .st_twrite
    movzx eax, byte [rdi]
    cmp al, ' '
    je .st_ttrim
    cmp al, 9
    je .st_ttrim
    jmp .st_twrite
.st_ttrim:
    dec rdi
    jmp .st_tloop
.st_twrite:
    inc rdi
    mov byte [rdi], 0
.st_done:
    mov rax, rcx
    pop rdi
    pop rsi
    pop rbx
    ret

str_indexof:
    push rbx
    push rsi
    push r12
    push r13
    mov rbx, rcx
    mov r13, rcx
    mov r12, rdx
    test r12, r12
    jz .iempty
    cmp byte [r12], 0
    jz .iempty
.iseek:
    movzx eax, byte [rbx]
    test al, al
    jz .inotfound
    mov rsi, rbx
    mov rcx, r12
.ichk:
    movzx eax, byte [rcx]
    test al, al
    jz .ifound
    cmp byte [rsi], al
    jne .inext
    inc rsi
    inc rcx
    jmp .ichk
.inext:
    inc rbx
    jmp .iseek
.ifound:
    mov rax, rbx
    sub rax, r13
    jmp .iout
.inotfound:
    mov eax, -1
    jmp .iout
.iempty:
    mov eax, -1
    jmp .iout
.iout:
    pop r13
    pop r12
    pop rsi
    pop rbx
    ret

str_substr:
    push rbx
    push rsi
    push rdi
    push r12
    push r13
    push r14
    sub rsp, 40
    mov rbx, rcx
    mov r12, rdx
    mov r13, r8
    mov rcx, rbx
    call str_len
    cmp r12, rax
    jae .ssshort
    add rbx, r12
    mov r12, rbx
    mov rcx, r13
    test rcx, rcx
    jz .sslen_rest
    mov rcx, rbx
    call str_len
    cmp r13, rax
    jbe .sslen_ok
    mov r13, rax
.sslen_ok:
    jmp .ssalloc
.sslen_rest:
    mov rcx, r12
    call str_len
    mov r13, rax
.ssalloc:
    mov rcx, r13
    inc rcx
    call str_alloc
    test rax, rax
    jz .ssfail
    mov r14, rax
    mov rdi, rax
    mov rsi, r12
    mov rcx, r13
    rep movsb
    mov byte [rdi], 0
    mov rax, r14
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rdi
    pop rsi
    pop rbx
    ret
.ssshort:
    mov rcx, 1
    call str_alloc
    test rax, rax
    jz .ssfail
    mov byte [rax], 0
    jmp .ssout
.ssfail:
    xor eax, eax
.ssout:
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rdi
    pop rsi
    pop rbx
    ret

str_replace:
    push rbx
    push rsi
    push rdi
    push r12
    push r13
    push r14
    push r15
    sub rsp, 48
    mov rbx, rcx
    mov r12, rdx
    mov r13, r8
    mov rcx, rbx
    mov rdx, r12
    call str_indexof
    cmp rax, -1
    je .rnonew
    mov [rsp+32], rax
    mov rcx, rbx
    call str_len
    mov r14, rax
    mov rcx, r12
    call str_len
    mov [rsp+40], rax
    mov rcx, r13
    call str_len
    mov [rsp+48], rax
    mov rax, r14
    sub rax, [rsp+32]
    sub rax, [rsp+40]
    mov r15, rax
    mov rcx, [rsp+32]
    add rcx, [rsp+48]
    add rcx, r15
    inc rcx
    call str_alloc
    test rax, rax
    jz .rfail
    mov rdi, rax
    mov rsi, rbx
    mov rcx, [rsp+32]
    rep movsb
    mov rsi, r13
    mov rcx, [rsp+48]
    rep movsb
    mov rsi, rbx
    add rsi, [rsp+32]
    add rsi, [rsp+40]
    mov rcx, r15
    rep movsb
    mov byte [rdi], 0
    mov rax, rdi
    sub rax, r15
    sub rax, [rsp+48]
    sub rax, [rsp+32]
    add rsp, 48
    pop r15
    pop r14
    pop r13
    pop r12
    pop rdi
    pop rsi
    pop rbx
    ret
.rnonew:
    mov rax, rbx
    add rsp, 48
    pop r15
    pop r14
    pop r13
    pop r12
    pop rdi
    pop rsi
    pop rbx
    ret
.rfail:
    xor eax, eax
    add rsp, 48
    pop r15
    pop r14
    pop r13
    pop r12
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
pstr_len:
    push rbx
    sub rsp, 40
    mov r8, rdx
    mov rdx, rcx
    lea r9, [iop]
    mov rcx, [hout]
    mov qword [rsp+32], 0
    call WriteFile
    add rsp, 40
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
    lea r11, [toks]
    sub rax, r11
    cqo
    mov rcx, 32
    idiv rcx
    lea r11, [lines]
    mov rax, [r11 + rax*8]
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
    sub rsp, 8
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
    cmp byte [rsi], 0xEF
    jne .nobom
    cmp byte [rsi+1], 0xBB
    jne .nobom
    cmp byte [rsi+2], 0xBF
    jne .nobom
    add rsi, 3
.nobom:
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
    cmp al, ' '
    jb .badbyte
    cmp al, 0x7F
    jae .badbyte
    cmp al, 0x00
    je .badbyte
    cmp al, 0x01
    je .badbyte
    cmp al, 0x02
    je .badbyte
    cmp al, 0x03
    je .badbyte
    cmp al, 0x04
    je .badbyte
    cmp al, 0x05
    je .badbyte
    cmp al, 0x06
    je .badbyte
    cmp al, 0x07
    je .badbyte
    cmp al, 0x08
    je .badbyte
    cmp al, 0x0B
    je .badbyte
    cmp al, 0x0C
    je .badbyte
    cmp al, 0x0E
    je .badbyte
    cmp al, 0x0F
    je .badbyte
    cmp al, 0x10
    je .badbyte
    cmp al, 0x11
    je .badbyte
    cmp al, 0x12
    je .badbyte
    cmp al, 0x13
    je .badbyte
    cmp al, 0x14
    je .badbyte
    cmp al, 0x15
    je .badbyte
    cmp al, 0x16
    je .badbyte
    cmp al, 0x17
    je .badbyte
    cmp al, 0x18
    je .badbyte
    cmp al, 0x19
    je .badbyte
    cmp al, 0x1A
    je .badbyte
    cmp al, 0x1B
    je .badbyte
    cmp al, 0x1C
    je .badbyte
    cmp al, 0x1D
    je .badbyte
    cmp al, 0x1E
    je .badbyte
    cmp al, 0x1F
    je .badbyte
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
.badbyte:
    movzx rdx, byte [rsi]
    lea rdi, [errbuf]
    lea rsi, [msg_badprefix]
    mov rcx, 15
    rep movsb
    lea r11, [hextab]
    mov rax, rdx
    shr rax, 4
    and eax, 15
    mov al, [r11 + rax]
    mov [rdi], al
    inc rdi
    mov rax, rdx
    and eax, 15
    mov al, [r11 + rax]
    mov [rdi], al
    inc rdi
    lea rsi, [msg_insrc]
    mov rcx, 15
    rep movsb
    mov byte [rdi], 0
    lea r8, [errbuf]
    call fatal
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
    cmp al, '@'
    je .tat
    cmp al, '0'
    jb .fnonum
    cmp al, '9'
    jbe .tnum
.fnonum:
    cmp al, '_'
    je .tident
    cmp al, 'A'
    jb .fop
    cmp al, 'Z'
    jbe .tident
    cmp al, 'a'
    jb .fop
    cmp al, 'z'
    jbe .tident
    cmp al, 0xC0
    jb .fop
    cmp al, 0xD7
    ja .fop
    cmp al, 0xDF
    jb .fop
    cmp al, 0xF7
    ja .fop
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
.tat:
    inc rsi
    mov r13, rsi
.tatloop:
    movzx eax, byte [rsi]
    cmp al, '_'
    je .tatnext
    cmp al, '0'
    jb .tatdone
    cmp al, '9'
    jbe .tatnext
    cmp al, 'A'
    jb .tatdone
    cmp al, 'Z'
    jbe .tatnext
    cmp al, 'a'
    jb .tatdone
    cmp al, 'z'
    jbe .tatnext
    jmp .tatdone
.tatnext:
    inc rsi
    jmp .tatloop
.tatdone:
    mov byte [rdi], T_MODNAME
    mov qword [rdi+8], 0
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
    cmp al, 'A'
    jb .identdone
    cmp al, 'Z'
    jbe .tident
    cmp al, 'a'
    jb .identdone
    cmp al, 'z'
    jbe .tident
    cmp al, 0xC0
    jb .identdone
    cmp al, 0xD7
    ja .identdone
    cmp al, 0xDF
    jb .tident
    cmp al, 0xF7
    ja .identdone
    jmp .tident
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
    jne .chk4font
    cmp byte [r13+1], 'h'
    jne .store_ident
    cmp byte [r13+2], 'o'
    jne .store_ident
    cmp byte [r13+3], 'w'
    jne .store_ident
    mov byte [rdi], T_SHOW
    jmp .store_kw
.chk4font:
    cmp byte [r13], 'f'
    jne .chk4line
    cmp byte [r13+1], 'o'
    jne .store_ident
    cmp byte [r13+2], 'n'
    jne .store_ident
    cmp byte [r13+3], 't'
    jne .store_ident
    mov byte [rdi], T_FONT
    jmp .store_kw
.chk4line:
    cmp byte [r13], 'l'
    jne .store_ident
    cmp byte [r13+1], 'i'
    jne .store_ident
    cmp byte [r13+2], 'n'
    jne .store_ident
    cmp byte [r13+3], 'e'
    jne .store_ident
    mov byte [rdi], T_LINE
    jmp .store_kw
.chk5:
    cmp byte [r13], 'w'
    jne .chk5p
    cmp byte [r13+1], 'h'
    jne .store_ident
    cmp byte [r13+2], 'i'
    jne .store_ident
    cmp byte [r13+3], 'l'
    jne .store_ident
    cmp byte [r13+4], 'e'
    jne .store_ident
    mov byte [rdi], T_WHILE
    jmp .store_kw
.chk5p:
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
    cmp byte [r13+1], 'm'
    je .chk5image
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
.chk5image:
    cmp byte [r13+2], 'a'
    jne .store_ident
    cmp byte [r13+3], 'g'
    jne .store_ident
    cmp byte [r13+4], 'e'
    jne .store_ident
    mov byte [rdi], T_IMAGE
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
    je .chk6window
    cmp byte [r13+1], 'v'
    je .chk6wvhtml
    jmp .store_ident
.chk6window:
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
    jne .chk6import
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
.chk6import:
    cmp byte [r13], 'i'
    jne .chk6circle
    cmp byte [r13+1], 'm'
    jne .store_ident
    cmp byte [r13+2], 'p'
    jne .store_ident
    cmp byte [r13+3], 'o'
    jne .store_ident
    cmp byte [r13+4], 'r'
    jne .store_ident
    cmp byte [r13+5], 't'
    jne .store_ident
    mov byte [rdi], T_IMPORT
    jmp .store_kw
.chk6circle:
    cmp byte [r13], 'c'
    jne .chk6wvhtml
    cmp byte [r13+1], 'i'
    jne .store_ident
    cmp byte [r13+2], 'r'
    jne .store_ident
    cmp byte [r13+3], 'c'
    jne .store_ident
    cmp byte [r13+4], 'l'
    jne .store_ident
    cmp byte [r13+5], 'e'
    jne .store_ident
    mov byte [rdi], T_CIRCLE
    jmp .store_kw
.chk6wvhtml:
    cmp byte [r13], 'w'
    jne .store_ident
    cmp byte [r13+1], 'v'
    jne .chk6wvexec
    cmp byte [r13+2], 'h'
    jne .store_ident
    cmp byte [r13+3], 't'
    jne .store_ident
    cmp byte [r13+4], 'm'
    jne .store_ident
    cmp byte [r13+5], 'l'
    jne .store_ident
    mov byte [rdi], T_WVHTML
    jmp .store_kw
.chk6wvexec:
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 'x'
    jne .store_ident
    cmp byte [r13+3], 'e'
    jne .store_ident
    cmp byte [r13+4], 'c'
    jne .store_ident
    mov byte [rdi], T_WVEXEC
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
    cmp al, '['
    je .op_lbracket
    cmp al, ']'
    je .op_rbracket
    cmp al, '%'
    je .op_mod
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
.op_lbracket:
    mov byte [rdi], T_LBRACKET
    inc rsi
    jmp .op_store
.op_rbracket:
    mov byte [rdi], T_RBRACKET
    inc rsi
    jmp .op_store
.op_mod:
    mov byte [rdi], T_MOD
    inc rsi
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
    xor r11, r11
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
    inc r11
    inc rsi
    jmp .thexloop
.thexdone:
    test r11, r11
    jz .thexbad
    mov byte [rdi], T_NUM
    mov [rdi+8], rax
    mov qword [rdi+16], 0
    mov qword [rdi+24], 0
    call store_line
    add rdi, TOK_SIZE
    inc r12
    jmp .tloop
.thexbad:
    lea r8, [msg_badhex]
    call fatal
.chk7:
    cmp byte [r13], 'w'
    je .chk7webview
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
    jne .chk7include
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
.chk7include:
    cmp byte [r13], 'i'
    jne .store_ident
    cmp byte [r13+1], 'n'
    jne .store_ident
    cmp byte [r13+2], 'c'
    jne .store_ident
    cmp byte [r13+3], 'l'
    jne .store_ident
    cmp byte [r13+4], 'u'
    jne .store_ident
    cmp byte [r13+5], 'd'
    jne .store_ident
    cmp byte [r13+6], 'e'
    jne .store_ident
    mov byte [rdi], T_INCLUDE
    jmp .store_kw
.chk7webview:
    cmp byte [r13], 'w'
    jne .store_ident
    cmp byte [r13+1], 'e'
    jne .store_ident
    cmp byte [r13+2], 'b'
    jne .store_ident
    cmp byte [r13+3], 'v'
    jne .store_ident
    cmp byte [r13+4], 'i'
    jne .store_ident
    cmp byte [r13+5], 'e'
    jne .store_ident
    cmp byte [r13+6], 'w'
    jne .store_ident
    mov byte [rdi], T_WEBVIEW
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
    jne .chk8gradient
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
.chk8navigate:
    cmp byte [r13], 'n'
    jne .chk8gradient
    cmp byte [r13+1], 'a'
    jne .store_ident
    cmp byte [r13+2], 'v'
    jne .store_ident
    cmp byte [r13+3], 'i'
    jne .store_ident
    cmp byte [r13+4], 'g'
    jne .store_ident
    cmp byte [r13+5], 'a'
    jne .store_ident
    cmp byte [r13+6], 't'
    jne .store_ident
    cmp byte [r13+7], 'e'
    jne .store_ident
    mov byte [rdi], T_NAVIGATE
    jmp .store_kw
.chk8gradient:
    cmp byte [r13], 'g'
    jne .chk8triangle
    cmp byte [r13+1], 'r'
    jne .store_ident
    cmp byte [r13+2], 'a'
    jne .store_ident
    cmp byte [r13+3], 'd'
    jne .store_ident
    cmp byte [r13+4], 'i'
    jne .store_ident
    cmp byte [r13+5], 'e'
    jne .store_ident
    cmp byte [r13+6], 'n'
    jne .store_ident
    cmp byte [r13+7], 't'
    jne .store_ident
    mov byte [rdi], T_GRADIENT
    jmp .store_kw
.chk8triangle:
    cmp byte [r13], 't'
    jne .store_ident
    cmp byte [r13+1], 'r'
    jne .store_ident
    cmp byte [r13+2], 'i'
    jne .store_ident
    cmp byte [r13+3], 'a'
    jne .store_ident
    cmp byte [r13+4], 'n'
    jne .store_ident
    cmp byte [r13+5], 'g'
    jne .store_ident
    cmp byte [r13+6], 'l'
    jne .store_ident
    cmp byte [r13+7], 'e'
    jne .store_ident
    mov byte [rdi], T_TRIANGLE
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
    lea r11, [lines]
    mov [r11 + r12*8], rax
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
    lea r11, [syms]
    lea r14, [r13 + r11]
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
    lea r11, [toks]
    add rax, r11
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
    cmp rcx, FSTACK_MAX
    jae .fsfull
    lea r11, [fstack]
    mov [r11 + rcx*8], rax
    inc qword [fdepth]
    add rsp, 40
    ret
.fsfull:
    lea r8, [msg_recur]
    call fatal
frame_pop:
    sub rsp, 40
    dec qword [fdepth]
    mov rcx, [fdepth]
    lea r11, [fstack]
    mov rax, [r11 + rcx*8]
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
    mov r9, [vtag]
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
    lea r11, [toks]
    sub rax, r11
    cqo
    mov rcx, TOK_SIZE
    idiv rcx
    push rax
    mov rax, [tcur]
    lea r11, [toks]
    sub rax, r11
    cqo
    mov rcx, TOK_SIZE
    idiv rcx
    mov rdx, rax
    pop rcx
    mov rax, [nsyms]
    cmp rax, MAX_SYMS
    jae .full
    imul rdi, rax, SYM_SIZE
    lea r11, [syms]
    add rdi, r11
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
    cmp al, T_WHILE
    je .stwhile
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
    cmp al, T_IMPORT
    je .stimport
    cmp al, T_INCLUDE
    je .stinclude
    cmp al, T_FONT
    je .stfont
    cmp al, T_IMAGE
    je .stimage
    cmp al, T_CIRCLE
    je .stcircle
    cmp al, T_LINE
    je .stline
    cmp al, T_GRADIENT
    je .stgradient
    cmp al, T_TRIANGLE
    je .sttriangle
    cmp al, T_WEBVIEW
    je .stwebview
    cmp al, T_NAVIGATE
    je .stnavigate
    cmp al, T_WVHTML
    je .stwvhtml
    cmp al, T_WVEXEC
    je .stwvexec
    jmp .stexpr
.stimport:
    call do_import
    jmp .done
.stinclude:
    call do_include
    jmp .done
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
.stwhile:
    call do_while
    jmp .done
.stsemi:
    call advance
    jmp .done
.stwindow:
    call need_gui
    call do_window
    jmp .done
.stbutton:
    call need_gui
    call do_button
    jmp .done
.stlabel:
    call need_gui
    call do_label
    jmp .done
.stshow:
    call need_gui
    call do_show
    jmp .done
.stonclick:
    call need_gui
    call do_onclick
    jmp .done
.stsettext:
    call need_gui
    call do_settext
    jmp .done
.stsetnum:
    call need_gui
    call do_setnum
    jmp .done
.stsetcolor:
    call need_gui
    call do_setcolor
    jmp .done
.stsethide:
    call need_gui
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
    call need_gui
    mov ecx, 3
    call parse_rect_widget
    jmp .done
.stpanel:
    call need_gui
    mov ecx, 4
    call parse_rect_widget
    jmp .done
.sthtmlstrip:
    call need_wview
    call do_htmlstrip
    jmp .done
.sthtmltitle:
    call need_wview
    call do_htmltitle
    jmp .done
.sthtmlblock:
    call need_wview
    call do_htmlblock
    jmp .done
.stresetui:
    call do_resetui
    jmp .done
.stfont:
    call need_gui
    call do_font
    jmp .done
.stimage:
    call need_gui
    mov ecx, 5
    call parse_rect_widget
    jmp .done
.stcircle:
    call need_gui
    mov ecx, 6
    call parse_rect_widget
    jmp .done
.sttriangle:
    call need_gui
    mov ecx, 7
    call parse_rect_widget
    jmp .done
.stwebview:
    call do_webview
    jmp .done
.stnavigate:
    call do_navigate
    jmp .done
.stwvhtml:
    call do_wvhtml
    jmp .done
.stwvexec:
    call do_wvexec
    jmp .done
.stgradient:
    call need_gui
    mov ecx, 8
    call parse_rect_widget
    jmp .done
.stline:
    call need_gui
    mov ecx, 9
    call parse_rect_widget
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
    cmp qword [r12+SD_TYPE], SYM_FN
    je .atypeok
    mov rcx, [vtag]
    mov [r12+SD_TYPE], rcx
.atypeok:
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
    mov r9, [vtag]
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
    mov rcx, [vtag]
    mov [retstr], rcx
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
do_while:
    push rbx
    push r12
    push r13
    sub rsp, 40
    call advance
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    mov rbx, [tcur]
    call eval_expr
    mov r12, rax
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    test r12, r12
    jz .wskip
.wloop:
    mov r13, [retflag]
    call curtype
    cmp al, T_LBRACE
    jne .bad
    call advance
    call run_block
    mov [tcur], rbx
    mov [retflag], r13
    call eval_expr
    mov r12, rax
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    test r12, r12
    jnz .wloop
.wskip:
    call skip_block
.wdone:
    add rsp, 40
    pop r13
    pop r12
    pop rbx
    ret
.bad:
    lea r8, [msg_syntax]
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
    mov rax, [vtag]
    mov [rsp+32], rax
    call advance
    call eval_addsub
    mov rcx, rax
    mov rax, [vtag]
    or rax, [rsp+32]
    jnz .cstr
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
.cstr:
    mov rdx, rcx
    mov rcx, rbx
    call str_cmp
    mov rdx, rax
    cmp sil, T_EQEQ
    je .cstreq
    cmp sil, T_NE
    je .cstrne
    cmp sil, T_LT
    je .cstrlt
    cmp sil, T_GT
    je .cstrgt
    cmp sil, T_LE
    je .cstrle
    cmp rdx, 0
    setge al
    jmp .cstrfin
.cstreq:
    cmp rdx, 0
    sete al
    jmp .cstrfin
.cstrne:
    cmp rdx, 0
    setne al
    jmp .cstrfin
.cstrlt:
    cmp rdx, 0
    setl al
    jmp .cstrfin
.cstrgt:
    cmp rdx, 0
    setg al
    jmp .cstrfin
.cstrle:
    cmp rdx, 0
    setle al
.cstrfin:
    movzx rax, al
    mov rbx, rax
    mov qword [vtag], 0
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
    mov rax, [vtag]
    mov [rsp+32], rax
    call advance
    call eval_muldiv
    mov rcx, [vtag]
    mov rdx, [rsp+32]
    cmp sil, T_PLUS
    jne .asub
    test rdx, rdx
    jnz .acat
    test rcx, rcx
    jnz .astrbad
    add rbx, rax
    mov qword [vtag], 0
    jmp .aloop
.acat:
    test rcx, rcx
    jz .astrbad
    mov rcx, rbx
    mov rdx, rax
    call str_cat
    mov rbx, rax
    mov qword [vtag], SYM_STR
    jmp .aloop
.asub:
    test rdx, rdx
    jnz .astrbad
    test rcx, rcx
    jnz .astrbad
    sub rbx, rax
    mov qword [vtag], 0
    jmp .aloop
.astrbad:
    lea r8, [msg_strmix]
    call fatal
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
    mov rax, [vtag]
    mov [rsp+32], rax
.mloop:
    call curtype
    cmp al, T_STAR
    je .mop
    cmp al, T_SLASH
    je .mop
    cmp al, T_MOD
    je .mop
    jmp .mdone
.mop:
    mov rsi, rax
    call advance
    call eval_primary
    mov rcx, rax
    mov rax, [vtag]
    or rax, [rsp+32]
    jnz .mstrbad
    cmp sil, T_STAR
    jne .mchkdiv
    mov rax, rbx
    imul rax, rcx
    mov rbx, rax
    mov qword [vtag], 0
    mov qword [rsp+32], 0
    jmp .mloop
.mchkdiv:
    cmp sil, T_SLASH
    jne .mmod
    test rcx, rcx
    jz .zerodiv
    mov rax, rbx
    cqo
    idiv rcx
    mov rbx, rax
    mov qword [vtag], 0
    mov qword [rsp+32], 0
    jmp .mloop
.mmod:
    test rcx, rcx
    jz .zerodiv
    mov rax, rbx
    cqo
    idiv rcx
    mov rbx, rdx
    mov qword [vtag], 0
    mov qword [rsp+32], 0
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
.mstrbad:
    lea r8, [msg_strmix]
    call fatal
eval_primary:
    push rbx
    push r12
    push r13
    sub rsp, 256
    mov qword [vtag], 0
    call curtype
    cmp al, T_NUM
    je .pnum
    cmp al, T_IDENT
    je .pident
    cmp al, T_LPAREN
    je .pparen
    cmp al, T_MINUS
    je .pneg
    cmp al, T_STRING
    je .pstr
    jmp .bad
.pstr:
    mov rax, [tcur]
    mov rax, [rax+16]
    mov qword [vtag], SYM_STR
    call advance
    jmp .done
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
    lea r8, [bi_nsym]
    call mem_eq
    test rax, rax
    jnz .pbnsym
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_ncall]
    call mem_eq
    test rax, rax
    jnz .pbncall
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_nalloc]
    call mem_eq
    test rax, rax
    jnz .pbnalloc
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_npeek]
    call mem_eq
    test rax, rax
    jnz .pbnpeek
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_npoke]
    call mem_eq
    test rax, rax
    jnz .pbnpoke
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_nstr]
    call mem_eq
    test rax, rax
    jnz .pbnstr
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_strlen]
    call mem_eq
    test rax, rax
    jnz .pbstrlen
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_str]
    call mem_eq
    test rax, rax
    jz .pbnotstr
    call curtype
    cmp al, T_LPAREN
    je .pbstrnum
.pbnotstr:
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_lower]
    call mem_eq
    test rax, rax
    jnz .pblower
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_upper]
    call mem_eq
    test rax, rax
    jnz .pbupper
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_trim]
    call mem_eq
    test rax, rax
    jnz .pbtrim
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_indexof]
    call mem_eq
    test rax, rax
    jnz .pbindexof
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_substr]
    call mem_eq
    test rax, rax
    jnz .pbsubstr
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_replace]
    call mem_eq
    test rax, rax
    jnz .pbreplace
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_val]
    call mem_eq
    test rax, rax
    jnz .pbval
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_floatstr]
    call mem_eq
    test rax, rax
    jnz .pbfloatstr
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_table]
    call mem_eq
    test rax, rax
    jnz .pbtable
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_tlen]
    call mem_eq
    test rax, rax
    jnz .pblen
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_fopen]
    call mem_eq
    test rax, rax
    jnz .pbfopen
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_fread]
    call mem_eq
    test rax, rax
    jnz .pbfread
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_fwrite]
    call mem_eq
    test rax, rax
    jnz .pbfwrite
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_fclose]
    call mem_eq
    test rax, rax
    jnz .pbfclose
    mov rcx, r12
    mov rdx, r13
    lea r8, [bi_errmsg]
    call mem_eq
    test rax, rax
    jnz .pberrmsg
    mov rcx, r12
    mov rdx, r13
    call sym_find_name
    test rax, rax
    jz .undef
    mov r13, rax
    call curtype
    cmp al, T_LPAREN
    je .pbcall_fn
    cmp al, T_LBRACKET
    je .pbtableget
    jmp .pvarval2
.pbcall_fn:
    mov rcx, r13
    call eval_call
    jmp .done
.pbtableget:
    cmp qword [r13+SD_TYPE], SYM_TABLE
    jne .bad
    call advance
    call eval_expr
    mov [rsp+128], rax
    mov rcx, rax
    call str_len
    mov r12, rax
    mov rax, [r13+SD_VALUE]
    mov r14, rax
    mov r15, [r14]
    xor rbx, rbx
.tg_loop:
    cmp rbx, r15
    jae .tg_notfound
    imul rcx, rbx, 24
    add rcx, 16
    add rcx, r14
    mov rax, [rcx+8]
    cmp rax, r12
    jne .tg_next
    mov rsi, [rcx]
    mov rdi, [rsp+128]
    mov rdx, r12
.tg_cmp:
    test rdx, rdx
    jz .tg_found
    movzx eax, byte [rsi]
    cmp al, [rdi]
    jne .tg_next
    inc rsi
    inc rdi
    dec rdx
    jmp .tg_cmp
.tg_next:
    inc rbx
    jmp .tg_loop
.tg_found:
    imul rcx, rbx, 24
    add rcx, 16
    add rcx, r14
    mov rax, [rcx+16]
    mov r13, rax
    mov qword [vtag], 0
    call curtype
    cmp al, T_RBRACKET
    jne .bad
    call advance
    jmp .pbret
.tg_notfound:
    mov r13, 0
    mov qword [vtag], 0
    call curtype
    cmp al, T_RBRACKET
    jne .bad
    call advance
    jmp .pbret
.pvarval2:
    mov rax, [r13+SD_VALUE]
    cmp qword [r13+SD_TYPE], SYM_STR
    jne .pvarfin2
    mov qword [vtag], SYM_STR
.pvarfin2:
    cmp qword [r13+SD_TYPE], SYM_TABLE
    jne .pvarfin3
    mov qword [vtag], SYM_TABLE
.pvarfin3:
    jmp .done
.pbsts:
    mov r13, [netstatus]
    jmp .pbparen
.pblen2:
    mov r13, [netlen]
    jmp .pbparen
.pbcssbg:
    call need_wview
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
    call need_wview
    lea rcx, [needle_fg]
    mov edx, '-'
    call css_lookup
    mov r13, rax
    jmp .pbparen
.pbblocks:
    call need_wview
    xor ecx, ecx
    xor edx, edx
    xor r8d, r8d
    call blk_scan
    mov r13, rax
    jmp .pbparen
.pbblocklen:
    call need_wview
    call blk_arg
    mov rdx, rax
    mov ecx, 2
    xor r8d, r8d
    call blk_scan
    mov r13, rax
    jmp .pbret
.pbblocktag:
    call need_wview
    call blk_arg
    mov rdx, rax
    mov ecx, 3
    xor r8d, r8d
    call blk_scan
    mov r13, rax
    jmp .pbret
.pbnstr:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call curtype
    cmp al, T_STRING
    jne .bad
    mov rbx, [tcur]
    mov r13, [rbx+16]
    call advance
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbstrlen:
    lea rcx, [rsp]
    call nargs
    cmp rax, 1
    jne .bad
    mov rcx, [rsp]
    call str_len
    mov r13, rax
    jmp .pbret
.pbstrnum:
    lea rcx, [rsp]
    call nargs
    cmp rax, 1
    jne .bad
    mov rcx, [rsp]
    call str_num
    mov r13, rax
    mov qword [vtag], SYM_STR
    jmp .pbret
.pblower:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    cmp qword [vtag], 0
    je .bad
    mov rcx, rax
    call str_lower
    mov r13, rax
    mov qword [vtag], SYM_STR
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbupper:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    cmp qword [vtag], 0
    je .bad
    mov rcx, rax
    call str_upper
    mov r13, rax
    mov qword [vtag], SYM_STR
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbtrim:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    cmp qword [vtag], 0
    je .bad
    mov rcx, rax
    call str_trim
    mov r13, rax
    mov qword [vtag], SYM_STR
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbindexof:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov [rsp+128], rax
    mov rcx, [vtag]
    mov [rsp+136], rcx
    call curtype
    cmp al, T_PLUS
    je .bioc
    cmp al, T_COMMA
    jne .bad
.bioc:
    call advance
    call eval_expr
    mov rdx, rax
    mov rcx, [rsp+128]
    call str_indexof
    mov r13, rax
    mov qword [vtag], 0
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbsubstr:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov [rsp+128], rax
    call curtype
    cmp al, T_PLUS
    je .bsc1
    cmp al, T_COMMA
    jne .bad
.bsc1:
    call advance
    call eval_expr
    mov r12, rax
    call curtype
    cmp al, T_PLUS
    je .bsc2
    cmp al, T_COMMA
    je .bsc2
    mov rcx, [rsp+128]
    xor edx, edx
    mov r8, r12
    call str_substr
    mov r13, rax
    mov qword [vtag], SYM_STR
    jmp .pbret
.bsc2:
    call advance
    call eval_expr
    mov r8, rax
    mov rcx, [rsp+128]
    mov rdx, r12
    call str_substr
    mov r13, rax
    mov qword [vtag], SYM_STR
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbreplace:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov [rsp+128], rax
    call curtype
    cmp al, T_PLUS
    je .brc1
    cmp al, T_COMMA
    jne .bad
.brc1:
    call advance
    call eval_expr
    mov [rsp+136], rax
    call curtype
    cmp al, T_PLUS
    je .brc2
    cmp al, T_COMMA
    jne .bad
.brc2:
    call advance
    call eval_expr
    mov rcx, [rsp+128]
    mov rdx, [rsp+136]
    mov r8, rax
    call str_replace
    mov r13, rax
    mov qword [vtag], SYM_STR
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbval:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    cmp qword [vtag], 0
    je .bad
    mov rcx, rax
    call str_len
    mov r13, rax
    mov qword [vtag], 0
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbfloatstr:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov rcx, rax
    call str_num
    mov r13, rax
    mov qword [vtag], SYM_STR
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbtable:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    mov rcx, 4096
    call str_alloc
    test rax, rax
    jz .bad
    mov qword [rax], 0
    mov qword [rax+8], 510
    mov r13, rax
    mov qword [vtag], SYM_TABLE
    jmp .pbret
.pblen:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    cmp qword [vtag], SYM_TABLE
    jne .bad
    mov r13, [rax]
    mov qword [vtag], 0
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbfopen:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov rbx, rax
    call curtype
    cmp al, T_PLUS
    je .bfc1
    cmp al, T_COMMA
    jne .bad
.bfc1:
    call advance
    call eval_expr
    mov rcx, rbx
    mov edx, 0x80000000
    test rax, rax
    jz .bfc_read
    mov edx, 0x40000000
.bfc_read:
    xor r8d, r8d
    xor r9d, r9d
    mov dword [rsp+32], 3
    mov qword [rsp+40], 0
    mov qword [rsp+48], 0
    call CreateFileA
    cmp rax, -1
    jne .bfc_ok
    mov r13, 0
    lea r8, [msg_openfail2]
    mov [last_error], r8
    jmp .bfc_done
.bfc_ok:
    mov r13, rax
.bfc_done:
    mov qword [vtag], 0
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbfread:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov rbx, rax
    call curtype
    cmp al, T_PLUS
    je .bfr1
    cmp al, T_COMMA
    jne .bad
.bfr1:
    call advance
    call eval_expr
    mov r12, rax
    mov rcx, r12
    call str_alloc
    test rax, rax
    jz .bad
    mov r13, rax
    mov rcx, rbx
    mov rdx, r13
    mov r8, r12
    lea r9, [iop]
    mov qword [rsp+32], 0
    call ReadFile
    mov rax, [iop]
    mov byte [r13+rax], 0
    mov r13, r13
    mov qword [vtag], SYM_STR
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbfwrite:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov rbx, rax
    call curtype
    cmp al, T_PLUS
    je .bfw1
    cmp al, T_COMMA
    jne .bad
.bfw1:
    call advance
    call eval_expr
    mov r12, rax
    call curtype
    cmp al, T_PLUS
    je .bfw2
    cmp al, T_COMMA
    jne .bad
.bfw2:
    call advance
    call eval_expr
    mov r13, rax
    mov rcx, rbx
    mov rdx, r12
    mov r8, r13
    lea r9, [iop]
    mov qword [rsp+32], 0
    call WriteFile
    mov r13, rax
    mov qword [vtag], 0
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pbfclose:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call eval_expr
    mov rcx, rax
    call CloseHandle
    mov r13, rax
    mov qword [vtag], 0
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    jmp .pbret
.pberrmsg:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    mov rax, [last_error]
    test rax, rax
    jnz .pbem_got
    lea rax, [empty_str]
.pbem_got:
    mov r13, rax
    mov qword [vtag], SYM_STR
    jmp .pbret
.pbnsym:
    call curtype
    cmp al, T_LPAREN
    jne .bad
    call advance
    call curtype
    cmp al, T_MODNAME
    jne .bad
    mov rbx, [tcur]
    mov rax, [rbx+16]
    mov [rsp+112], rax
    mov rax, [rbx+24]
    mov [rsp+120], rax
    call advance
    call curtype
    cmp al, T_COMMA
    je .pbnsc
    cmp al, T_PLUS
    jne .bad
.pbnsc:
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bad
    mov rbx, [tcur]
    mov rax, [rbx+16]
    mov [rsp+128], rax
    mov rax, [rbx+24]
    mov [rsp+136], rax
    call advance
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    mov rcx, [rsp+120]
    cmp rcx, 200
    ja .bad
    mov rcx, [rsp+136]
    cmp rcx, 200
    ja .bad
    mov rcx, [rsp+112]
    mov rdx, [rsp+120]
    call findmod
    test rax, rax
    jz .pbnom
    mov rbx, rax
    lea rcx, [nsymbuf]
    mov rdx, [rsp+128]
    mov r8, [rsp+136]
    call dupnul
    mov rcx, rbx
    lea rdx, [nsymbuf]
    call GetProcAddress
    test rax, rax
    jz .pbnosym
    mov r13, rax
    jmp .pbret
.pbnom:
    lea r8, [msg_nomod]
    call fatal
.pbnosym:
    lea r8, [msg_symfail]
    call fatal
.pbncall:
    lea rcx, [rsp]
    call nargs
    cmp rax, 1
    jb .bad
    mov rbx, rax
    mov r12, [rsp]
    test r12, r12
    jz .bad
    sub rsp, 96
    mov qword [rsp+32], 0
    mov qword [rsp+40], 0
    mov qword [rsp+48], 0
    mov qword [rsp+56], 0
    mov qword [rsp+64], 0
    mov qword [rsp+72], 0
    mov qword [rsp+80], 0
    mov qword [rsp+88], 0
    cmp rbx, 2
    jb .nccall
    mov rcx, [rsp+104]
    cmp rbx, 3
    jb .nccall
    mov rdx, [rsp+112]
    cmp rbx, 4
    jb .nccall
    mov r8, [rsp+120]
    cmp rbx, 5
    jb .nccall
    mov r9, [rsp+128]
    cmp rbx, 6
    jb .nccall
    mov rax, [rsp+136]
    mov [rsp+32], rax
    cmp rbx, 7
    jb .nccall
    mov rax, [rsp+144]
    mov [rsp+40], rax
    cmp rbx, 8
    jb .nccall
    mov rax, [rsp+152]
    mov [rsp+48], rax
    cmp rbx, 9
    jb .nccall
    mov rax, [rsp+160]
    mov [rsp+56], rax
    cmp rbx, 10
    jb .nccall
    mov rax, [rsp+168]
    mov [rsp+64], rax
    cmp rbx, 11
    jb .nccall
    mov rax, [rsp+176]
    mov [rsp+72], rax
    cmp rbx, 12
    jb .nccall
    mov rax, [rsp+184]
    mov [rsp+80], rax
    cmp rbx, 13
    jb .nccall
    mov rax, [rsp+192]
    mov [rsp+88], rax
.nccall:
    call r12
    add rsp, 96
    mov r13, rax
    jmp .pbret
.pbnalloc:
    lea rcx, [rsp]
    call nargs
    cmp rax, 1
    jne .bad
    xor ecx, ecx
    mov rdx, [rsp]
    mov r8d, 0x3000
    mov r9d, 0x40
    call VirtualAlloc
    mov r13, rax
    jmp .pbret
.pbnpeek:
    lea rcx, [rsp]
    call nargs
    cmp rax, 1
    jne .bad
    mov rcx, [rsp]
    test rcx, rcx
    jz .bad
    mov r13, [rcx]
    jmp .pbret
.pbnpoke:
    lea rcx, [rsp]
    call nargs
    cmp rax, 2
    jne .bad
    mov rcx, [rsp]
    test rcx, rcx
    jz .bad
    mov rax, [rsp+8]
    mov [rcx], rax
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
    cmp qword [r13+SD_TYPE], SYM_STR
    jne .pvarfin
    mov qword [vtag], SYM_STR
.pvarfin:
    jmp .done
.pparen:
    inc qword [pdepth]
    cmp qword [pdepth], PDEPTH_MAX
    jae .pdeep
    mov rbx, [argmode]
    mov qword [argmode], 0
    call advance
    call eval_expr
    mov [argmode], rbx
    dec qword [pdepth]
    push rax
    call curtype
    cmp al, T_RPAREN
    jne .bad
    call advance
    pop rax
    jmp .done
.pdeep:
    lea r8, [msg_deep]
    call fatal
.pneg:
    call advance
    call eval_primary
    neg rax
    jmp .done
.bad:
    lea r8, [msg_syntax]
    call fatal
.undef:
    lea rdi, [errbuf]
    lea rsi, [msg_undef]
    mov rcx, 16
    rep movsb
    mov rsi, r12
    mov rcx, r13
    rep movsb
    mov byte [rdi], "'"
    inc rdi
    mov byte [rdi], 0
    lea r8, [errbuf]
    call fatal
.done:
    add rsp, 256
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
    sub rsp, 224
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
    mov rcx, [vtag]
    mov [rsp + 160 + rbx*8], rcx
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
    mov r9, r14
    shl r9, 3
    mov r9, [rsp + r9 + 160]
    call sym_add_var
    test rax, rax
    jz .symfull
    inc r14
    jmp .bind
.bound:
    mov rax, [retflag]
    mov [rsp+136], rax
    mov rax, [r12+SD_BODY_START]
    imul rax, TOK_SIZE
    lea r11, [toks]
    add rax, r11
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
    mov rax, [retstr]
    mov [vtag], rax
    mov rax, [retval]
    jmp .done
.bad:
    lea r8, [msg_syntax]
    call fatal
.wargs:
    lea r8, [msg_wrongargs]
    call fatal
.symfull:
    lea r8, [msg_full]
    call fatal
.done:
    add rsp, 224
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
sym_find_name:
    push rbx
    push rsi
    push rdi
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
    lea r11, [syms]
    add r14, r11
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
    pop rdi
    pop rsi
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
    lea r11, [syms]
    add r12, r11
    mov [r12+SD_NAME_PTR], rcx
    mov [r12+SD_NAME_LEN], rdx
    mov [r12+SD_VALUE], r8
    mov [r12+SD_TYPE], r9
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
    lea r11, [widgets]
    add r14, r11
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
    lea r11, [widgets]
    add rbx, r11
    mov qword [rbx+WD_TYPE], 0
    mov qword [rbx+WD_X], 0
    mov qword [rbx+WD_Y], 0
    mov qword [rbx+WD_BX], 0
    mov qword [rbx+WD_BY], 0
    mov qword [rbx+WD_BW], 0
    mov qword [rbx+WD_BH], 0
    mov qword [rbx+WD_COLOR], 0x00FFFFFF
    mov qword [rbx+WD_RADIUS], 0
    mov qword [rbx+WD_CB_START], 0
    mov qword [rbx+WD_CB_END], 0
    mov qword [rbx+WD_NAME_PTR], 0
    mov qword [rbx+WD_NAME_LEN], 0
    mov [rsp+32], rbx
    mov rcx, rbx
    call wtext_here
    test rax, rax
    jz .wbad
    call curtype
    cmp al, T_NUM
    jne .wbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_BW], rax
    call dscal
    mov [rbx+WD_W], rax
    call advance
    call curtype
    cmp al, T_NUM
    jne .wbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rbx+WD_BH], rax
    call dscal
    mov [rbx+WD_H], rax
    call advance
.wproloop:
    call curtype
    cmp al, T_SEMI
    je .wdone
    cmp al, T_FONT
    jne .wid
    call prop_font
    jmp .wproloop
.wid:
    cmp al, T_IDENT
    jne .wdone
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    cmp rdx, 4
    je .wchkfont
    jmp .wchkbg
.wchkfont:
    cmp byte [rcx], 'f'
    jne .wchkbg
    cmp byte [rcx+1], 'o'
    jne .wchkbg
    cmp byte [rcx+2], 'n'
    jne .wchkbg
    cmp byte [rcx+3], 't'
    jne .wchkbg
    call advance
    call curtype
    cmp al, T_EQ
    jne .wbad
    call advance
    call curtype
    cmp al, T_IDENT
    jne .wbad
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    call find_font
    mov [rbx+WD_FONT], rax
    call advance
    jmp .wproloop
.wchkbg:
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
    call eval_expr
    mov [rbx+WD_COLOR], rax
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
    lea r11, [widgets]
    add rbx, r11
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
    mov [rbx+WD_BX], rax
    call dscal
    mov [rbx+WD_X], rax
    call eval_expr
    mov [rbx+WD_BY], rax
    call dscal
    mov [rbx+WD_Y], rax
    call eval_expr
    mov [rbx+WD_BW], rax
    call dscal
    mov [rbx+WD_W], rax
    call eval_expr
    mov [rbx+WD_BH], rax
    call dscal
    mov [rbx+WD_H], rax
    mov rcx, rbx
    call wtext_here
    test rax, rax
    jz .bbad
.bproloop:
    call curtype
    cmp al, T_SEMI
    je .bdone
    cmp al, T_FONT
    jne .bid
    call prop_font
    jmp .bproloop
.bid:
    cmp al, T_IDENT
    jne .bdone
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    cmp rdx, 4
    je .bchkfont
    jmp .bchkradius
.bchkfont:
    cmp byte [rcx], 'f'
    jne .bchkradius
    cmp byte [rcx+1], 'o'
    jne .bchkradius
    cmp byte [rcx+2], 'n'
    jne .bchkradius
    cmp byte [rcx+3], 't'
    jne .bchkradius
    call advance
    call curtype
    cmp al, T_EQ
    jne .bbad
    call advance
    call curtype
    cmp al, T_IDENT
    jne .bbad
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    call find_font
    mov [rbx+WD_FONT], rax
    call advance
    jmp .bproloop
.bchkradius:
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
    lea r11, [widgets]
    add rbx, r11
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
    mov [rbx+WD_BX], rax
    call dscal
    mov [rbx+WD_X], rax
    call eval_expr
    mov [rbx+WD_BY], rax
    call dscal
    mov [rbx+WD_Y], rax
    call eval_expr
    mov [rbx+WD_BW], rax
    call dscal
    mov [rbx+WD_W], rax
    call eval_expr
    mov [rbx+WD_BH], rax
    call dscal
    mov [rbx+WD_H], rax
    mov rcx, rbx
    call wtext_here
    test rax, rax
    jz .lbad
.lproloop:
    call curtype
    cmp al, T_SEMI
    je .ldone
    cmp al, T_FONT
    jne .lid
    call prop_font
    jmp .lproloop
.lid:
    cmp al, T_IDENT
    jne .ldone
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    cmp rdx, 4
    je .lchkfont
    jmp .lchkcolor
.lchkfont:
    cmp byte [rcx], 'f'
    jne .lchkcolor
    cmp byte [rcx+1], 'o'
    jne .lchkcolor
    cmp byte [rcx+2], 'n'
    jne .lchkcolor
    cmp byte [rcx+3], 't'
    jne .lchkcolor
    call advance
    call curtype
    cmp al, T_EQ
    jne .lbad
    call advance
    call curtype
    cmp al, T_IDENT
    jne .lbad
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    call find_font
    mov [rbx+WD_FONT], rax
    call advance
    jmp .lproloop
.lchkcolor:
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
    lea r11, [toks]
    sub rax, r11
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
    lea r11, [toks]
    sub rax, r11
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
wtext_here:
    push rbx
    push rsi
    push rdi
    push r12
    sub rsp, 24
    mov rbx, rcx
    call curtype
    cmp al, T_STRING
    je .wh_lit
    cmp al, T_IDENT
    jne .wh_none
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    call sym_find_name
    test rax, rax
    jz .wh_none
    cmp qword [rax+SD_TYPE], SYM_STR
    jne .wh_none
    mov r12, rax
    mov rcx, [r12+SD_VALUE]
    call str_len
    mov r8, rax
    mov rcx, rbx
    mov rdx, [r12+SD_VALUE]
    call wset_text
    call advance
    mov rax, 1
    jmp .wh_out
.wh_lit:
    mov r12, [tcur]
    mov rcx, rbx
    mov rdx, [r12+16]
    mov r8, [r12+24]
    call wset_text
    call advance
    mov rax, 1
    jmp .wh_out
.wh_none:
    xor eax, eax
.wh_out:
    add rsp, 24
    pop r12
    pop rdi
    pop rsi
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
    call eval_expr
    mov [rsp+32], rax
    mov rcx, [vtag]
    test rcx, rcx
    jz .notstr
    mov rcx, [rsp+32]
    call str_len
    mov r8, rax
    mov rcx, r12
    mov rdx, [rsp+32]
    call wset_text
    jmp .stadv
.notstr:
    lea r8, [msg_notstr]
    call fatal
.stadv:
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
    call eval_expr
    mov rbx, [vtag]
    test rbx, rbx
    jz .pnum
    mov rcx, rax
    test rcx, rcx
    jz .pdone
    call pstr
    jmp .pdone
.pnum:
    mov rcx, rax
    call pint
.pdone:
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
    lea r11, [netbuf]
    cmp rbx, r11
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
    lea r11, [widgets]
    add rbx, r11
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
    mov [geombase], rax
    call dscal
    mov rdx, [geombase]
    cmp r13, 0
    je .rwgx
    cmp r13, 1
    je .rwgy
    cmp r13, 2
    je .rwgw
    mov [rbx+WD_BH], rdx
    mov [rbx+WD_H], rax
    jmp .rwgn
.rwgx:
    mov [rbx+WD_BX], rdx
    mov [rbx+WD_X], rax
    jmp .rwgn
.rwgy:
    mov [rbx+WD_BY], rdx
    mov [rbx+WD_Y], rax
    jmp .rwgn
.rwgw:
    mov [rbx+WD_BW], rdx
    mov [rbx+WD_W], rax
.rwgn:
    inc r13
    jmp .rwgeom
.rwgeomdone:
    cmp r13, 4
    jb .rwbad
    mov rcx, rbx
    call wtext_here
.rwprops:
    call curtype
    cmp al, T_SEMI
    je .rwdone
    cmp al, T_FONT
    jne .rwid
    call prop_font
    jmp .rwprops
.rwid:
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
    jne .rwchkfont
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
.rwchkfont:
    cmp rdx, 4
    jne .rwchkc2
    cmp byte [rcx], 'f'
    jne .rwchkc2
    cmp byte [rcx+1], 'o'
    jne .rwchkc2
    cmp byte [rcx+2], 'n'
    jne .rwchkc2
    cmp byte [rcx+3], 't'
    jne .rwchkc2
    call advance
    call curtype
    cmp al, T_EQ
    jne .rwbad
    call advance
    call curtype
    cmp al, T_IDENT
    jne .rwbad
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    call find_font
    mov [rbx+WD_FONT], rax
    call advance
    jmp .rwprops
.rwchkc2:
    cmp rdx, 2
    jne .rwskip
    cmp byte [rcx], 'c'
    jne .rwskip
    cmp byte [rcx+1], '2'
    jne .rwskip
    call advance
    call curtype
    cmp al, T_EQ
    jne .rwbad
    call advance
    call eval_expr
    mov [rbx+WD_COLOR2], rax
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
need_wview:
    cmp qword [wviewon], 0
    je .nwbad
    ret
.nwbad:
    sub rsp, 8
    lea r8, [msg_needwv]
    call fatal
need_gui:
    cmp qword [guion], 0
    je .ngbad
    ret
.ngbad:
    sub rsp, 8
    lea r8, [msg_needgui]
    call fatal
appendext:
    push rsi
    push rdi
    mov rdi, rcx
    mov rsi, rdx
    mov rcx, r8
    rep movsb
    lea rsi, [dll_ext]
    mov rcx, 4
    rep movsb
    mov byte [rdi], 0
    pop rdi
    pop rsi
    ret
dupnul:
    push rsi
    push rdi
    mov rdi, rcx
    mov rsi, rdx
    mov rcx, r8
    rep movsb
    mov byte [rdi], 0
    pop rdi
    pop rsi
    ret
findmod:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 40
    mov rbx, rcx
    mov r13, rdx
    mov r12, [nmods]
    test r12, r12
    jz .fmno
.fmloop:
    dec r12
    imul r14, r12, MOD_SIZE
    lea r11, [modtab]
    add r14, r11
    mov rax, [r14+MD_NAME_LEN]
    cmp rax, r13
    jne .fmnext
    mov rsi, rbx
    mov rdi, [r14+MD_NAME_PTR]
    mov rcx, r13
    repe cmpsb
    jne .fmnext
    mov rax, [r14+MD_HANDLE]
    jmp .fmdone
.fmnext:
    test r12, r12
    jz .fmno
    jmp .fmloop
.fmno:
    xor eax, eax
.fmdone:
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
nargs:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 48
    mov r12, rcx
    mov rax, [argmode]
    mov [rsp+40], rax
    call curtype
    cmp al, T_LPAREN
    jne .nabad
    call advance
    xor rbx, rbx
    call curtype
    cmp al, T_RPAREN
    je .nadone
.naloop:
    mov qword [argmode], 1
    call eval_expr
    mov [r12 + rbx*8], rax
    mov qword [argmode], 0
    inc rbx
    cmp rbx, 12
    jae .nadone
    call curtype
    cmp al, T_PLUS
    je .namore
    cmp al, T_COMMA
    je .namore
    jmp .nadone
.namore:
    call advance
    jmp .naloop
.nadone:
    call curtype
    cmp al, T_RPAREN
    jne .nabad
    call advance
    mov rax, rbx
    mov rcx, [rsp+40]
    mov [argmode], rcx
    jmp .naout
.nabad:
    lea r8, [msg_syntax]
    call fatal
.naout:
    add rsp, 48
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
wfont_pick:
    mov rax, [rcx+WD_FONT]
    test rax, rax
    jz .wfp_win
    dec rax
    imul rax, FONT_SIZE
    lea r11, [fonts]
    add rax, r11
    mov rax, [rax+FN_HFONT]
    ret
.wfp_win:
    push rbx
    push r12
    xor r12, r12
.wfp_loop:
    cmp r12, [nwidgets]
    jae .wfp_none
    imul rax, r12, WIDGET_SIZE
    lea r11, [widgets]
    add rax, r11
    cmp qword [rax+WD_TYPE], 0
    je .wfp_got
    inc r12
    jmp .wfp_loop
.wfp_got:
    mov rax, [rax+WD_FONT]
    test rax, rax
    jz .wfp_none
    dec rax
    imul rax, FONT_SIZE
    lea r11, [fonts]
    add rax, r11
    mov rax, [rax+FN_HFONT]
    pop r12
    pop rbx
    ret
.wfp_none:
    xor eax, eax
    pop r12
    pop rbx
    ret
wfont_on:
    push rbx
    push r12
    sub rsp, 40
    mov rbx, rcx
    mov r12, rdx
    mov rcx, r12
    call wfont_pick
    test rax, rax
    jz .wfo_none
    mov rcx, rbx
    mov rdx, rax
    call SelectObject
    jmp .wfo_out
.wfo_none:
    xor eax, eax
.wfo_out:
    add rsp, 40
    pop r12
    pop rbx
    ret
wfont_off:
    test rdx, rdx
    jz .wff_out
    sub rsp, 40
    call SelectObject
    add rsp, 40
.wff_out:
    ret
gp_init:
    cmp qword [gpinit], 0
    jne .gi_done
    sub rsp, 40
    mov qword [gpinput], 1
    mov qword [gpinput+8], 0
    mov qword [gpinput+16], 0
    xor ecx, ecx
    mov edx, 2
    call CoInitializeEx
    lea rcx, [gptoken]
    lea rdx, [gpinput]
    xor r8d, r8d
    call GdiplusStartup
    mov qword [gpinit], 1
    add rsp, 40
.gi_done:
    ret
gp_begin:
    push rbx
    sub rsp, 32
    mov rbx, rcx
    call gp_init
    mov rcx, rbx
    lea rdx, [gpstate]
    call GdipCreateFromHDC
    mov rcx, [gpstate]
    test rcx, rcx
    jz .gb_none
    mov edx, 4
    call GdipSetSmoothingMode
    mov rcx, [gpstate]
    mov edx, 7
    call GdipSetInterpolationMode
    mov rax, [gpstate]
    jmp .gb_out
.gb_none:
    xor eax, eax
.gb_out:
    add rsp, 32
    pop rbx
    ret
gp_end:
    test rcx, rcx
    jz .ge_out
    sub rsp, 40
    call GdipDeleteGraphics
    mov qword [gpstate], 0
    add rsp, 40
.ge_out:
    ret
do_font:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 64
    call advance
    call curtype
    cmp al, T_IDENT
    jne .fnbad
    mov rbx, [tcur]
    mov r12, [rbx+16]
    mov r13, [rbx+24]
    call advance
    call curtype
    cmp al, T_STRING
    jne .fnbad
    mov rbx, [tcur]
    mov r14, [rbx+16]
    call advance
    call curtype
    cmp al, T_NUM
    jne .fnbad
    mov rax, [tcur]
    mov rax, [rax+8]
    mov [rsp+32], rax
    mov qword [rsp+40], 0
    mov qword [rsp+48], 400
    call advance
.fnstyle:
    call curtype
    cmp al, T_IDENT
    jne .fndone
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    lea r8, [sty_bold]
    call mem_eq
    test rax, rax
    jz .fnitalic
    mov qword [rsp+48], 700
    jmp .fnnext
.fnitalic:
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    lea r8, [sty_italic]
    call mem_eq
    test rax, rax
    jz .fnbolditalic
    mov qword [rsp+40], 1
    jmp .fnnext
.fnbolditalic:
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    lea r8, [sty_bolditalic]
    call mem_eq
    test rax, rax
    jz .fnnext
    mov qword [rsp+48], 700
    mov qword [rsp+40], 1
.fnnext:
    call advance
    jmp .fnstyle
.fndone:
    call curtype
    cmp al, T_SEMI
    jne .fnbad
    call advance
    mov rax, [nfonts]
    cmp rax, MAX_FONTS
    jae .fnbad
    mov rbx, [rsp+48]
    mov r15, [rsp+40]
    sub rsp, 48
    xor ecx, ecx
    call GetDC
    mov [rsp+32], rax
    mov rcx, rax
    mov edx, 90
    call GetDeviceCaps
    mov [dpiv], rax
    xor ecx, ecx
    mov rdx, [rsp+32]
    call ReleaseDC
    add rsp, 48
    mov rcx, [rsp+32]
    call fsize
    mov rcx, rax
    mov rdx, rbx
    mov r8, r15
    mov r9, r14
    call font_make
    test rax, rax
    jz .fnbad
    mov rcx, [nfonts]
    imul rcx, FONT_SIZE
    lea r11, [fonts]
    add rcx, r11
    mov [rcx+FN_NAME_PTR], r12
    mov [rcx+FN_NAME_LEN], r13
    mov [rcx+FN_HFONT], rax
    mov rdx, [rsp+32]
    mov [rcx+FN_PT], rdx
    mov rdx, [rsp+48]
    mov [rcx+FN_WEIGHT], rdx
    mov rdx, [rsp+40]
    mov [rcx+FN_ITALIC], rdx
    mov rdx, r13
    cmp rdx, 23
    jbe .fnb_ok
    mov rdx, 23
.fnb_ok:
    push rdi
    push rsi
    mov rdi, rcx
    add rdi, FN_NAMEBUF
    mov rsi, r12
    mov rcx, rdx
    rep movsb
    mov byte [rdi], 0
    pop rsi
    pop rdi
    inc qword [nfonts]
    add rsp, 64
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.fnbad:
    lea r8, [msg_syntax]
    call fatal
wic_release:
    sub rsp, 40
    mov rcx, [wicconv]
    test rcx, rcx
    jz .wr2
    mov rax, [rcx]
    call qword [rax+16]
    mov qword [wicconv], 0
.wr2:
    mov rcx, [wicsrc]
    test rcx, rcx
    jz .wr3
    mov rax, [rcx]
    call qword [rax+16]
    mov qword [wicsrc], 0
.wr3:
    mov rcx, [wicdec]
    test rcx, rcx
    jz .wr4
    mov rax, [rcx]
    call qword [rax+16]
    mov qword [wicdec], 0
.wr4:
    mov rcx, [wicfac]
    test rcx, rcx
    jz .wr5
    mov rax, [rcx]
    call qword [rax+16]
    mov qword [wicfac], 0
.wr5:
    add rsp, 40
    ret
img_ensure:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 64
    mov rbx, rcx
    cmp qword [rbx+WD_IMG], 0
    jne .ie_out
    mov r12, [rbx+WD_TEXT_PTR]
    test r12, r12
    jz .ie_out
    call gp_init
    lea rdi, [wpath16]
    xor r13, r13
.ie_conv:
    movzx eax, byte [r12+r13]
    mov [rdi+r13*2], ax
    test al, al
    jz .ie_convdone
    inc r13
    cmp r13, 1000
    jb .ie_conv
.ie_convdone:
    mov word [rdi+r13*2], 0
    lea rcx, [clsid_wicfac]
    xor edx, edx
    mov r8d, 1
    lea r9, [iid_wicfac]
    lea rax, [wicfac]
    mov [rsp+32], rax
    call CoCreateInstance
    mov [iestep], rax
    test eax, eax
    jnz .ie_fail
    mov rcx, [wicfac]
    lea rdx, [wpath16]
    xor r8d, r8d
    mov r9d, 0x80000000
    mov qword [rsp+32], 0
    lea rax, [wicdec]
    mov [rsp+40], rax
    mov rax, [rcx]
    call qword [rax+24]
    mov [iestep], rax
    test eax, eax
    jnz .ie_fail
    mov rcx, [wicdec]
    xor edx, edx
    lea r8, [wicsrc]
    mov rax, [rcx]
    call qword [rax+104]
    mov [iestep], rax
    test eax, eax
    jnz .ie_fail
    mov rcx, [wicsrc]
    lea rdx, [picw]
    lea r8, [pich]
    mov rax, [rcx]
    call qword [rax+24]
    mov [iestep], rax
    lea rcx, [guid_bgra]
    mov rdx, [wicsrc]
    lea r8, [wicconv]
    call WICConvertBitmapSource
    mov [iestep], rax
    test eax, eax
    jnz .ie_fail
    mov rax, [picw]
    or rax, [pich]
    jz .ie_fail
    mov rax, [picw]
    shl rax, 2
    mov [picstride], rax
    lea rdi, [bmi]
    xor eax, eax
    mov ecx, 16
    rep stosq
    mov dword [bmi], 40
    mov eax, [picw]
    mov [bmi+4], eax
    mov eax, [pich]
    neg eax
    mov [bmi+8], eax
    mov word [bmi+12], 1
    mov word [bmi+14], 32
    xor ecx, ecx
    lea rdx, [bmi]
    xor r8d, r8d
    lea r9, [picbits]
    mov qword [rsp+32], 0
    mov qword [rsp+40], 0
    call CreateDIBSection
    test rax, rax
    jz .ie_fail
    mov [rbx+WD_IMG], rax
    mov rcx, [wicconv]
    xor edx, edx
    mov r8, [picstride]
    mov rax, [pich]
    imul rax, r8
    mov r9, rax
    mov rax, [picbits]
    mov [rsp+32], rax
    mov rax, [rcx]
    call qword [rax+56]
    mov rax, [picw]
    mov [rbx+WD_IMGW], rax
    mov rax, [pich]
    mov [rbx+WD_IMGH], rax
    cmp qword [rbx+WD_W], 0
    jne .ie_kw
    mov rcx, [rbx+WD_IMGW]
    mov edx, 96
    mov r8, [dpinum]
    call MulDiv
    mov [rbx+WD_BW], rax
    call dscal
    mov [rbx+WD_W], rax
.ie_kw:
    cmp qword [rbx+WD_H], 0
    jne .ie_kh
    mov rcx, [rbx+WD_IMGH]
    mov edx, 96
    mov r8, [dpinum]
    call MulDiv
    mov [rbx+WD_BH], rax
    call dscal
    mov [rbx+WD_H], rax
.ie_kh:
    call wic_release
.ie_out:
    add rsp, 64
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.ie_fail:
    call wic_release
    lea r8, [msg_noimage]
    call fatal
draw_shape:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 56
    mov rbx, rcx
    mov r12, rdx
    mov rcx, r12
    call gp_begin
    test rax, rax
    jz .ds_out
    mov r13, rax
    mov rax, [rbx+WD_X]
    mov [drawrect], eax
    mov rax, [rbx+WD_Y]
    mov [drawrect+4], eax
    mov rax, [rbx+WD_W]
    mov [drawrect+8], eax
    mov rax, [rbx+WD_H]
    mov [drawrect+12], eax
    mov rax, [rbx+WD_TYPE]
    cmp rax, 6
    je .ds_circle
    cmp rax, 7
    je .ds_tri
    cmp rax, 8
    je .ds_grad
    cmp rax, 9
    je .ds_line
    jmp .ds_end
.ds_circle:
    mov rax, [rbx+WD_COLOR]
    call cargb
    mov rcx, rax
    lea rdx, [rsp+32]
    call GdipCreateSolidFill
    mov r14, [rsp+32]
    test r14, r14
    jz .ds_end
    mov rcx, r13
    mov rdx, r14
    mov r8, [rbx+WD_X]
    mov r9, [rbx+WD_Y]
    mov rax, [rbx+WD_W]
    mov [rsp+32], rax
    mov rax, [rbx+WD_H]
    mov [rsp+40], rax
    call GdipFillEllipseI
    mov rcx, r14
    call GdipDeleteBrush
    jmp .ds_end
.ds_tri:
    mov rax, [rbx+WD_COLOR]
    call cargb
    mov rcx, rax
    lea rdx, [rsp+32]
    call GdipCreateSolidFill
    mov r14, [rsp+32]
    test r14, r14
    jz .ds_end
    xor ecx, ecx
    lea rdx, [rsp+40]
    call GdipCreatePath
    mov rcx, [rsp+40]
    test rcx, rcx
    jz .ds_tri_no
    mov rdx, [rbx+WD_X]
    mov rax, [rbx+WD_W]
    shr rax, 1
    add rdx, rax
    mov r8, [rbx+WD_Y]
    mov r9, [rbx+WD_X]
    mov rax, [rbx+WD_Y]
    add rax, [rbx+WD_H]
    mov [rsp+32], rax
    call GdipAddPathLineI
    mov rcx, [rsp+40]
    mov rdx, [rbx+WD_X]
    mov r8, [rbx+WD_Y]
    add r8, [rbx+WD_H]
    mov r9, [rbx+WD_X]
    add r9, [rbx+WD_W]
    mov rax, [rbx+WD_Y]
    add rax, [rbx+WD_H]
    mov [rsp+32], rax
    call GdipAddPathLineI
    mov rcx, [rsp+40]
    mov rdx, [rbx+WD_X]
    add rdx, [rbx+WD_W]
    mov r8, [rbx+WD_Y]
    add r8, [rbx+WD_H]
    mov r9, [rbx+WD_X]
    mov rax, [rbx+WD_W]
    shr rax, 1
    add r9, rax
    mov rax, [rbx+WD_Y]
    mov [rsp+32], rax
    call GdipAddPathLineI
    mov rcx, [rsp+40]
    call GdipClosePathFigure
    mov rcx, r13
    mov rdx, r14
    mov r8, [rsp+40]
    call GdipFillPath
    mov rcx, [rsp+40]
    call GdipDeletePath
.ds_tri_no:
    mov rcx, r14
    call GdipDeleteBrush
    jmp .ds_end
.ds_grad:
    lea rcx, [drawrect]
    mov rax, [rbx+WD_COLOR]
    call cargb
    mov rdx, rax
    mov rax, [rbx+WD_COLOR2]
    call cargb
    mov r8, rax
    xor r9d, r9d
    mov qword [rsp+32], 0
    lea rax, [rsp+48]
    mov [rsp+40], rax
    call GdipCreateLineBrushFromRectI
    mov r14, [rsp+48]
    test r14, r14
    jz .ds_end
    mov rcx, r13
    mov rdx, r14
    mov r8, [rbx+WD_X]
    mov r9, [rbx+WD_Y]
    mov rax, [rbx+WD_W]
    mov [rsp+32], rax
    mov rax, [rbx+WD_H]
    mov [rsp+40], rax
    call GdipFillRectangleI
    mov rcx, r14
    call GdipDeleteBrush
    jmp .ds_end
.ds_line:
    mov rax, [rbx+WD_COLOR]
    call cargb
    mov rcx, rax
    mov rax, [rbx+WD_RADIUS]
    call dscal
    test rax, rax
    jnz .ds_lw
    mov eax, 1
.ds_lw:
    cvtsi2ss xmm1, rax
    xor r8d, r8d
    lea r9, [rsp+32]
    call GdipCreatePen1
    mov r14, [rsp+32]
    test r14, r14
    jz .ds_end
    mov rcx, r13
    mov rdx, r14
    mov r8, [rbx+WD_X]
    mov r9, [rbx+WD_Y]
    mov rax, [rbx+WD_W]
    mov [rsp+32], rax
    mov rax, [rbx+WD_H]
    mov [rsp+40], rax
    call GdipDrawLineI
    mov rcx, r14
    call GdipDeletePen
.ds_end:
    mov rcx, r13
    call gp_end
.ds_out:
    add rsp, 56
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
find_font:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 40
    mov r12, rcx
    mov r13, rdx
    xor r14, r14
.ff_loop:
    cmp r14, [nfonts]
    jae .ff_none
    imul rbx, r14, FONT_SIZE
    lea r11, [fonts]
    add rbx, r11
    mov rcx, r12
    mov rdx, r13
    lea r8, [rbx+FN_NAMEBUF]
    call mem_eq
    test rax, rax
    jnz .ff_got
    inc r14
    jmp .ff_loop
.ff_got:
    lea rax, [r14+1]
    jmp .ff_out
.ff_none:
    xor eax, eax
.ff_out:
    add rsp, 40
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
prop_font:
    sub rsp, 8
    call advance
    call curtype
    cmp al, T_EQ
    jne .pf_bad
    call advance
    call curtype
    cmp al, T_IDENT
    jne .pf_bad
    mov r12, [tcur]
    mov rcx, [r12+16]
    mov rdx, [r12+24]
    call find_font
    mov [rbx+WD_FONT], rax
    call advance
    add rsp, 8
    ret
.pf_bad:
    lea r8, [msg_syntax]
    call fatal
do_import:
    push rbx
    push r12
    push r13
    sub rsp, 48
    call advance
    call curtype
    cmp al, T_MODNAME
    jne .dibad
    mov rbx, [tcur]
    mov r12, [rbx+16]
    mov r13, [rbx+24]
    call advance
    cmp r13, 200
    ja .dibad
    mov rcx, [nmods]
    cmp rcx, MAX_MODS
    jae .dibad
    lea rcx, [nmodbuf]
    mov rdx, r12
    mov r8, r13
    call appendext
    lea rcx, [nmodbuf]
    call LoadLibraryA
    test rax, rax
    jz .difail
    mov rcx, [nmods]
    imul rcx, MOD_SIZE
    lea r11, [modtab]
    add rcx, r11
    mov [rcx+MD_NAME_PTR], r12
    mov [rcx+MD_NAME_LEN], r13
    mov [rcx+MD_HANDLE], rax
    inc qword [nmods]
    call curtype
    cmp al, T_SEMI
    jne .dibad
    call advance
    jmp .didone
.difail:
    lea r8, [msg_dllfail]
    call fatal
.dibad:
    lea r8, [msg_syntax]
    call fatal
.didone:
    add rsp, 48
    pop r13
    pop r12
    pop rbx
    ret
cargb:
    mov r11, 0xFF000000
    or rax, r11
    ret
colref:
    mov r11, rax
    and r11, 0xFF
    shl r11, 16
    mov r10, rax
    shr r10, 16
    and r10, 0xFF
    and rax, 0x0000FF00
    or rax, r11
    or rax, r10
    ret
dscal:
    push rdx
    push r11
    test rax, rax
    jz .dsc_out
    mov r11, [dpinum]
    test r11, r11
    jz .dsc_zoom
    imul rax, r11
    cqo
    mov r11, 96
    idiv r11
.dsc_zoom:
    mov r11, [zden]
    test r11, r11
    jz .dsc_out
    mov rdx, [znum]
    cmp rdx, r11
    je .dsc_out
    imul rax, rdx
    cqo
    idiv r11
.dsc_out:
    pop r11
    pop rdx
    ret
fsize:
    push rbx
    push r12
    mov r12, 72
    mov rax, [dpiv]
    test rax, rax
    jnz .fs_have
    mov eax, 96
.fs_have:
    imul rcx, rax
    mov rdx, [zden]
    test rdx, rdx
    jz .fs_div
    mov rax, [znum]
    imul rcx, rax
    imul r12, rdx
.fs_div:
    mov rax, rcx
    cqo
    idiv r12
    test rax, rax
    jnz .fs_neg
    mov eax, 1
.fs_neg:
    neg rax
    pop r12
    pop rbx
    ret
font_make:
    push rbx
    sub rsp, 112
    mov rbx, r9
    mov [rsp+32], rdx
    mov [rsp+40], r8
    mov qword [rsp+48], 0
    mov qword [rsp+56], 0
    mov qword [rsp+64], DEFAULT_CHARSET
    mov qword [rsp+72], OUT_TT_PRECIS
    mov qword [rsp+80], 0
    mov qword [rsp+88], CLEARTYPE_QUALITY
    mov qword [rsp+96], 0
    mov [rsp+104], rbx
    xor edx, edx
    xor r8d, r8d
    xor r9d, r9d
    call CreateFontA
    add rsp, 112
    pop rbx
    ret
font_rebuild:
    push rbx
    push r12
    sub rsp, 48
    xor r12, r12
.fr_loop:
    cmp r12, [nfonts]
    jae .fr_done
    imul rbx, r12, FONT_SIZE
    lea r11, [fonts]
    add rbx, r11
    mov rcx, [rbx+FN_HFONT]
    test rcx, rcx
    jz .fr_next
    call DeleteObject
    mov qword [rbx+FN_HFONT], 0
    mov rcx, [rbx+FN_PT]
    call fsize
    mov rcx, rax
    mov rdx, [rbx+FN_WEIGHT]
    mov r8, [rbx+FN_ITALIC]
    mov r9, [rbx+FN_NAME_PTR]
    call font_make
    mov [rbx+FN_HFONT], rax
.fr_next:
    inc r12
    jmp .fr_loop
.fr_done:
    add rsp, 48
    pop r12
    pop rbx
    ret
rescale_all:
    push rbx
    push r12
    push r13
    sub rsp, 48
    mov r13, rcx
    mov rax, [zden]
    test rax, rax
    jz .ra_done
    mov [znum], r13
    call font_rebuild
    xor r12, r12
.ra_loop:
    cmp r12, [nwidgets]
    jae .ra_done
    imul rbx, r12, WIDGET_SIZE
    lea r11, [widgets]
    add rbx, r11
    mov rax, [rbx+WD_BX]
    call dscal
    mov [rbx+WD_X], rax
    mov rax, [rbx+WD_BY]
    call dscal
    mov [rbx+WD_Y], rax
    mov rax, [rbx+WD_BW]
    call dscal
    mov [rbx+WD_W], rax
    mov rax, [rbx+WD_BH]
    call dscal
    mov [rbx+WD_H], rax
    inc r12
    jmp .ra_loop
.ra_done:
    add rsp, 48
    pop r13
    pop r12
    pop rbx
    ret
wfit:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 56
    mov rbx, rdx
    mov r12, rcx
    mov rax, [rbx+WD_TYPE]
    cmp rax, 1
    jb .wf_out
    cmp rax, 3
    ja .wf_out
    mov r13, [rbx+WD_TEXT_PTR]
    test r13, r13
    jnz .wf_txt
    cmp rax, 3
    je .wf_blank
    lea r13, [default_title]
    jmp .wf_txt
.wf_blank:
    lea r13, [empty_str]
.wf_txt:
    mov rcx, r12
    mov rdx, rbx
    call wfont_on
    mov [rsp+48], rax
    mov eax, [rbx+WD_X]
    mov [fitrect], eax
    mov eax, [rbx+WD_Y]
    mov [fitrect+4], eax
    mov eax, [rbx+WD_X]
    add eax, [rbx+WD_W]
    mov [fitrect+8], eax
    mov eax, [rbx+WD_Y]
    add eax, MEASURE_H
    mov [fitrect+12], eax
    mov eax, [rbx+WD_TYPE]
    cmp eax, 1
    jne .wf_t2
    mov eax, (DT_CENTER | DT_SINGLELINE)
    jmp .wf_flags
.wf_t2:
    cmp eax, 2
    jne .wf_t3
    mov eax, (DT_WORDBREAK | DT_NOPREFIX)
    jmp .wf_flags
.wf_t3:
    mov eax, (DT_LEFT | DT_SINGLELINE)
.wf_flags:
    or eax, DT_CALCRECT
    mov [rsp+32], eax
    mov rcx, r12
    mov rdx, r13
    mov r8d, -1
    lea r9, [fitrect]
    call DrawTextA
    mov rcx, r12
    mov rdx, [rsp+48]
    call wfont_off
    mov eax, [fitrect+12]
    sub eax, [fitrect+4]
    mov edx, eax
    add edx, 2
    mov ecx, [rbx+WD_H]
    cmp edx, ecx
    jbe .wf_out
    movsxd rax, eax
    mov [rbx+WD_H], rax
    mov r8, [dpinum]
    test r8, r8
    jz .wf_out
    mov rcx, rax
    mov edx, 96
    call MulDiv
    mov [rbx+WD_BH], rax
.wf_out:
    add rsp, 56
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

tfit:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 56
    mov rbx, rcx
    mov r12, rdx
    mov r13, r9
    mov r14d, r8d
    mov [rsp+40], r10d
    mov [rsp+48], r11d
    mov eax, [r13]
    mov [fitrect], eax
    mov eax, [r13+4]
    mov [fitrect+4], eax
    mov eax, [r13+8]
    mov [fitrect+8], eax
    mov eax, [r13+4]
    add eax, MEASURE_H
    mov [fitrect+12], eax
    mov rcx, rbx
    mov rdx, r12
    mov r8d, r14d
    lea r9, [fitrect]
    mov eax, [rsp+40]
    and eax, ~DT_VCENTER
    or eax, DT_CALCRECT
    mov [rsp+32], eax
    call DrawTextA
    mov eax, [fitrect+12]
    sub eax, [fitrect+4]
    mov ecx, [r13+12]
    sub ecx, [r13+4]
    cmp eax, ecx
    jbe .tf_out
    cmp dword [rsp+48], 0
    je .tf_top
    sub eax, ecx
    mov edx, eax
    shr edx, 1
    mov r8d, [r13+4]
    sub r8d, edx
    mov [r13+4], r8d
    add r8d, ecx
    add r8d, eax
    mov [r13+12], r8d
    jmp .tf_out
.tf_top:
    mov edx, [r13+4]
    add edx, eax
    mov [r13+12], edx
.tf_out:
    add rsp, 56
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
dpi_init:
    push rbx
    push r12
    sub rsp, 40
    lea rcx, [dll_user32]
    call LoadLibraryA
    test rax, rax
    jz .di_read
    mov rbx, rax
    mov rcx, rbx
    lea rdx, [sym_dpictx]
    call GetProcAddress
    test rax, rax
    jz .di_old
    mov rcx, -4
    call rax
    jmp .di_read
.di_old:
    mov rcx, rbx
    lea rdx, [sym_dpiaware]
    call GetProcAddress
    test rax, rax
    jz .di_read
    call rax
.di_read:
    xor ecx, ecx
    call GetDC
    test rax, rax
    jz .di_std
    mov r12, rax
    mov rcx, r12
    mov edx, 88
    call GetDeviceCaps
    mov rbx, rax
    xor ecx, ecx
    mov rdx, r12
    call ReleaseDC
    cmp rbx, 96
    jl .di_std
    cmp rbx, 480
    jg .di_std
    mov [dpinum], rbx
    jmp .di_done
.di_std:
    mov qword [dpinum], 96
.di_done:
    add rsp, 40
    pop r12
    pop rbx
    ret
do_include:
    push rbx
    push r12
    push r13
    sub rsp, 48
    call advance
    call curtype
    cmp al, T_MODNAME
    jne .icbad
    mov rbx, [tcur]
    mov r12, [rbx+16]
    mov r13, [rbx+24]
    call advance
    mov rcx, r12
    mov rdx, r13
    lea r8, [mod_wview]
    call mem_eq
    test rax, rax
    jnz .icwview
    mov rcx, r12
    mov rdx, r13
    lea r8, [mod_gui]
    call mem_eq
    test rax, rax
    jnz .icgui
    mov rcx, r12
    mov rdx, r13
    lea r8, [mod_webview]
    call mem_eq
    test rax, rax
    jz .icnom
    mov qword [wview2on], 1
    jmp .icok
.icgui:
    mov qword [guion], 1
    jmp .icok
.icwview:
    mov qword [wviewon], 1
.icok:
    call curtype
    cmp al, T_SEMI
    jne .icbad
    call advance
    jmp .icdone
.icnom:
    lea r8, [msg_nomodname]
    call fatal
.icbad:
    lea r8, [msg_syntax]
    call fatal
.icdone:
    add rsp, 48
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
    lea r11, [widgets]
    add rbx, r11
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
    mov qword [rbx+WD_BX], 0
    mov qword [rbx+WD_BY], 0
    mov eax, 800
    mov [rbx+WD_BW], rax
    call dscal
    mov [rbx+WD_W], rax
    mov eax, 600
    mov [rbx+WD_BH], rax
    call dscal
    mov [rbx+WD_H], rax
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
    lea rdx, [clientrect]
    call GetClientRect
    mov eax, [clientrect+8]
    sub eax, [clientrect]
    mov [zden], rax
    mov [znum], rax
    mov rcx, [hwnd_main]
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
    sub rsp, 96
    mov rbx, rcx
    mov esi, edx
    mov r13, r8
    mov r14, r9
    cmp esi, WM_ERASEBKGND
    je .werase
    cmp esi, WM_SIZE
    je .wsize
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
    mov [painthdc], rax
    mov rcx, rbx
    lea rdx, [clientrect]
    call GetClientRect
    mov rcx, r12
    call CreateCompatibleDC
    mov [memdc], rax
    mov rcx, r12
    mov edx, [clientrect+8]
    sub edx, [clientrect]
    mov r8d, [clientrect+12]
    sub r8d, [clientrect+4]
    call CreateCompatibleBitmap
    mov [membmp], rax
    mov rcx, [memdc]
    mov rdx, rax
    call SelectObject
    mov [oldbmp], rax
    mov r12, [memdc]
    xor ebp, ebp
.wpfindbg:
    cmp rbp, [nwidgets]
    jae .wpnobg
    imul r15, rbp, WIDGET_SIZE
    lea r11, [widgets]
    add r15, r11
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
    mov rax, rbp
    call colref
    mov rcx, rax
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
    lea r11, [widgets]
    add r15, r11
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
    cmp qword [r15+WD_TYPE], 5
    je .wpdrawimg
    cmp qword [r15+WD_TYPE], 6
    jae .wpdrawshp
    jmp .wpdrawnext
.wpdrawshp:
    mov rcx, r15
    mov rdx, r12
    call draw_shape
    jmp .wpdrawnext
.wpdrawimg:
    mov rcx, r15
    call img_ensure
    mov rcx, [r15+WD_IMG]
    test rcx, rcx
    jz .wpdrawnext
    mov rcx, r12
    call CreateCompatibleDC
    mov [picmemdc], rax
    mov rcx, rax
    mov rdx, [r15+WD_IMG]
    call SelectObject
    mov [picoldbm], rax
    mov rcx, r12
    mov edx, HALFTONE
    call SetStretchBltMode
    mov rcx, r12
    mov rdx, [r15+WD_X]
    mov r8, [r15+WD_Y]
    mov r9, [r15+WD_W]
    mov rax, [r15+WD_H]
    mov [rsp+32], rax
    mov rax, [picmemdc]
    mov [rsp+40], rax
    mov qword [rsp+48], 0
    mov qword [rsp+56], 0
    mov rax, [r15+WD_IMGW]
    mov [rsp+64], rax
    mov rax, [r15+WD_IMGH]
    mov [rsp+72], rax
    mov qword [rsp+80], SRCCOPY
    call StretchBlt
    mov rcx, [picmemdc]
    mov rdx, [picoldbm]
    call SelectObject
    mov rcx, [picmemdc]
    call DeleteDC
    jmp .wpdrawnext
.wpdrawbtn:
    mov rcx, r12
    mov rdx, r15
    call wfit
    mov rax, [r15+WD_RADIUS]
    call dscal
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
    mov rax, [r15+WD_COLOR]
    call colref
    mov rcx, rax
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
    mov rax, [r15+WD_COLOR]
    call colref
    mov rcx, rax
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
    mov rdx, r15
    call wfont_on
    mov [rsp+88], rax
    mov rax, [r15+WD_TEXT_PTR]
    test rax, rax
    jnz .whastxt1
    lea rax, [default_title]
.whastxt1:
    mov [rsp+56], rax
    mov rcx, r12
    mov rdx, rax
    mov r8d, -1
    lea r9, [drawrect]
    mov r10d, (DT_CENTER | DT_VCENTER | DT_SINGLELINE)
    mov r11d, 1
    call tfit
    mov rcx, r12
    mov rdx, [rsp+56]
    mov r8, -1
    lea r9, [drawrect]
    mov dword [rsp+32], (DT_CENTER | DT_VCENTER | DT_SINGLELINE)
    call DrawTextA
    mov rcx, r12
    mov rdx, [rsp+88]
    call wfont_off
    jmp .wpdrawnext
.wpdrawlbl:
    mov rcx, r12
    mov rdx, r15
    call wfit
    mov rcx, r12
    mov edx, TRANSPARENT
    call SetBkMode
    mov rax, [r15+WD_COLOR]
    call colref
    mov rdx, rax
    mov rcx, r12
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
    mov rdx, r15
    call wfont_on
    mov [rsp+88], rax
    mov rax, [r15+WD_TEXT_PTR]
    test rax, rax
    jnz .whastxt2
    lea rax, [default_title]
.whastxt2:
    mov [rsp+56], rax
    mov rcx, r12
    mov rdx, rax
    mov r8d, -1
    lea r9, [drawrect]
    mov r10d, (DT_WORDBREAK | DT_NOPREFIX)
    xor r11d, r11d
    call tfit
    mov rcx, r12
    mov rdx, [rsp+56]
    mov r8, -1
    lea r9, [drawrect]
    mov dword [rsp+32], (DT_WORDBREAK | DT_NOPREFIX)
    call DrawTextA
    mov rcx, r12
    mov rdx, [rsp+88]
    call wfont_off
    jmp .wpdrawnext
.wpdrawpan:
    mov rax, [r15+WD_COLOR]
    call colref
    mov rcx, rax
    call CreateSolidBrush
    mov r13, rax
    mov rax, [r15+WD_RADIUS]
    call dscal
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
    mov rcx, r12
    mov rdx, r15
    call wfit
    mov rcx, [r15+WD_COLOR]
    mov rax, [focus_wid]
    imul rax, rax, WIDGET_SIZE
    lea r11, [widgets]
    add rax, r11
    cmp rax, r15
    jne .winpnf
    add rcx, 0x00181818
.winpnf:
    mov rax, rcx
    call colref
    mov rcx, rax
    call CreateSolidBrush
    mov r13, rax
    mov rax, [r15+WD_RADIUS]
    call dscal
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
    mov rdx, r15
    call wfont_on
    mov [rsp+88], rax
    mov rax, [r15+WD_TEXT_PTR]
    test rax, rax
    jnz .winptxt2
    lea rax, [empty_str]
.winptxt2:
    mov [rsp+56], rax
    mov rcx, r12
    mov rdx, rax
    mov r8d, -1
    lea r9, [drawrect]
    mov r10d, (DT_LEFT | DT_VCENTER | DT_SINGLELINE)
    mov r11d, 1
    call tfit
    mov rcx, r12
    mov rdx, [rsp+56]
    mov r8, -1
    lea r9, [drawrect]
    mov dword [rsp+32], (DT_LEFT | DT_VCENTER | DT_SINGLELINE)
    call DrawTextA
    mov rcx, r12
    mov rdx, [rsp+88]
    call wfont_off
.wpdrawnext:
    inc rbp
    jmp .wpdrawloop
.wpdrawdone:
    mov rcx, [painthdc]
    xor edx, edx
    xor r8d, r8d
    mov r9d, [clientrect+8]
    sub r9d, [clientrect]
    mov eax, [clientrect+12]
    sub eax, [clientrect+4]
    mov [rsp+32], rax
    mov rax, [memdc]
    mov [rsp+40], rax
    mov qword [rsp+48], 0
    mov qword [rsp+56], 0
    mov qword [rsp+64], SRCCOPY
    call BitBlt
    mov rcx, [memdc]
    mov rdx, [oldbmp]
    call SelectObject
    mov rcx, [membmp]
    call DeleteObject
    mov rcx, [memdc]
    call DeleteDC
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
    lea r11, [widgets]
    add r15, r11
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
    lea r11, [toks]
    add rax, r11
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
    lea r11, [widgets]
    add r15, r11
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
.wsize:
    mov rax, [zden]
    test rax, rax
    jz .wsizedone
    mov rcx, r14
    and ecx, 0xFFFF
    test rcx, rcx
    jz .wsizedone
    cmp rcx, [znum]
    je .wsizedone
    call rescale_all
    mov rcx, rbx
    xor edx, edx
    xor r8d, r8d
    call InvalidateRect
.wsizedone:
    xor eax, eax
    jmp .wdone
.werase:
    mov eax, 1
    jmp .wdone
.wdestroy:
    xor ecx, ecx
    call PostQuitMessage
    xor eax, eax
.wdone:
    add rsp, 96
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rsi
    pop rbx
    ret


webview_env_qi:
    mov eax, 1
    ret

webview_env_addref:
    mov eax, 1
    ret

webview_env_release:
    mov eax, 1
    ret

webview_env_invoke:
    push rbx
    push r12
    push r13
    sub rsp, 56
    test edx, edx
    jnz .evifail
    mov [webview_env], r8
    mov rax, [r8]
    mov rcx, r8
    mov rdx, [hwnd_main]
    lea r8, [webview_ctrl_obj]
    xor r9d, r9d
    call qword [rax+24]
    jmp .evdone
.evifail:
    mov qword [webview_env], 0
.evdone:
    xor eax, eax
    add rsp, 56
    pop r13
    pop r12
    pop rbx
    ret

webview_ctrl_qi:
    mov eax, 1
    ret

webview_ctrl_addref:
    mov eax, 1
    ret

webview_ctrl_release:
    mov eax, 1
    ret

webview_ctrl_invoke:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 80
    mov rbx, r8
    test edx, edx
    jnz .cvifail
    mov [webview_ctrl], r8
    mov rax, [r8]
    mov rcx, r8
    lea rdx, [webview_core]
    call qword [rax+24]
    mov r13, [webview_core]
    test r13, r13
    jz .cvifail2
    mov rax, [r8]
    mov rcx, r8
    lea rdx, [rsp+32]
    mov dword [rsp+32], 0
    mov dword [rsp+36], 0
    mov eax, [webview_w]
    mov [rsp+40], eax
    mov eax, [webview_h]
    mov [rsp+44], eax
    mov rax, [webview_ctrl]
    mov rcx, [rax]
    mov rdx, [webview_ctrl]
    lea r8, [rsp+32]
    call qword [rcx+32]
.cvifail2:
    xor eax, eax
    add rsp, 80
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.cvifail:
    mov qword [webview_core], 0
    xor eax, eax
    add rsp, 80
    pop r14
    pop r13
    pop r12
    pop rbx
    ret


webview_init:
    push rbx
    push r12
    sub rsp, 40
    cmp qword [webview_inited], 0
    jnz .wialready
    mov qword [webview_inited], 1
    lea rcx, [dll_webview2]
    call LoadLibraryA
    test rax, rax
    jz .wifail
    mov rbx, rax
    mov rcx, rbx
    lea rdx, [fn_createenv]
    call GetProcAddress
    test rax, rax
    jz .wifail
    mov r12, rax
    lea rax, [env_cb_vtable]
    mov [webview_cb_obj], rax
    mov qword [webview_cb_obj+8], 1
    lea rax, [ctrl_cb_vtable]
    mov [webview_ctrl_obj], rax
    mov qword [webview_ctrl_obj+8], 1
    xor ecx, ecx
    xor edx, edx
    xor r8d, r8d
    lea r9, [webview_cb_obj]
    call r12
.wialready:
    xor eax, eax
    inc eax
    add rsp, 40
    pop r12
    pop rbx
    ret
.wifail:
    xor eax, eax
    add rsp, 40
    pop r12
    pop rbx
    ret


do_webview:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 48
    cmp qword [wview2on], 0
    jne .dwv2ok
    lea r8, [msg_needwv2]
    call fatal
.dwv2ok:
    call advance
    call webview_init
    test rax, rax
    jz .dwvfail
    call curtype
    cmp al, T_IDENT
    jne .dwvbad
    call advance
    call eval_expr
    mov r12d, eax
    call eval_expr
    mov r13d, eax
    call eval_expr
    mov r14d, eax
    call eval_expr
    mov r15d, eax
    call curtype
    cmp al, T_SEMI
    jne .dwvbad
    call advance
    mov [webview_x], r12d
    mov [webview_y], r13d
    mov [webview_w], r14d
    mov [webview_h], r15d
    mov rax, 1
    add rsp, 48
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
.dwvbad:
    lea r8, [msg_syntax]
    call fatal
.dwvfail:
    lea r8, [msg_dllfail]
    call fatal


do_navigate:
    push rbx
    push r12
    push r13
    sub rsp, 40
    cmp qword [wview2on], 0
    jne .dnok
    lea r8, [msg_needwv2]
    call fatal
.dnok:
    call advance
    call curtype
    cmp al, T_IDENT
    jne .dnbad
    call advance
    call curtype
    cmp al, T_IDENT
    jne .dnfromeval
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .dnfromeval2
    mov rbx, [rax+WD_TEXT_PTR]
    call advance
    jmp .dnhaveval
.dnfromeval:
    call eval_expr
    mov rbx, rax
    jmp .dnhaveval
.dnfromeval2:
    call eval_expr
    mov rbx, rax
.dnhaveval:
    mov r13, [webview_core]
    test r13, r13
    jnz .dnhavecore
    lea r8, [msg_syntax]
    call fatal
.dnhavecore:
    call curtype
    cmp al, T_SEMI
    jne .dnbad
    call advance
    mov rax, [r13]
    mov rcx, r13
    mov rdx, rbx
    call qword [rax+224]
    xor eax, eax
    inc eax
    add rsp, 40
    pop r13
    pop r12
    pop rbx
    ret
.dnbad:
    lea r8, [msg_syntax]
    call fatal


do_wvhtml:
    push rbx
    push r12
    push r13
    sub rsp, 40
    cmp qword [wview2on], 0
    jne .dhok
    lea r8, [msg_needwv2]
    call fatal
.dhok:
    call advance
    call curtype
    cmp al, T_IDENT
    jne .dhbad
    call advance
    call curtype
    cmp al, T_IDENT
    jne .dheval
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .dheval
    mov rbx, [rax+WD_TEXT_PTR]
    call advance
    jmp .dhhaveval
.dheval:
    call eval_expr
    mov rbx, rax
.dhhaveval:
    mov r13, [webview_core]
    test r13, r13
    jnz .dhhavecore
    lea r8, [msg_syntax]
    call fatal
.dhhavecore:
    call curtype
    cmp al, T_SEMI
    jne .dhbad
    call advance
    mov rax, [r13]
    mov rcx, r13
    mov rdx, rbx
    call qword [rax+232]
    xor eax, eax
    inc eax
    add rsp, 40
    pop r13
    pop r12
    pop rbx
    ret
.dhbad:
    lea r8, [msg_syntax]
    call fatal


do_wvexec:
    push rbx
    push r12
    push r13
    sub rsp, 40
    cmp qword [wview2on], 0
    jne .djok
    lea r8, [msg_needwv2]
    call fatal
.djok:
    call advance
    call curtype
    cmp al, T_IDENT
    jne .djbad
    call advance
    call curtype
    cmp al, T_IDENT
    jne .djeval
    mov rbx, [tcur]
    mov rcx, [rbx+16]
    mov rdx, [rbx+24]
    call find_widget_by_name
    test rax, rax
    jz .djeval
    mov rbx, [rax+WD_TEXT_PTR]
    call advance
    jmp .djhaveval
.djeval:
    call eval_expr
    mov rbx, rax
.djhaveval:
    mov r13, [webview_core]
    test r13, r13
    jnz .djhavecore
    lea r8, [msg_syntax]
    call fatal
.djhavecore:
    call curtype
    cmp al, T_SEMI
    jne .djbad
    call advance
    mov rax, [r13]
    mov rcx, r13
    mov rdx, rbx
    xor r8d, r8d
    call qword [rax+336]
    xor eax, eax
    inc eax
    add rsp, 40
    pop r13
    pop r12
    pop rbx
    ret
.djbad:
    lea r8, [msg_syntax]
    call fatal
