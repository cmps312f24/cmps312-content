import 'package:async_demo_app/components/click_counter.dart';
import 'package:async_demo_app/providers/prime_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WhyAsyncScreen extends ConsumerStatefulWidget {
  const WhyAsyncScreen() : super();
  @override
  _WhyAsyncScreenState createState() => _WhyAsyncScreenState();
}

class _WhyAsyncScreenState extends ConsumerState<WhyAsyncScreen> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    final primeAsync = ref.watch(asyncPrimeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Why Async'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              children: [
                ClickCounter(),
                Text("Click to check that the UI is still responsive 😃"),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(result),
            const SizedBox(height: 16.0),
            Center(
              child: primeAsync.when(
                loading: () =>
                    const CircularProgressIndicator(), // Loading state
                error: (err, stack) => Text('Error: $err'), // Error state
                data: (prime) => Text('Prime async: $prime'), // Success state
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      result = "Started long running task on Main Thread";
                    });
                    setState(() {
                      result = "Prime: ${nextProbablePrime()}";
                    });
                  },
                  child: const Text("Long Running Task on Main Thread"),
                ),
                const Text("👎👎👎 Blocks the main thread and freezes the App"),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      result = "Started long running task using a Future";
                    });
                    ref.read(asyncPrimeProvider.notifier).getPrimeBigIntAsync();
                  },
                  child: const Text("Long Running Task using a Future"),
                ),
                const Text("👎 Still blocks the UI"),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      result = "Started long running task in an Isolate";
                    });
                    ref
                        .read(asyncPrimeProvider.notifier)
                        .getPrimeBigIntIsolate();
                  },
                  child: const Text("Long Running Task in an Isolate"),
                ),
                const Text("👍 Does not blcok the UI"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}