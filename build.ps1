# Build AdBlocker - Script Otimizado
# Contorna PermissionError do PyInstaller automaticamente
# Uso: .\build.ps1

param(
    [switch]$Admin,
    [switch]$Verbose
)

function Write-Status($Message, $Color = "White") {
    Write-Host "► $Message" -ForegroundColor $Color
}

function Test-Admin {
    ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Header
Write-Host "`n AdBlocker Builder" -ForegroundColor Green
Write-Host "===================" -ForegroundColor Green

# Verificar arquivo fonte
if (-not (Test-Path "block.py")) {
    Write-Host "Arquivo block.py nao encontrado!" -ForegroundColor Red
    exit 1
}

# Reexecutar como Admin se solicitado
if ($Admin -and -not (Test-Admin)) {
    Write-Status "Reiniciando como Administrador..." "Yellow"
    Start-Process PowerShell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`" -Admin -Verbose:$Verbose" -Verb RunAs
    exit
}

if (Test-Admin) {
    Write-Status "Executando como Administrador" "Green"
} else {
    Write-Status "Executando como usuario normal" "Cyan"
}

# Limpeza rápida
Write-Status "Limpando arquivos antigos..." "Yellow"
@("dist*", "build", "__pycache__", "*.spec") | ForEach-Object {
    if (Test-Path $_) {
        Remove-Item $_ -Recurse -Force -ErrorAction SilentlyContinue
        if ($Verbose) { Write-Status "Removido: $_" "Blue" }
    }
}

# Finalizar processos AdBlocker se existirem
$processes = Get-Process -Name "AdBlocker*", "block*" -ErrorAction SilentlyContinue
if ($processes) {
    Write-Status "Finalizando processos AdBlocker..." "Yellow"
    $processes | Stop-Process -Force -ErrorAction SilentlyContinue
}

# Build com fallback automático
$buildDirs = @("dist_build", "output", "$env:TEMP\AdBlocker_$(Get-Random)")
$success = $false

foreach ($dir in $buildDirs) {
    Write-Status "Tentando build em: $dir" "Cyan"
    
    # Comando PyInstaller
    $pyArgs = @(
        "--onefile", "--noconsole", "--name=AdBlocker",
        "--distpath=$dir", "--add-data=README.md;.", 
        "--hidden-import=requests", "--clean", "block.py"
    )
    
    try {
        if ($Verbose) {
            Write-Status "Comando: pyinstaller $($pyArgs -join ' ')" "Gray"
            & pyinstaller @pyArgs
        } else {
            & pyinstaller @pyArgs *>$null
        }
        
        $exePath = "$dir\AdBlocker.exe"
        if (Test-Path $exePath) {
            $fileSize = [math]::Round((Get-Item $exePath).Length / 1MB, 1)
            Write-Status "BUILD SUCESSO!" "Green"
            Write-Status "Arquivo: $exePath ($fileSize MB)" "White"
            
            # Copiar para dist se possível
            try {
                New-Item -ItemType Directory -Path "dist" -Force | Out-Null
                Copy-Item $exePath "dist\AdBlocker.exe" -Force
                Write-Status "Copiado para: dist\AdBlocker.exe" "Blue"
            } catch {
                Write-Status "Executavel disponivel em: $exePath" "Yellow"
            }
            
            $success = $true
            break
        }
    } catch {
        if ($Verbose) { Write-Status "Falha em $dir" "Red" }
        continue
    }
}

if (-not $success) {
    Write-Status "Build falhou em todas as tentativas" "Red"
    Write-Status "Tente: .\build.ps1 -Admin -Verbose" "Yellow"
    exit 1
}

# Resultado final
Write-Host "`nBUILD CONCLUIDO!" -ForegroundColor Green
$finalPath = if (Test-Path "dist\AdBlocker.exe") { "dist\AdBlocker.exe" } else { "$dir\AdBlocker.exe" }
Write-Host "Executavel: $finalPath" -ForegroundColor White

$test = Read-Host "`nTestar executavel agora? (s/N)"
if ($test -eq "s" -or $test -eq "S") {
    Start-Process $finalPath -ErrorAction SilentlyContinue
}