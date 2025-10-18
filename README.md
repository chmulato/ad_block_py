# 🛡️ Bloqueador de Propagandas para Windows

Bloqueia propagandas em **todos os navegadores** modificando o arquivo hosts do Windows. Funciona com Chrome, Firefox, Edge, Safari, Opera e qualquer outro navegador.

## ⚡ Uso Rápido (3 Passos)

### 🎯 Método 1: Executável (Recomendado)

1. **Clique com botão direito** em `AdBlocker.exe`
2. **Selecione** "Executar como administrador"
3. **Digite** `1` e pressione Enter
4. **Reinicie** seu navegador

**Pronto!** Propagandas bloqueadas! 🎉

### 🎯 Método 2: Instalação Automática

Execute como Administrador: `install_complete.bat`

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

**Solução:** Execute `AdBlocker.exe` → Opção "2" (Desbloquear) → Teste o site

## 📁 Arquivos Principais

- **`AdBlocker.exe`** - Executável principal (12.58 MB, não precisa Python)
- **`block.py`** - Código-fonte Python original
- **`install_complete.bat`** - Instalador automático completo

## 🔧 Para Desenvolvedores

### Converter Python para EXE

```batch
build_exe_advanced.bat    # Conversão otimizada
build_exe.bat            # Conversão básica
```

### Executar Script Python

```batch
run_adblock.bat          # Requer Python instalado
```

## 🗑️ Desinstalação

1. Execute `AdBlocker.exe` como Administrador
2. Escolha opção "2" (Desbloquear propagandas)
3. Delete os arquivos do programa

**Ou execute:** `uninstall.bat` como Administrador

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

- 🐛 Reportar bugs via [Issues](https://github.com/chmulato/ad_block_py/issues)
- 💡 Sugerir melhorias
- 🔧 Enviar Pull Requests
- ⭐ Dar uma estrela no projeto

---

**🎯 Resultado:** Navegação sem propagandas, mais rápida e segura! 🚀