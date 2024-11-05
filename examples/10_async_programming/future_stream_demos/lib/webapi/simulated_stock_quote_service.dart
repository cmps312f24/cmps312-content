import 'dart:math';

class StockQuote {
  final String name;
  final String symbol;
  final int price;

  StockQuote(this.name, this.symbol, this.price);
    @override
  String toString() => 'StockQuote(name: $name, symbol: $symbol, price: $price)';
}

class SimulatedStockQuoteService {
  final Map<String, String> companies = {
    'Apple': 'AAPL',
    'Amazon': 'AMZN',
    'Alibaba': 'BABA',
    'Salesforce': 'CRM',
    'Facebook': 'FB',
    'Google': 'GOOGL',
    'IBM': 'IBM',
    'Johnson & Johnson': 'JNJ',
    'Microsoft': 'MSFT',
    'Tesla': 'TSLA',
  };

  Future<String> getStockSymbol(String name) async {
    print('getStockSymbol($name) started...');
    // Simulate fetching stock symbol from a Web API
    await Future.delayed(Duration(milliseconds: 1500));
    final symbol = companies[name.trim()];
    print('~~getStockSymbol($name) result: $symbol');
    return symbol!;
  }

  Future<int> getPrice(String symbol) async {
    print('getPrice($symbol) started...');
    // Simulate fetching stock price from a Web API
    await Future.delayed(Duration(milliseconds: 1000));
    final price = Random().nextInt(451) + 50;
    print('~~getPrice($symbol) result: $price');
    return price;
  }

  Future<StockQuote> getStockQuote(String name) async {
    if (!companies.containsKey(name.trim())) {
      throw Exception("Getting stock quote failed. '$name' does not exist.");
    }
    final symbol = await getStockSymbol(name);
    final price = await getPrice(symbol);
    return StockQuote(name.trim(), symbol, price);
  }

  Future<List<String>> getCompanies() async {
    print('getCompanies started...');
    // Simulate fetching companies from a Web API
    await Future.delayed(Duration(milliseconds: 400));
    return companies.keys.toList();
  }
}