import 'package:flutter_riverpod/flutter_riverpod.dart';

// Defining a Provider for the API URL
final apiUrlProvider = Provider<String>(
  (ref) => "https://api.example.com"
);
