# Roadmap — METATRADER5 TOS

## FASE 0 — Kernel observacional
**Estado:** artefato inicial criado; validação pendente.
- EA de observação e telemetria.
- Verificar compilação, eventos, desconexão e reconexão.
- Sem envio de ordens.

## FASE 1 — Governança e contratos
**Estado:** documentação inicial criada; aprovação técnica pendente.
- Convenções de nomes, versionamento e revisão.
- Contratos de dados, decisões, risco e auditoria.
- Critérios formais de aceite.

## FASE 2 — Data Feed e Feature Store
Ticks, rates, metadados de símbolo, tick size, volume, timezone, sessão, frescor, integridade, lacunas e proveniência.

## FASE 3 — Regime e fluxo
Classificação de regimes, features de volatilidade e estrutura. Fluxo e DOM somente com fonte adequada.

## FASE 4 — Giroscópio
Estados interpretáveis, coerência, conflito, estabilidade e testes de sensibilidade.

## FASE 5 — Signal Engine
Candidatos com evidências, invalidação e expiração. NO_TRADE como resultado legítimo. Sem execução.

## FASE 6 — Risk Engine
Risco por operação e agregado, limites diários, exposição, margem e cenários de falha. Veto independente da estratégia.

## FASE 7 — Execution Engine
Somente após aprovação dos contratos e do risco. OrderCheck, validação de volume/preço/stops, retcodes e reconciliação. Inicialmente Strategy Tester e demo.

## FASE 8 — Homologação e produção gradual
Testes fora da amostra e walk-forward, custos, slippage, gaps, falhas de conexão, stress tests e monitoramento. Produção após critérios formais.

## Critério de conclusão
Código não conclui fase sozinho: exigir testes reproduzíveis, documentação, evidência, revisão de risco e aceite explícito.
