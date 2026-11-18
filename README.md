# METATRADER5

Plataforma proprietária de inteligência, pesquisa quantitativa, decisão, gestão de risco e execução sobre MetaTrader 5.

## Estrutura oficial

```text
METATRADER5/
├── README.md
├── LICENSE
├── GOVERNANCA/
├── docs/
│   ├── ARCHITECTURE.md
│   ├── ROADMAP.md
│   └── TECHNICAL_STANDARDS.md
├── MQL5/
│   ├── Experts/
│   ├── Indicators/
│   ├── Include/
│   └── Scripts/
├── PYTHON/
│   ├── data/
│   ├── research/
│   ├── backtesting/
│   └── execution/
├── STRATEGIES/
├── TESTS/
├── DATA/
└── INFRASTRUCTURE/
```

## Componentes atuais
- `MQL5/Experts/TOS/TOS_KERNEL.mq5`: kernel observacional inicial do Trading Operating System (TOS).
- `docs/ARCHITECTURE.md`: arquitetura modular.
- `docs/ROADMAP.md`: fases de desenvolvimento.
- `docs/TECHNICAL_STANDARDS.md`: padrões técnicos e de segurança.
- `docs/GUIA_TOS_METATRADER5_V0.1.md`: guia do primeiro kernel.

## Princípios obrigatórios
1. Separar ingestão de dados, análise, decisão, risco, execução e auditoria.
2. Somente o módulo de execução poderá enviar ordens.
3. O motor de risco possui veto absoluto.
4. Dados ausentes, atrasados ou contraditórios devem bloquear novas entradas.
5. Toda alteração deve ser documentada e versionada no GitHub.
6. Nenhum código será considerado homologado sem compilação e testes reproduzíveis.
7. Não presumir nem prometer rentabilidade.

## Estado
Projeto em estruturação. O kernel inicial é observacional e não envia ordens. A compilação no MetaEditor, os testes no Strategy Tester e a homologação permanecem pendentes.

## Independência do BrickMaster
O METATRADER5/TOS é um projeto independente. Não alterar nem incorporar componentes do BrickMaster sem decisão formal e documentação específica.
