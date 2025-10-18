@echo off
REM Script para executar o bloqueador de propagandas
REM Deve ser executado como administrador

cd /d "%~dp0"

REM Verifica se o Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo Python não encontrado! Por favor, instale o Python.
    echo Baixe em: https://www.python.org/downloads/
    pause
    exit /b 1
)

REM Instala dependências se necessário
echo Verificando dependências...
python -m pip install requests >nul 2>&1

REM Executa o script
echo Executando bloqueador de propagandas...
python block.py

REM Mantém a janela aberta para ver o resultado
pause