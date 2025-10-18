@echo off
REM Instalador completo - Gera executável e configura sistema

echo ========================================================
echo   INSTALADOR COMPLETO - BLOQUEADOR DE PROPAGANDAS EXE
echo ========================================================
echo.

REM Verifica privilégios de administrador
net session >nul 2>&1
if errorlevel 1 (
    echo ❌ Este script precisa ser executado como Administrador!
    echo Clique com o botao direito e selecione "Executar como administrador"
    pause
    exit /b 1
)

REM Verifica se o Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python não encontrado!
    echo.
    echo 📥 Deseja baixar e instalar o Python automaticamente? (S/N)
    set /p install_python=
    if /i "%install_python%"=="S" (
        echo 🌐 Abrindo página de download do Python...
        start https://www.python.org/downloads/
        echo Após instalar o Python, execute este script novamente.
    )
    pause
    exit /b 1
)

echo 🔧 Preparando instalação...
echo.

REM Etapa 1: Gerar executável
echo ⚡ ETAPA 1: Gerando executável...
echo ====================================

if not exist "AdBlocker.exe" (
    echo 🔨 Criando AdBlocker.exe...
    call build_exe_advanced.bat
    echo.
) else (
    echo ✅ AdBlocker.exe já existe!
    echo.
    echo Deseja recriar o executável? (S/N)
    set /p recreate=
    if /i "%recreate%"=="S" (
        call build_exe_advanced.bat
    )
)

REM Verifica se o executável foi criado
if not exist "AdBlocker.exe" (
    echo ❌ Falha ao criar executável!
    pause
    exit /b 1
)

echo.
echo ⚡ ETAPA 2: Configurando execução automática...
echo ===============================================

set "STARTUP_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "INSTALL_DIR=%ProgramFiles%\AdBlocker"
set "CURRENT_DIR=%~dp0"

REM Cria diretório de instalação
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

REM Copia executável para diretório de instalação
echo 📁 Copiando arquivos...
copy "AdBlocker.exe" "%INSTALL_DIR%\AdBlocker.exe" >nul
copy "README.md" "%INSTALL_DIR%\README.md" >nul

REM Cria script de execução
echo @echo off > "%INSTALL_DIR%\run_adblock.bat"
echo cd /d "%INSTALL_DIR%" >> "%INSTALL_DIR%\run_adblock.bat"
echo AdBlocker.exe >> "%INSTALL_DIR%\run_adblock.bat"

REM Cria atalho na área de trabalho
echo 🔗 Criando atalhos...
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\CreateDesktopShortcut.vbs"
echo sLinkFile = "%USERPROFILE%\Desktop\Bloqueador de Propagandas.lnk" >> "%TEMP%\CreateDesktopShortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\CreateDesktopShortcut.vbs"
echo oLink.TargetPath = "%INSTALL_DIR%\AdBlocker.exe" >> "%TEMP%\CreateDesktopShortcut.vbs"
echo oLink.WorkingDirectory = "%INSTALL_DIR%" >> "%TEMP%\CreateDesktopShortcut.vbs"
echo oLink.Description = "Bloqueador de Propagandas - Executável" >> "%TEMP%\CreateDesktopShortcut.vbs"
echo oLink.Save >> "%TEMP%\CreateDesktopShortcut.vbs"

cscript "%TEMP%\CreateDesktopShortcut.vbs" >nul
del "%TEMP%\CreateDesktopShortcut.vbs"

REM Cria atalho na inicialização
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\CreateStartupShortcut.vbs"
echo sLinkFile = "%STARTUP_DIR%\Bloqueador_Propagandas.lnk" >> "%TEMP%\CreateStartupShortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\CreateStartupShortcut.vbs"
echo oLink.TargetPath = "%INSTALL_DIR%\AdBlocker.exe" >> "%TEMP%\CreateStartupShortcut.vbs"
echo oLink.WorkingDirectory = "%INSTALL_DIR%" >> "%TEMP%\CreateStartupShortcut.vbs"
echo oLink.Description = "Bloqueador de Propagandas - Execução Automática" >> "%TEMP%\CreateStartupShortcut.vbs"
echo oLink.WindowStyle = 7 >> "%TEMP%\CreateStartupShortcut.vbs"
echo oLink.Save >> "%TEMP%\CreateStartupShortcut.vbs"

cscript "%TEMP%\CreateStartupShortcut.vbs" >nul
del "%TEMP%\CreateStartupShortcut.vbs"

REM Cria desinstalador
echo 🗑️ Criando desinstalador...
echo @echo off > "%INSTALL_DIR%\uninstall.bat"
echo REM Desinstalador do Bloqueador de Propagandas >> "%INSTALL_DIR%\uninstall.bat"
echo. >> "%INSTALL_DIR%\uninstall.bat"
echo net session ^>nul 2^>^&1 >> "%INSTALL_DIR%\uninstall.bat"
echo if errorlevel 1 ^( >> "%INSTALL_DIR%\uninstall.bat"
echo     echo Execute como Administrador! >> "%INSTALL_DIR%\uninstall.bat"
echo     pause >> "%INSTALL_DIR%\uninstall.bat"
echo     exit /b 1 >> "%INSTALL_DIR%\uninstall.bat"
echo ^) >> "%INSTALL_DIR%\uninstall.bat"
echo. >> "%INSTALL_DIR%\uninstall.bat"
echo echo Removendo bloqueio... >> "%INSTALL_DIR%\uninstall.bat"
echo AdBlocker.exe unblock >> "%INSTALL_DIR%\uninstall.bat"
echo. >> "%INSTALL_DIR%\uninstall.bat"
echo echo Removendo atalhos... >> "%INSTALL_DIR%\uninstall.bat"
echo del "%USERPROFILE%\Desktop\Bloqueador de Propagandas.lnk" ^>nul 2^>^&1 >> "%INSTALL_DIR%\uninstall.bat"
echo del "%STARTUP_DIR%\Bloqueador_Propagandas.lnk" ^>nul 2^>^&1 >> "%INSTALL_DIR%\uninstall.bat"
echo. >> "%INSTALL_DIR%\uninstall.bat"
echo cd /d "%TEMP%" >> "%INSTALL_DIR%\uninstall.bat"
echo rmdir /s /q "%INSTALL_DIR%" >> "%INSTALL_DIR%\uninstall.bat"
echo echo Desinstalação concluída! >> "%INSTALL_DIR%\uninstall.bat"
echo pause >> "%INSTALL_DIR%\uninstall.bat"

echo.
echo ⚡ ETAPA 3: Teste inicial...
echo ============================

echo Deseja executar o bloqueador agora? (S/N)
set /p run_now=
if /i "%run_now%"=="S" (
    echo.
    echo 🧪 Executando teste...
    "%INSTALL_DIR%\AdBlocker.exe"
)

echo.
echo ✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO!
echo =====================================
echo.
echo 📍 Arquivos instalados em: %INSTALL_DIR%
echo 🔗 Atalho na área de trabalho: Criado
echo 🚀 Execução automática: Configurada
echo 🗑️ Desinstalador: %INSTALL_DIR%\uninstall.bat
echo.
echo 💡 COMO USAR:
echo - Duplo clique no atalho da área de trabalho
echo - Ou execute: %INSTALL_DIR%\AdBlocker.exe
echo - Para desinstalar: %INSTALL_DIR%\uninstall.bat
echo.
echo ⚠️ IMPORTANTE:
echo - Execute sempre como Administrador
echo - Reinicie o navegador após usar
echo - O bloqueio inicia automaticamente com o Windows
echo.
pause