import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/components/accordian_customer.dart';
import 'package:yalapay/data_classes/customer_args.dart';
import 'package:yalapay/providers/customer_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/routes/app_router.dart';


class CustomerScreen extends ConsumerStatefulWidget {
  const CustomerScreen({super.key});

  @override
  ConsumerState<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends ConsumerState<CustomerScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool logged = await ref.read(loginProviderNotifier.notifier).isLoggedIn();

      if(!logged){
        GoRouter.of(context).go(AppRouter.error.path);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final readCustomers = ref.watch(customerProviderNotifier);
    final readCustomersNotifier = ref.read(customerProviderNotifier.notifier);

    final isWideScreen = MediaQuery.of(context).size.width >= 860;
    final router = GoRouter.of(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          if(!isWideScreen) ...[Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: 40,
              width: 350,
              child: TextField(
                onChanged: (text) {
                    readCustomersNotifier.searchCustomers(text);
                },
                decoration: InputDecoration(
                  hintText: 'Hinted Search Text',
                  suffixIcon: IconButton(onPressed: (){},icon: const Icon(Icons.search)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
            ),
          ),],
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Customers.',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if(isWideScreen) ...[Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: 40,
                    width: 350,
                    child: TextField(
                      onChanged: (text) {
                          readCustomersNotifier.searchCustomers(text);
                      },
                      decoration: InputDecoration(
                        hintText: 'Hinted Search Text',
                        suffixIcon: IconButton(onPressed: (){},icon: const Icon(Icons.search)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                  ),
                ),],
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () {
                        router.go(
                          '${AppRouter.customers.path}${AppRouter.addcustomer.path}',
                          extra: CustomerArgs(isAdd: true),
                          );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: readCustomers.length,
                itemBuilder: (context, index) {
                  return AccordianCustomer(customer: readCustomers[index]);
          },
        ),
      ),
    ),
  ]));
  }
}
