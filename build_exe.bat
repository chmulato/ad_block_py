@echo off
REM Script para converter block.py em executável
REM Instala PyInstaller e gera o arquivo .exe

echo ===============================================
echo   CONVERSOR PARA EXECUTÁVEL - BLOQUEADOR ADS
echo ===============================================
echo.

REM Verifica se o Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python não encontrado!
    echo Por favor, instale o Python primeiro:
    echo https://www.python.org/downloads/
    pause
    exit /b 1
)

echo 🔧 Instalando PyInstaller...
python -m pip install pyinstaller

echo.
echo 🔨 Criando executável...
echo Aguarde, isso pode levar alguns minutos...

REM Comando PyInstaller otimizado
pyinstaller ^
    --onefile ^
    --name=AdBlocker ^
    --clean ^
    --distpath=. ^
    --workpath=build_temp ^
    --specpath=build_temp ^
    --hidden-import=requests ^
    --hidden-import=urllib3 ^
    --hidden-import=certifi ^
    --hidden-import=charset_normalizer ^
    --hidden-import=idna ^
    block.py

if exist "AdBlocker.exe" (
    echo.
    echo ✅ Conversão concluída com sucesso!
    echo.
    echo 📁 Arquivo gerado: AdBlocker.exe
    echo 📏 Tamanho: 
    for %%A in (AdBlocker.exe) do echo    %%~zA bytes
    echo.
    echo 💡 IMPORTANTE:
    echo - Execute AdBlocker.exe como Administrador
    echo - O arquivo é portátil (não precisa Python instalado)
    echo - Pode ser distribuído independentemente
    echo.
    echo 🧹 Limpando arquivos temporários...
    if exist "build_temp" rmdir /s /q "build_temp"
    if exist "AdBlocker.spec" del "AdBlocker.spec"
    echo ✅ Limpeza concluída!
) else (
    echo ❌ Erro na conversão!
    echo Verifique se todos os arquivos estão presentes.
)

echo.
pause