# Padrões técnicos e de segurança — TOS

## Código
- MQL5 estrito: #property strict.
- Separar tipos, dados, features, regime, fluxo, decisão, risco, execução e auditoria.
- Funções pequenas, contratos explícitos e tratamento de erros.
- Evitar valores mágicos sem configuração documentada.
- Toda feature declara unidade, janela, origem e política para dados ausentes.

## Segurança
- Trading desabilitado por padrão.
- Nenhum envio de ordens em módulos analíticos.
- Risk Engine possui veto absoluto.
- Bloquear novas entradas em desconexão, dados inválidos/atrasados, spread excessivo, margem insuficiente ou limites excedidos.
- Idempotência contra ordens duplicadas após reinício/reprocessamento.
- Não presumir execução após OrderSend; verificar retcodes e reconciliar estado real.
- Logs sem credenciais, tokens ou dados sensíveis.

## Dados e pesquisa
- Preservar timestamps e timezone.
- Não confundir tick volume com volume financeiro negociado universal.
- Documentar limitações de DOM e fluxo por broker/mercado.
- Separar treino, validação e teste cronologicamente.
- Incluir custos, spread variável, comissão, swap e slippage.
- Reportar expectancy líquida, drawdown, profit factor, recovery, Sharpe/Sortino, exposição e estabilidade por regime.
- Evitar look-ahead, survivorship bias e data snooping.

## Versionamento e aceite
Mudanças pequenas e rastreáveis; preservar versões anteriores. Toda fase exige compilação/testes adequados, evidências, documentação e revisão. Não declarar produção nem rentabilidade sem validação independente.
