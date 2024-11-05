import 'package:dio/dio.dart';
import 'package:future_stream_demos/model/market_stock_quote.dart';
import 'package:intl/intl.dart';

class StockQuoteService {
  static const String BASE_URL = "https://api.polygon.io/v1/open-close";
  static const String API_KEY = "Jjtxe7HOP_ZjzWK3kwYQu2ovpzxTPEIp";
  final Dio _dio = Dio();

  StockQuoteService() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<MarketStockQuote> getStockQuote(String symbol) async {
    final date = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 1)));
    final url = "/$symbol/$date?apiKey=$API_KEY";
    print(">>> Debug: getStockQuote.url: $url");

    final response = await _dio.get(url);
    return MarketStockQuote.fromJson(response.data);
  }
}
