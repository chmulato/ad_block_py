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
    """Cria o arquivo executável com fallback para contornar erros de permissão"""
    print("🔨 Criando executável...")
    
    # Tentar pasta alternativa primeiro (sabemos que funciona)
    dist_paths = ["dist_build", "output", "dist"]
    
    # Comando base PyInstaller
    base_command = [
        "pyinstaller", "--onefile", "--noconsole", "--name=AdBlocker",
        "--add-data=README.md;.", "--hidden-import=requests", "--clean", "block.py"
    ]
    
    # Adicionar ícone se existir
    if os.path.exists("icon.ico"):
        base_command.insert(-1, "--icon=icon.ico")
    
    for dist_path in dist_paths:
        print(f"\n🎯 Tentando: {dist_path}")
        
        command = base_command.copy()
        if dist_path != "dist":
            command.insert(-1, f"--distpath={dist_path}")
        
        try:
            os.makedirs(dist_path, exist_ok=True)
            exe_path = os.path.join(dist_path, "AdBlocker.exe")
            
            # Remover exe existente se possível
            if os.path.exists(exe_path):
                try:
                    os.remove(exe_path)
                except OSError:
                    print(f"⚠️  Arquivo pode estar em uso, tentando mesmo assim...")
            
            # Executar PyInstaller (silencioso)
            subprocess.check_call(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            
            if os.path.exists(exe_path):
                print("✅ Executável criado com sucesso!")
                print(f"📁 Localização: {exe_path}")
                
                # Tentar copiar para dist se não for o padrão
                if dist_path != "dist":
                    try:
                        os.makedirs("dist", exist_ok=True)
                        import shutil
                        shutil.copy2(exe_path, "dist/AdBlocker.exe")
                        print(f"📋 Copiado para: dist/AdBlocker.exe")
                    except Exception:
                        print(f"💡 Use o executável em: {exe_path}")
                
                return True
                
        except subprocess.CalledProcessError:
            continue  # Tentar próxima pasta
        except Exception:
            continue
    
    print("\n❌ Build falhou! Use: .\\build.ps1")
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