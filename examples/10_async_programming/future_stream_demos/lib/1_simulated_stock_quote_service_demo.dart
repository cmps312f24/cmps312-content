import 'package:future_stream_demos/webapi/simulated_stock_quote_service.dart';

Future<void> main() async {
  final company = 'Apple';

  final stockQuoteService = SimulatedStockQuoteService();
  final symbol = await stockQuoteService.getStockSymbol(company);
  print('>> $company ($symbol)');

  final quote = await stockQuoteService.getStockQuote(company);
  print('>> $company (${quote.symbol}) = ${quote.price}');
  print('>> StockQuote: $quote');
}
