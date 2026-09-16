# Varse

A programming language written from scratch in x86 64 Assembly using NASM.

Varse is my attempt at making a programming language that is simple to write while still having a low level foundation. The compiler and runtime are written in Assembly, and the language itself is designed to grow into something capable of both normal programming and lower level system work.

# Donations are accepted

**Cashapp: $p1stn**

**PayPal: @m4rdr**

# What Varse Has

Functions

Nested functions

Recursion

Variables and constants

Conditionals

Expressions

Return values

Arithmetic and comparison operators

Native Windows GUI support

GUI event callbacks

Networking

HTTP GET requests

HTML parsing

CSS color handling

HTML block rendering

Widget manipulation

Standalone executable building

Strings and string operations

String comparison

String concatenation

String conversion

Tables

File I/O

While loops

Blocks and scope

Comments

Native Windows GUI primitives

Fonts

Drawing primitives

Images

Gradients

Circles

Lines

Triangles

Dynamic widget updates

Widget visibility control

UI reset / page rebuilding

WebView2 support

WebView2 HTML/CSS/JS rendering

WebView navigation

WebView JavaScript execution

HTTP response handling

HTML text extraction

HTML title extraction

HTML block inspection

CSS color extraction

Native DLL loading

DLL importing

DLL inclusion

Native function resolution

Native function calls

Native string pointers

Native memory allocation

Direct memory reading

Direct memory writing

Native error handling

Windows API access

Process interaction

x86-64 Assembly based compiler and runtime

Example
fn fib(n) {
    if n <= 1 {
        return 1;
    }

    return fib(n - 1) + fib(n - 2);
}

fn main() {
    print(fib(10));
}
GUI

Varse also has native Windows GUI support.

fn main() {
    window "My App" 800 600;

    button btn1 10 10 200 50 "Click Me";

    onclick btn1 {
        print(42);
    };

    show;
}

The GUI system uses the Windows APIs underneath instead of relying on a separate web based interface.

# Building

Varse currently uses NASM and GoLink on Windows.

git clone https://github.com/varse-lang/varse
cd varse

nasm -f win64 varse.asm -o varse.obj

golink /entry:main /console varse.obj kernel32.dll user32.dll gdi32.dll gdiplus.dll
Running

Give the executable a .varse file to run.

varse.exe program.varse

Every Varse program starts from a main function.

fn main() {
    print(42);
}
# Documentation

The documentation is available here:

https://varse.pages.dev/docs

# Website

https://varse.pages.dev/

# Source

https://github.com/varse-lang/varse

# Discord

https://discord.gg/GTvzJ2pQaT

Project Status

# Varse is still being worked on.

A lot of the language is still changing, and new features are being added as I build the compiler. The goal is to keep pushing it further while keeping the actual language readable and easy to work with.

License

Varse is licensed under the GNU General Public License version 3.

See LICENSE for the full license.
