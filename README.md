# METATRADER5 — Trading Operating System (TOS)

Plataforma proprietária de inteligência, decisão, gestão de risco, execução e auditoria sobre MetaTrader 5.

## Estado atual
- TOS Kernel V0.1.0: Expert Advisor observacional, sem envio de ordens.
- Trading ao vivo desabilitado; nenhuma execução automática implementada.
- Compilação no MetaEditor, Strategy Tester e homologação ainda pendentes.

## Princípios
1. Separar análise, decisão, risco e execução.
2. Somente Execution Engine poderá futuramente enviar ordens.
3. Risk Engine possui veto absoluto.
4. Dados ausentes, atrasados ou contraditórios implicam NO_TRADE.
5. Decisões auditáveis, reproduzíveis e versionadas.
6. Nenhuma rentabilidade é garantida.

## Documentação
- [Arquitetura](docs/ARCHITECTURE.md)
- [Roadmap](docs/ROADMAP.md)
- [Padrões técnicos](docs/TECHNICAL_STANDARDS.md)
- [Guia V0.1](docs/GUIA_TOS_METATRADER5_V0.1.md)
- Kernel: MQL5/Experts/TOS/TOS_KERNEL.mq5

O TOS é uma plataforma de negociação sobre MT5, não um sistema operacional de computador. O projeto é independente do BrickMaster; não alterar seu escopo sem decisão formal.
