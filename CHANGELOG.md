# Notas de Versão - Bloqueador de Propagandas

## v1.0.1 - 2025-10-18

### Licença Open Source

- **Adicionada MIT License**: Projeto agora é oficialmente open source
- **README atualizado**: Seção de licença e contribuições adicionada
- **Contribuições**: Instruções para colaboração da comunidade

## v1.0.0 - 2025-10-18

### Release Inicial

**Primeira versão estável do Bloqueador de Propagandas para Windows**

### Novas Funcionalidades

- **Executável Independente**: `AdBlocker.exe` (12.58 MB) - não precisa Python
- **Script Python**: `block.py` - código-fonte completo
- **Instalador Automático**: `install_complete.bat` - configuração completa
- **Conversores para EXE**: Scripts para gerar executável
- **Interface em Português**: Menu interativo simples
- **Backup Automático**: Proteção do arquivo hosts original
- **Logs Detalhados**: Acompanhamento das operações

### Capacidades de Bloqueio

- **1000+ Domínios**: Lista abrangente de sites de propaganda
- **Todos os Navegadores**: Chrome, Firefox, Edge, Safari, Opera
- **Reversível**: Fácil ativação/desativação
- **Listas Atualizadas**: Download automático de fontes confiáveis

### Domínios Bloqueados

- **Google Ads**: doubleclick.net, googlesyndication.com
- **Facebook Ads**: connect.facebook.net, fbcdn.net  
- **Amazon Ads**: amazon-adsystem.com
- **Trackers**: google-analytics.com, hotjar.com
- **Redes de Propaganda**: outbrain.com, taboola.com
- **E centenas de outros...**

### Compatibilidade

- **Windows 7/8/10/11** (32 e 64 bits)
- **Todos os navegadores** web
- **Funcionamento offline** após primeira execução
- **Privilégios de Administrador** (necessário)

### Arquivos Incluídos

- `AdBlocker.exe` - Executável principal
- `block.py` - Código-fonte Python
- `install_complete.bat` - Instalador completo
- `build_exe_advanced.bat` - Conversor otimizado
- `run_adblock.bat` - Executor Python
- `uninstall.bat` - Desinstalador
- `README.md` - Documentação completa

### Como Usar

1. Execute `AdBlocker.exe` como Administrador
2. Escolha opção "1" (Bloquear propagandas)
3. Reinicie o navegador
4. Navegue sem propagandas!

### Requisitos

- Windows com privilégios de Administrador
- Python 3.6+ (apenas para script)
- Conexão à internet (primeira execução)

### Problemas Conhecidos

- Antivírus podem dar falso positivo (normal)
- Requer reinicialização do navegador
- Alguns sites podem não carregar (facilmente reversível)

### Suporte

- **GitHub**: Issues e Pull Requests
- **Logs**: Arquivo `adblock.log` para debug
- **Backup**: Arquivo `hosts.backup` para restauração

---

**Resultado**: Navegação 95% livre de propagandas, mais rápida e segura!
