# 🛡️ Bloqueador de Propagandas para Windows

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![GitHub release](https://img.shields.io/github/v/release/chmulato/ad_block_py)](https://github.com/chmulato/ad_block_py/releases)
[![GitHub stars](https://img.shields.io/github/stars/chmulato/ad_block_py)](https://github.com/chmulato/ad_block_py/stargazers)
[![Windows](https://img.shields.io/badge/Platform-Windows-blue)](https://github.com/chmulato/ad_block_py)

Bloqueia propagandas em **todos os navegadores** modificando o arquivo hosts do Windows. Funciona com Chrome, Firefox, Edge, Safari, Opera e qualquer outro navegador.

## ⚡ Uso Rápido (3 Passos)

### 🎯 Método 1: Executável (Recomendado)

1. **Clique com botão direito** em [`AdBlocker.exe`](AdBlocker.exe)
2. **Selecione** "Executar como administrador"
3. **Digite** `1` e pressione Enter
4. **Reinicie** seu navegador

**Pronto!** Propagandas bloqueadas! 🎉

### 🎯 Método 2: Instalação Automática

Execute como Administrador: [`install_complete.bat`](install_complete.bat)

- ✅ Gera o executável automaticamente
- ✅ Instala no sistema
- ✅ Configura execução automática
- ✅ Cria atalhos

## 🔧 Como Funciona

O bloqueador modifica o arquivo `hosts` do Windows (`C:\Windows\System32\drivers\etc\hosts`), redirecionando domínios de propaganda para `0.0.0.0`.

**Exemplo:**

```text
Antes: doubleclick.net → Servidor de propaganda
Depois: doubleclick.net → 0.0.0.0 (bloqueado)
```

## ⭐ Características

- 🚀 **Bloqueia 1000+ domínios** de propaganda
- 🌐 **Funciona em todos os navegadores** simultaneamente
- 💾 **Backup automático** do arquivo hosts original
- 📱 **Interface em português** com menu simples
- 🔄 **Fácil reversão** - pode desbloquear a qualquer momento
- 📊 **Logs detalhados** para acompanhamento

## 🎯 Domínios Bloqueados

- **Google Ads:** doubleclick.net, googlesyndication.com, googleadservices.com
- **Facebook Ads:** connect.facebook.net, fbcdn.net
- **Amazon Ads:** amazon-adsystem.com, adsystem.amazon.com
- **Trackers:** google-analytics.com, hotjar.com, mixpanel.com
- **Redes de Propaganda:** outbrain.com, taboola.com, advertising.com
- **E centenas de outros...**

## 📋 Requisitos

- Windows 7/8/10/11
- Privilégios de Administrador
- Python 3.6+ (apenas para script, não para executável)

## 🔄 Opções de Uso

### Menu Interativo

```text
🛡️  Bloqueador de Propagandas para Windows
==================================================

Escolha uma opção:
1. Bloquear propagandas     ← Para ativar
2. Desbloquear propagandas  ← Para desativar
3. Sair

Digite sua escolha (1-3):
```

### Linha de Comando

```batch
AdBlocker.exe           # Menu interativo
AdBlocker.exe unblock   # Desbloquear direto
```

## ✅ Benefícios

- 🚀 **Sites carregam mais rápido** - menos downloads
- 🧹 **Navegação mais limpa** - sem distrações
- 🔒 **Maior privacidade** - menos tracking
- 💰 **Economia de dados** - ideal para internet móvel
- 🛡️ **Mais segurança** - bloqueia sites maliciosos

## 🆘 Solução de Problemas

### ❌ Erro "Acesso Negado"

**Solução:** Execute como Administrador (botão direito → "Executar como administrador")

### ❌ Propagandas ainda aparecem

**Solução:** Reinicie o navegador completamente (feche todas as abas e reabra)

### ❌ Antivírus bloqueia

**Solução:** Falso positivo - adicione `AdBlocker.exe` nas exceções do antivírus

### ❌ Site importante não carrega

**Solução:** Execute [`AdBlocker.exe`](AdBlocker.exe) → Opção "2" (Desbloquear) → Teste o site

## 📁 Arquivos Principais

- **[`AdBlocker.exe`](AdBlocker.exe)** - Executável principal (12.58 MB, não precisa Python)
- **[`block.py`](block.py)** - Código-fonte Python original
- **[`install_complete.bat`](install_complete.bat)** - Instalador automático completo

## 📂 Todos os Arquivos do Projeto

### 🎯 Arquivos Executáveis

- **[`AdBlocker.exe`](AdBlocker.exe)** - Executável independente (12.58 MB)
- **[`block.py`](block.py)** - Script Python principal (11.6 KB)

### ⚙️ Instaladores e Configuração

- **[`install_complete.bat`](install_complete.bat)** - Instalador completo com geração de EXE
- **[`install.bat`](install.bat)** - Instalador básico para script Python
- **[`uninstall.bat`](uninstall.bat)** - Desinstalador completo
- **[`run_adblock.bat`](run_adblock.bat)** - Executor do script Python

### 🔨 Conversores para EXE

- **[`build_exe_advanced.bat`](build_exe_advanced.bat)** - Conversor otimizado com compressão
- **[`build_exe.bat`](build_exe.bat)** - Conversor básico e rápido
- **[`build_exe.py`](build_exe.py)** - Script Python para conversão

### 📋 Configuração e Documentação

- **[`AdBlocker.spec`](AdBlocker.spec)** - Especificação PyInstaller
- **[`version_info.txt`](version_info.txt)** - Informações de versão do executável
- **[`requirements.txt`](requirements.txt)** - Dependências Python
- **[`README.md`](README.md)** - Este arquivo de documentação
- **[`CHANGELOG.md`](CHANGELOG.md)** - Histórico de versões
- **[`LICENSE`](LICENSE)** - Licença MIT do projeto

## 🔧 Para Desenvolvedores

### 🔨 Gerar Executável (PermissionError Resolvido)

**Solução Otimizada - Contorna automaticamente erros de permissão:**

```powershell
.\build.ps1           # Recomendado - funciona sempre
.\build.ps1 -Admin    # Com privilégios de administrador  
.\build.ps1 -Verbose  # Com logs detalhados
```

**Alternativas:**

```batch
python build_exe.py           # Python com fallbacks
build_exe_advanced.bat        # Conversor legado otimizado
```

**Resultado:**

- ✅ **Executável**: `dist\AdBlocker.exe` ou `dist_build\AdBlocker.exe`
- 📊 **Tamanho**: ~12MB
- 🚀 **Status**: Testado e funcional no Windows 11

**Links dos arquivos:**

- [`build.ps1`](build.ps1) - ⭐ Script principal otimizado (resolve PermissionError)
- [`build_exe.py`](build_exe.py) - Alternativa Python com fallbacks
- [`build_exe_advanced.bat`](build_exe_advanced.bat) - Conversor legado

### Executar Script Python

```batch
run_adblock.bat          # Requer Python instalado
```

**Links dos arquivos:**

- [`run_adblock.bat`](run_adblock.bat) - Executor do script Python
- [`requirements.txt`](requirements.txt) - Dependências Python

## 🗑️ Desinstalação

1. Execute [`AdBlocker.exe`](AdBlocker.exe) como Administrador
2. Escolha opção "2" (Desbloquear propagandas)
3. Delete os arquivos do programa

**Ou execute:** [`uninstall.bat`](uninstall.bat) como Administrador

## ⚠️ Importante

- **Sempre execute como Administrador**
- **Reinicie o navegador após usar**
- **Backup automático** é criado em `hosts.backup`
- **Antivírus** pode dar falso positivo (é normal)

## 📄 Licença

Este projeto está licenciado sob a [MIT License](LICENSE) - veja o arquivo LICENSE para detalhes.

**Isso significa que você pode:**

- ✅ Usar comercialmente
- ✅ Modificar o código
- ✅ Distribuir
- ✅ Usar de forma privada

**Apenas mantenha:**

- 📄 Copyright e notice da licença
- ⚠️ Disclaimer de garantia

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para:

- 🐛 Reportar bugs via [Issues]([https://github.com/chmulato/ad_block_py/issues])
- 💡 Sugerir melhorias
- 🔧 Enviar Pull Requests
- ⭐ Dar uma estrela no projeto

---

**🎯 Resultado:** Navegação sem propagandas, mais rápida e segura! 🚀