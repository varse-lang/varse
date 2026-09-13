@echo off
cd /d "%~dp0"

if not exist tools\nasm.exe (
    echo nasm.exe not found in tools\ - put it there and try again
    exit /b 1
)
if not exist tools\GoLink.exe (
    echo GoLink.exe not found in tools\ - put it there and try again
    exit /b 1
)

tools\nasm.exe -f win64 varse.asm -o varse.obj
if errorlevel 1 (
    echo assembly failed
    exit /b 1
)

tools\GoLink.exe /console /entry:main varse.obj kernel32.dll user32.dll gdi32.dll gdiplus.dll
if errorlevel 1 (
    echo link failed
    exit /b 1
)

echo varse.exe built - run with:  varse.exe examples\gui.var
