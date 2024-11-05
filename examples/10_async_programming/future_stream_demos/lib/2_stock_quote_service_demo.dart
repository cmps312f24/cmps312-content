import 'package:future_stream_demos/webapi/stock_quote_service.dart';

Future<void> main() async {
  final company = 'Apple';
  final symbol = 'AAPL';

  final stockQuoteService = StockQuoteService();
  var quote = await stockQuoteService.getStockQuote(symbol);
  print('>> $company (${quote.symbol}) = ${quote.price}');

  quote = await stockQuoteService.getStockQuote("TSLA");
  print('>> (${quote.symbol}) = ${quote.price}');
}
