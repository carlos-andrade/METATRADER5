# Guia de engenharia — TOS V0.1

O TOS Kernel é um Expert Advisor de observação. Não envia ordens, não modifica posições e não implementa estratégia lucrativa. Estabelece ciclo de vida, telemetria, verificação básica de dados e contratos futuros.

## Instalação de teste
1. Copiar MQL5/Experts/TOS/TOS_KERNEL.mq5 para a pasta correspondente do terminal.
2. Abrir no MetaEditor e compilar.
3. Executar inicialmente em conta demo e gráfico de observação.
4. Verificar logs de inicialização, heartbeat, spread, idade dos ticks e encerramento.
5. Testar desconexão, ausência de ticks e símbolos com diferentes especificações.

O limite de spread é ilustrativo e deve ser calibrado por símbolo, sessão e broker. Compilação e homologação ainda precisam ser realizadas no MT5.

## Arquitetura-alvo
Data Feed → Feature Store → Regime/Flow → Giroscópio → Signal → Risk → Execution → Audit.

## Giroscópio
Avalia coerência entre regime, fluxo, liquidez, volatilidade e contexto. Não soma indicadores arbitrariamente. Estados conflitantes ou dados degradados bloqueiam novas entradas.

## Segurança
Somente o futuro Execution Engine poderá enviar ordens. O Risk Engine terá veto absoluto. A chamada de envio não confirma execução; reconciliar ordens, deals e posições reais.

## Validação
Separação cronológica, walk-forward, custos realistas, slippage, stress tests e robustez. Não há promessa de rentabilidade.

## BrickMaster
Projeto independente. Preservar o escopo do BrickMaster e não misturar execução ou módulos sem decisão formal.
