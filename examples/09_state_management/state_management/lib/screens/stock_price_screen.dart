import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/stock_price_provider.dart';

class StockPriceScreen extends ConsumerWidget {
  const StockPriceScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockPriceAsync = ref.watch(stockPriceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Stock Price")),
      body: Center(
        // UI updates whenever new stock prices are received, 
        // and handles loading and error states
        child: stockPriceAsync.when(
          data: (price) => Text("Stock Price: \$${price.toStringAsFixed(2)}"),
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text("Error: $err"),
        ),
      ),
    );
  }
}
