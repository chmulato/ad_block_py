@echo off
REM Desinstalador do Bloqueador de Propagandas

echo ==========================================
echo   DESINSTALADOR - BLOQUEADOR DE PROPAGANDAS
echo ==========================================
echo.

REM Verifica privilégios de administrador
net session >nul 2>&1
if errorlevel 1 (
    echo Este script precisa ser executado como Administrador!
    echo Clique com o botao direito e selecione "Executar como administrador"
    pause
    exit /b 1
)

set "STARTUP_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "SHORTCUT_FILE=%STARTUP_DIR%\Bloqueador_Propagandas.lnk"

echo Removendo bloqueio de propagandas...
python block.py unblock

echo.
echo Removendo da inicialização automática...
if exist "%SHORTCUT_FILE%" (
    del "%SHORTCUT_FILE%"
    echo ✅ Atalho removido da inicialização!
) else (
    echo ⚠️  Atalho não encontrado na inicialização.
)

echo.
echo ✅ Desinstalação concluída!
echo.
echo O bloqueador foi removido e as propagandas voltarão a aparecer.
echo Reinicie seu navegador para que as alterações tenham efeito.
echo.
pause