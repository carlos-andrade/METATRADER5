# TOS — Arquitetura de referência

## Objetivo
Plataforma modular de inteligência e execução financeira sobre MetaTrader 5.

## Camadas
1. **Market Data Engine:** ticks, barras, spread, sessões e profundidade quando fornecida pelo broker.
2. **Feature Store:** variáveis determinísticas com timestamp, origem, unidade, qualidade e versão.
3. **Regime Engine:** tendência, range, compressão, expansão e transição.
4. **Flow Engine:** agressão, delta, absorção e desequilíbrio somente quando os dados sustentarem inferência válida.
5. **Giroscópio:** coerência entre regime, fluxo, liquidez, volatilidade e contexto.
6. **Signal Engine:** candidato direcional ou NO_TRADE, com evidências e invalidação.
7. **Risk Engine:** dimensionamento, exposição, margem, limites e veto absoluto.
8. **Execution Engine:** único componente autorizado a enviar, alterar ou cancelar ordens após homologação.
9. **Audit & Telemetry:** registro de dados, decisões, ordens, deals, versões e incidentes.

## Giroscópio
Não é indicador convencional nem soma arbitrária de indicadores. É um classificador de estabilidade decisória. Estados propostos: STABLE_TREND, BALANCED_RANGE, VOLATILITY_EXPANSION, LIQUIDITY_STRESS, CONFLICTED e DATA_DEGRADED. Dados essenciais ausentes, atrasados ou contraditórios bloqueiam novas entradas.

## Contrato de decisão
Cada decisão registra ID, timestamp, símbolo, sessão, timeframe, versão do modelo, qualidade dos dados, regime, estado do Giroscópio, features, evidências contrárias, hipótese, invalidação, horizonte, risco monetário e motivo de autorização/veto.

## Fluxo
Market Data → Features → Regime/Flow → Giroscópio → Signal → Risk Veto → Execution → Reconciliation → Audit.

Nenhum módulo analítico envia ordens. O risco pode vetar qualquer sinal. Solicitação de ordem não equivale a execução; reconciliar com ordens, deals e posições reais.

## BrickMaster
TOS é independente. Preservar o escopo analítico estabelecido para BrickMaster; não importar módulos, regras ou execução entre projetos sem decisão formal.
