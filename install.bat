@echo off
REM Instalador do Bloqueador de Propagandas
REM Configura execução automática na inicialização do Windows

echo ========================================
echo   INSTALADOR - BLOQUEADOR DE PROPAGANDAS
echo ========================================
echo.

REM Verifica privilégios de administrador
net session >nul 2>&1
if errorlevel 1 (
    echo Este script precisa ser executado como Administrador!
    echo Clique com o botao direito e selecione "Executar como administrador"
    pause
    exit /b 1
)

set "SCRIPT_DIR=%~dp0"
set "STARTUP_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

echo Configurando execução automática...
echo.

REM Cria atalho na pasta de inicialização
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut.vbs"
echo sLinkFile = "%STARTUP_DIR%\Bloqueador_Propagandas.lnk" >> "%TEMP%\CreateShortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\CreateShortcut.vbs"
echo oLink.TargetPath = "%SCRIPT_DIR%run_adblock.bat" >> "%TEMP%\CreateShortcut.vbs"
echo oLink.WorkingDirectory = "%SCRIPT_DIR%" >> "%TEMP%\CreateShortcut.vbs"
echo oLink.Description = "Bloqueador de Propagandas - Execução Automática" >> "%TEMP%\CreateShortcut.vbs"
echo oLink.WindowStyle = 7 >> "%TEMP%\CreateShortcut.vbs"
echo oLink.Save >> "%TEMP%\CreateShortcut.vbs"

cscript "%TEMP%\CreateShortcut.vbs" >nul
del "%TEMP%\CreateShortcut.vbs"

if exist "%STARTUP_DIR%\Bloqueador_Propagandas.lnk" (
    echo ✅ Atalho criado com sucesso na inicialização!
) else (
    echo ❌ Erro ao criar atalho na inicialização!
)

echo.
echo Deseja executar o bloqueador agora? (S/N)
set /p choice=
if /i "%choice%"=="S" (
    call "%SCRIPT_DIR%run_adblock.bat"
)

echo.
echo Instalação concluída!
echo O bloqueador será executado automaticamente na próxima inicialização.
echo.
echo Para desinstalar, delete o arquivo:
echo "%STARTUP_DIR%\Bloqueador_Propagandas.lnk"
echo.
pause