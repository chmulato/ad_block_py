@echo off
REM Script avançado para converter block.py em executável otimizado
REM Inclui compressão UPX e verificações de segurança

echo ====================================================
echo   CONVERSOR AVANÇADO PARA EXECUTÁVEL - ADBLOKCER
echo ====================================================
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

echo 🔧 Preparando ambiente...
echo.

REM Instala dependências necessárias
echo Instalando PyInstaller...
python -m pip install pyinstaller requests

REM Verifica se UPX está disponível para compressão
echo.
echo 🗜️ Verificando UPX para compressão...
upx --version >nul 2>&1
if errorlevel 1 (
    echo ⚠️ UPX não encontrado - executável será maior
    echo Para reduzir tamanho, baixe UPX de: https://upx.github.io/
    set USE_UPX=false
) else (
    echo ✅ UPX encontrado - executável será comprimido
    set USE_UPX=true
)

echo.
echo 🔨 Criando executável otimizado...
echo Aguarde, isso pode levar alguns minutos...
echo.

REM Remove arquivos antigos
if exist "AdBlocker.exe" del "AdBlocker.exe"
if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"

REM Comando PyInstaller com todas as otimizações
if "%USE_UPX%"=="true" (
    pyinstaller ^
        --onefile ^
        --name=AdBlocker ^
        --clean ^
        --optimize=2 ^
        --strip ^
        --upx-dir=. ^
        --distpath=. ^
        --workpath=build_temp ^
        --specpath=build_temp ^
        --version-file=version_info.txt ^
        --hidden-import=requests ^
        --hidden-import=urllib3 ^
        --hidden-import=certifi ^
        --hidden-import=charset_normalizer ^
        --hidden-import=idna ^
        --hidden-import=ctypes ^
        --exclude-module=tkinter ^
        --exclude-module=matplotlib ^
        --exclude-module=numpy ^
        --exclude-module=pandas ^
        block.py
) else (
    pyinstaller ^
        --onefile ^
        --name=AdBlocker ^
        --clean ^
        --optimize=2 ^
        --strip ^
        --distpath=. ^
        --workpath=build_temp ^
        --specpath=build_temp ^
        --version-file=version_info.txt ^
        --hidden-import=requests ^
        --hidden-import=urllib3 ^
        --hidden-import=certifi ^
        --hidden-import=charset_normalizer ^
        --hidden-import=idna ^
        --hidden-import=ctypes ^
        --exclude-module=tkinter ^
        --exclude-module=matplotlib ^
        --exclude-module=numpy ^
        --exclude-module=pandas ^
        block.py
)

if exist "AdBlocker.exe" (
    echo.
    echo ✅ Conversão concluída com sucesso!
    echo.
    
    REM Mostra informações do arquivo
    echo 📊 INFORMAÇÕES DO EXECUTÁVEL:
    echo ================================
    for %%A in (AdBlocker.exe) do (
        echo 📁 Nome: %%~nxA
        echo 📏 Tamanho: %%~zA bytes
        echo 📅 Data: %%~tA
    )
    
    REM Calcula tamanho em MB
    for /f %%A in ('powershell -command "[math]::Round((Get-Item 'AdBlocker.exe').Length / 1MB, 2)"') do (
        echo 📏 Tamanho: %%A MB
    )
    
    echo.
    echo 💡 INSTRUÇÕES DE USO:
    echo =====================
    echo 1. Execute AdBlocker.exe como Administrador
    echo 2. O arquivo é totalmente portátil
    echo 3. Não precisa de Python instalado
    echo 4. Pode ser distribuído independentemente
    echo 5. Compatível com Windows 7/8/10/11
    
    echo.
    echo 🧹 Limpando arquivos temporários...
    if exist "build_temp" rmdir /s /q "build_temp" >nul 2>&1
    
    echo.
    echo 🔐 Verificando integridade...
    powershell -command "Get-FileHash 'AdBlocker.exe' -Algorithm SHA256 | Select-Object Hash"
    
    echo.
    echo ✅ Processo concluído!
    echo 📦 Arquivo final: AdBlocker.exe
    
) else (
    echo.
    echo ❌ Erro na conversão!
    echo.
    echo 🔍 Possíveis causas:
    echo - Dependências em falta
    echo - Permissões insuficientes
    echo - Antivírus bloqueando
    echo.
    echo Verifique o log acima para mais detalhes.
)

echo.
echo Deseja testar o executável agora? (S/N)
set /p choice=
if /i "%choice%"=="S" (
    echo.
    echo 🧪 Testando executável...
    AdBlocker.exe
)

echo.
pause