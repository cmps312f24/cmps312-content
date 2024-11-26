import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places/providers/internet_connection.dart';
import 'package:favourite_places/ui/screens/no_internet.dart';

class ConnectivityWrapper extends ConsumerWidget {
  final Widget child;

  const ConnectivityWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(connectivityProvider);

    return isConnected
        ? child
        : const Directionality(
            textDirection: TextDirection.ltr,
            child: NoInternet(),
          );
  }
}
