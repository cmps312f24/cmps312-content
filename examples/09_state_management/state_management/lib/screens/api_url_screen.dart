import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/providers/api_url_provider.dart';

class ApiUrlScreen extends ConsumerWidget {
  const ApiUrlScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Reading the API URL using the provider
    final apiUrl = ref.watch(apiUrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('API URL Example')),
      body: Center(
        child: Text('API URL: $apiUrl'),
      ),
    );
  }
}
