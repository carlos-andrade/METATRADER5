//+------------------------------------------------------------------+
//| TOS_KERNEL.mq5 | Trading Operating System | V0.1.0               |
//| OBSERVATION ONLY: este kernel nao envia ordens.                  |
//+------------------------------------------------------------------+
#property strict
#property version "0.10"
#property description "TOS Kernel - observacao e telemetria"

input group "TOS | Identidade"
input string InpSystemName="TOS";
input ulong InpMagicNumber=20261118;
input bool InpEnableMarketBook=false;
input int InpHeartbeatSeconds=1;

input group "TOS | Guardrails"
input bool InpAllowLiveTrading=false; // Sem execucao nesta versao
input double InpMaxSpreadPoints=30.0; // Ilustrativo: calibrar por ativo/broker
input int InpMaxTickAgeMs=5000;

enum ENUM_TOS_STATE { TOS_BOOTING=0, TOS_OBSERVING, TOS_DEGRADED, TOS_HALTED };
enum ENUM_TOS_DECISION { TOS_NO_DECISION=0, TOS_BUY_CANDIDATE, TOS_SELL_CANDIDATE, TOS_NO_TRADE };

struct TOS_MARKET_SNAPSHOT
{
   string symbol;
   datetime server_time;
   double bid,ask,spread_points,last;
   long volume;
   ulong tick_time_msc;
   bool tick_valid;
};
struct TOS_DIAGNOSTICS
{
   ulong ticks_seen,timer_beats,trade_transactions_seen,book_events_seen,rejected_snapshots;
   double last_spread_points;
   ulong last_tick_age_ms;
};
ENUM_TOS_STATE g_state=TOS_BOOTING;
ENUM_TOS_DECISION g_decision=TOS_NO_DECISION;
TOS_MARKET_SNAPSHOT g_market;
TOS_DIAGNOSTICS g_diag;
bool g_book_subscribed=false;

int OnInit()
{
   ZeroMemory(g_market); ZeroMemory(g_diag);
   if(!SymbolSelect(_Symbol,true)) { Print("[TOS][FATAL] SymbolSelect falhou"); return INIT_FAILED; }
   if(InpHeartbeatSeconds<1) return INIT_PARAMETERS_INCORRECT;
   if(InpEnableMarketBook)
   {
      g_book_subscribed=MarketBookAdd(_Symbol);
      if(!g_book_subscribed) Print("[TOS][WARN] MarketBook indisponivel");
   }
   if(!EventSetTimer(InpHeartbeatSeconds))
   {
      Print("[TOS][FATAL] EventSetTimer: ",GetLastError());
      if(g_book_subscribed) MarketBookRelease(_Symbol);
      return INIT_FAILED;
   }
   g_state=TOS_OBSERVING;
   PrintFormat("[TOS][BOOT] %s v0.10 | %s | magic=%I64u | OBSERVATION_ONLY",InpSystemName,_Symbol,InpMagicNumber);
   Print("[TOS][SAFETY] Nenhuma funcao de envio de ordens nesta versao.");
   return INIT_SUCCEEDED;
}
void OnTick()
{
   MqlTick tick; g_diag.ticks_seen++;
   if(!SymbolInfoTick(_Symbol,tick) || tick.bid<=0 || tick.ask<=0 || tick.ask<tick.bid)
   { g_diag.rejected_snapshots++; SetDegraded("Tick ausente ou cotacao invalida"); return; }
   g_market.symbol=_Symbol; g_market.server_time=TimeTradeServer();
   g_market.bid=tick.bid; g_market.ask=tick.ask; g_market.last=tick.last;
   g_market.volume=(long)tick.volume; g_market.tick_time_msc=tick.time_msc;
   g_market.spread_points=(tick.ask-tick.bid)/_Point; g_market.tick_valid=true;
   g_diag.last_spread_points=g_market.spread_points; g_decision=TOS_NO_TRADE;
   if(g_market.spread_points>InpMaxSpreadPoints) SetDegraded("Spread acima do limite");
   else if(g_state!=TOS_HALTED) g_state=TOS_OBSERVING;
}
void OnTimer()
{
   g_diag.timer_beats++;
   if(!TerminalInfoInteger(TERMINAL_CONNECTED)) { SetDegraded("Terminal desconectado"); PrintHeartbeat(); return; }
   if(!g_market.tick_valid) { SetDegraded("Aguardando primeiro tick valido"); PrintHeartbeat(); return; }
   MqlTick tick;
   if(SymbolInfoTick(_Symbol,tick))
   {
      ulong tick_msc=tick.time_msc, now_msc=(ulong)TimeTradeServer()*1000;
      g_diag.last_tick_age_ms=(now_msc>=tick_msc ? now_msc-tick_msc : 0);
   }
   if(g_diag.last_tick_age_ms>(ulong)InpMaxTickAgeMs) SetDegraded("Cotacao desatualizada");
   else if(g_market.spread_points<=InpMaxSpreadPoints) g_state=TOS_OBSERVING;
   PrintHeartbeat();
}
void OnBookEvent(const string &symbol) { if(symbol==_Symbol) g_diag.book_events_seen++; }
void OnTradeTransaction(const MqlTradeTransaction &trans,const MqlTradeRequest &request,const MqlTradeResult &result)
{
   g_diag.trade_transactions_seen++;
   if(trans.type==TRADE_TRANSACTION_REQUEST)
      PrintFormat("[TOS][TRADE_EVENT] retcode=%u order=%I64u deal=%I64u comment=%s",result.retcode,result.order,result.deal,result.comment);
}
void OnDeinit(const int reason)
{
   EventKillTimer(); if(g_book_subscribed) MarketBookRelease(_Symbol);
   PrintFormat("[TOS][STOP] reason=%d ticks=%I64u timer=%I64u trades=%I64u book=%I64u",reason,g_diag.ticks_seen,g_diag.timer_beats,g_diag.trade_transactions_seen,g_diag.book_events_seen);
}
void SetDegraded(const string reason) { if(g_state!=TOS_HALTED) g_state=TOS_DEGRADED; Print("[TOS][DEGRADED] ",reason); }
void PrintHeartbeat()
{
   PrintFormat("[TOS][HEALTH] state=%s symbol=%s ticks=%I64u spread=%.1f age_ms=%I64u decision=%s",StateToString(g_state),_Symbol,g_diag.ticks_seen,g_diag.last_spread_points,g_diag.last_tick_age_ms,DecisionToString(g_decision));
}
string StateToString(const ENUM_TOS_STATE state)
{
   switch(state) { case TOS_BOOTING:return "BOOTING"; case TOS_OBSERVING:return "OBSERVING"; case TOS_DEGRADED:return "DEGRADED"; case TOS_HALTED:return "HALTED"; }
   return "UNKNOWN";
}
string DecisionToString(const ENUM_TOS_DECISION decision)
{
   switch(decision) { case TOS_NO_DECISION:return "NO_DECISION"; case TOS_BUY_CANDIDATE:return "BUY_CANDIDATE"; case TOS_SELL_CANDIDATE:return "SELL_CANDIDATE"; case TOS_NO_TRADE:return "NO_TRADE"; }
   return "UNKNOWN";
}
// Contrato futuro: DataFeed -> Features -> Regime/Flow -> Gyroscope -> Signal
// -> Risk (veto absoluto) -> Execution (unico modulo autorizado) -> Audit.
// Modulos analiticos nunca enviam ordens.
