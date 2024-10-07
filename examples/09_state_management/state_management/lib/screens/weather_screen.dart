import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/weather_provider.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Weather Forecast')),
      body: Center(
        child: weatherAsync.when(
          loading: () => const CircularProgressIndicator(), // Loading state
          error: (err, stack) => Text('Error: $err'), // Error state
          data: (weather) => Text('Weather: $weather'), // Success state
        ),
      ),
    );
  }
}
