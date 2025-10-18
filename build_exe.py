# Script para converter block.py em executável
# Instala PyInstaller e cria o arquivo .exe

import subprocess
import sys
import os

def install_pyinstaller():
    """Instala PyInstaller se não estiver instalado"""
    print("🔧 Instalando PyInstaller...")
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "pyinstaller"])
        print("✅ PyInstaller instalado com sucesso!")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Erro ao instalar PyInstaller: {e}")
        return False

def create_executable():
    """Cria o arquivo executável"""
    print("🔨 Criando executável...")
    
    # Comando PyInstaller com opções otimizadas
    command = [
        "pyinstaller",
        "--onefile",                    # Um único arquivo
        "--noconsole",                  # Sem console (interface gráfica)
        "--name=AdBlocker",             # Nome do executável
        "--icon=icon.ico",              # Ícone (se existir)
        "--add-data=README.md;.",       # Incluir README
        "--hidden-import=requests",     # Importações explícitas
        "--clean",                      # Limpar cache
        "block.py"
    ]
    
    try:
        # Remove --icon se não existir arquivo de ícone
        if not os.path.exists("icon.ico"):
            command.remove("--icon=icon.ico")
            
        subprocess.check_call(command)
        print("✅ Executável criado com sucesso!")
        print("📁 Localização: dist/AdBlocker.exe")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Erro ao criar executável: {e}")
        return False

def main():
    print("🛡️  Conversor para Executável - Bloqueador de Propagandas")
    print("=" * 60)
    
    # Instala PyInstaller
    if not install_pyinstaller():
        input("\nPressione Enter para sair...")
        return
    
    # Cria executável
    if create_executable():
        print("\n🎉 Conversão concluída!")
        print("\nArquivos gerados:")
        print("📁 dist/AdBlocker.exe - Executável principal")
        print("📁 build/ - Arquivos temporários (pode ser deletado)")
        print("\n💡 Dicas:")
        print("1. Execute AdBlocker.exe como Administrador")
        print("2. O arquivo .exe é portátil (não precisa de Python instalado)")
        print("3. Pode distribuir apenas o arquivo AdBlocker.exe")
    
    input("\nPressione Enter para sair...")

if __name__ == "__main__":
    main()