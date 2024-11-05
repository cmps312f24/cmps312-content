/*
{
status: "OK",
from: "2024-11-04",
symbol: "AMZN",
open: 196.45,
high: 197.33,
low: 194.3101,
close: 195.78,
volume: 37295176,
afterHours: 195.11,
preMarket: 197.29
}
*/
class MarketStockQuote {
  final String? status;
  final String? date;
  final String? symbol;
  final double? price;
  final double? high;
  final double? low;
  final double? close;

  MarketStockQuote({
    this.status,
    this.date,
    this.symbol,
    this.price,
    this.high,
    this.low,
    this.close,
  });

  factory MarketStockQuote.fromJson(Map<String, dynamic> json) {
    return MarketStockQuote(
      status: json['status'] as String?,
      date: json['from'] as String?,
      symbol: json['symbol'] as String?,
      price: (json['open'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      low: (json['low'] as num?)?.toDouble(),
      close: (json['close'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'from': date,
      'symbol': symbol,
      'open': price,
      'high': high,
      'low': low,
      'close': close,
    };
  }
}
