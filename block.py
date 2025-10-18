#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para Bloqueio de Propagandas no Windows
Bloqueia domínios de propaganda modificando o arquivo hosts
Autor: Assistant
Data: 2025
"""

import os
import sys
import ctypes
import requests
import shutil
from datetime import datetime
import logging

# Configuração de logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('adblock.log'),
        logging.StreamHandler()
    ]
)

class AdBlocker:
    def __init__(self):
        self.hosts_file = r"C:\Windows\System32\drivers\etc\hosts"
        self.backup_file = r"C:\Windows\System32\drivers\etc\hosts.backup"
        self.marker_start = "# === INÍCIO BLOQUEIO DE PROPAGANDAS ==="
        self.marker_end = "# === FIM BLOQUEIO DE PROPAGANDAS ==="
        
    def check_admin_privileges(self):
        """Verifica se o script está sendo executado como administrador"""
        try:
            return ctypes.windll.shell32.IsUserAnAdmin()
        except:
            return False
    
    def request_admin_privileges(self):
        """Solicita privilégios de administrador"""
        if not self.check_admin_privileges():
            logging.warning("Privilégios de administrador necessários!")
            # Reexecuta o script como administrador
            ctypes.windll.shell32.ShellExecuteW(
                None, 
                "runas", 
                sys.executable, 
                " ".join(sys.argv), 
                None, 
                1
            )
            return False
        return True
    
    def create_backup(self):
        """Cria backup do arquivo hosts original"""
        try:
            if not os.path.exists(self.backup_file):
                shutil.copy2(self.hosts_file, self.backup_file)
                logging.info(f"Backup criado: {self.backup_file}")
            return True
        except Exception as e:
            logging.error(f"Erro ao criar backup: {e}")
            return False
    
    def get_ad_domains(self):
        """Obtém lista de domínios de propaganda de fontes confiáveis"""
        ad_domains = set()
        
        # Lista local de domínios conhecidos
        local_domains = [
            # Google Ads
            "googleadservices.com",
            "googlesyndication.com",
            "doubleclick.net",
            "googletagmanager.com",
            "google-analytics.com",
            
            # Facebook Ads
            "facebook.com",
            "connect.facebook.net",
            "fbcdn.net",
            
            # Outros domínios de propaganda
            "amazon-adsystem.com",
            "adsystem.amazon.com",
            "googletag.pubads.com",
            "pubads.g.doubleclick.net",
            "tpc.googlesyndication.com",
            "pagead2.googlesyndication.com",
            "partner.googleadservices.com",
            "ads.yahoo.com",
            "advertising.com",
            "adsymptotic.com",
            "adnxs.com",
            "adsystem.com",
            "outbrain.com",
            "taboola.com",
            "scorecardresearch.com",
            "quantserve.com",
            "2mdn.net",
            "adsafeprotected.com",
            "moatads.com",
            "adsystem.amazon.co.uk",
            "adsystem.amazon.de",
            "adsystem.amazon.fr",
            "adsystem.amazon.it",
            "adsystem.amazon.es",
            
            # Redes sociais - tracking
            "analytics.twitter.com",
            "ads-twitter.com",
            "linkedin.com",
            "ads.linkedin.com",
            
            # Outros trackers
            "hotjar.com",
            "fullstory.com",
            "segment.com",
            "mixpanel.com",
            "amplitude.com"
        ]
        
        ad_domains.update(local_domains)
        
        # Tentar obter listas online
        online_sources = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
            "https://someonewhocares.org/hosts/zero/hosts",
            "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/BaseFilter/sections/adservers.txt"
        ]
        
        for source in online_sources:
            try:
                logging.info(f"Baixando lista de: {source}")
                response = requests.get(source, timeout=10)
                if response.status_code == 200:
                    lines = response.text.split('\n')
                    for line in lines:
                        line = line.strip()
                        if line and not line.startswith('#'):
                            if line.startswith('0.0.0.0'):
                                domain = line.split()[1] if len(line.split()) > 1 else None
                                if domain and domain != '0.0.0.0':
                                    ad_domains.add(domain)
                            elif line.startswith('127.0.0.1'):
                                domain = line.split()[1] if len(line.split()) > 1 else None
                                if domain and domain != 'localhost':
                                    ad_domains.add(domain)
                    logging.info(f"Lista baixada com sucesso de: {source}")
                    break  # Use apenas a primeira fonte que funcionar
            except Exception as e:
                logging.warning(f"Erro ao baixar de {source}: {e}")
                continue
        
        return sorted(list(ad_domains))
    
    def remove_existing_blocks(self):
        """Remove bloqueios existentes do arquivo hosts"""
        try:
            with open(self.hosts_file, 'r', encoding='utf-8') as f:
                lines = f.readlines()
            
            new_lines = []
            skip = False
            
            for line in lines:
                if self.marker_start in line:
                    skip = True
                    continue
                elif self.marker_end in line:
                    skip = False
                    continue
                elif not skip:
                    new_lines.append(line)
            
            with open(self.hosts_file, 'w', encoding='utf-8') as f:
                f.writelines(new_lines)
            
            logging.info("Bloqueios anteriores removidos")
            return True
        except Exception as e:
            logging.error(f"Erro ao remover bloqueios existentes: {e}")
            return False
    
    def add_ad_blocks(self, domains):
        """Adiciona domínios de propaganda ao arquivo hosts"""
        try:
            # Remove bloqueios existentes primeiro
            self.remove_existing_blocks()
            
            # Adiciona novos bloqueios
            with open(self.hosts_file, 'a', encoding='utf-8') as f:
                f.write(f"\n{self.marker_start}\n")
                f.write(f"# Adicionado em: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
                f.write(f"# Total de domínios bloqueados: {len(domains)}\n\n")
                
                for domain in domains:
                    f.write(f"0.0.0.0 {domain}\n")
                    f.write(f"0.0.0.0 www.{domain}\n")
                
                f.write(f"\n{self.marker_end}\n")
            
            logging.info(f"Bloqueados {len(domains)} domínios de propaganda")
            return True
        except Exception as e:
            logging.error(f"Erro ao adicionar bloqueios: {e}")
            return False
    
    def flush_dns(self):
        """Limpa o cache DNS do Windows"""
        try:
            os.system("ipconfig /flushdns")
            logging.info("Cache DNS limpo")
            return True
        except Exception as e:
            logging.error(f"Erro ao limpar cache DNS: {e}")
            return False
    
    def restore_backup(self):
        """Restaura o arquivo hosts do backup"""
        try:
            if os.path.exists(self.backup_file):
                shutil.copy2(self.backup_file, self.hosts_file)
                logging.info("Arquivo hosts restaurado do backup")
                return True
            else:
                logging.error("Arquivo de backup não encontrado")
                return False
        except Exception as e:
            logging.error(f"Erro ao restaurar backup: {e}")
            return False
    
    def run(self, action="block"):
        """Executa o bloqueio ou desbloqueio"""
        # Verifica privilégios de administrador
        if not self.request_admin_privileges():
            return False
        
        try:
            if action == "block":
                logging.info("Iniciando bloqueio de propagandas...")
                
                # Cria backup
                if not self.create_backup():
                    return False
                
                # Obtém lista de domínios
                logging.info("Obtendo lista de domínios de propaganda...")
                domains = self.get_ad_domains()
                
                if not domains:
                    logging.error("Nenhum domínio encontrado para bloquear")
                    return False
                
                # Adiciona bloqueios
                if self.add_ad_blocks(domains):
                    # Limpa cache DNS
                    self.flush_dns()
                    logging.info("Bloqueio de propagandas ativado com sucesso!")
                    print(f"\n✅ Bloqueio ativado! {len(domains)} domínios bloqueados.")
                    print("Reinicie seu navegador para que as alterações tenham efeito.")
                    return True
                else:
                    return False
                    
            elif action == "unblock":
                logging.info("Removendo bloqueio de propagandas...")
                if self.restore_backup():
                    self.flush_dns()
                    logging.info("Bloqueio removido com sucesso!")
                    print("\n✅ Bloqueio removido! Propagandas voltarão a aparecer.")
                    return True
                else:
                    return False
            
        except Exception as e:
            logging.error(f"Erro durante execução: {e}")
            print(f"\n❌ Erro: {e}")
            return False

def main():
    """Função principal"""
    print("🛡️  Bloqueador de Propagandas para Windows")
    print("=" * 50)
    
    blocker = AdBlocker()
    
    if len(sys.argv) > 1:
        action = sys.argv[1].lower()
        if action in ["unblock", "restore", "remove"]:
            success = blocker.run("unblock")
        else:
            success = blocker.run("block")
    else:
        # Menu interativo
        print("\nEscolha uma opção:")
        print("1. Bloquear propagandas")
        print("2. Desbloquear propagandas")
        print("3. Sair")
        
        choice = input("\nDigite sua escolha (1-3): ").strip()
        
        if choice == "1":
            success = blocker.run("block")
        elif choice == "2":
            success = blocker.run("unblock")
        elif choice == "3":
            print("Saindo...")
            return
        else:
            print("Opção inválida!")
            return
    
    input("\nPressione Enter para sair...")

if __name__ == "__main__":
    main()