import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/components/accordian_invoice.dart';
import 'package:yalapay/data_classes/invoice_args.dart';
import 'package:yalapay/providers/invoice_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class InvoiceScreen extends ConsumerStatefulWidget {
  const InvoiceScreen({super.key});

  @override
  ConsumerState<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends ConsumerState<InvoiceScreen> {

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
    final watchInvoices = ref.watch(invoiceProviderNotifier);
    final readInvoicesNotifier = ref.read(invoiceProviderNotifier.notifier);

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
                  readInvoicesNotifier.searchInvoices(text);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Hinted Search Text',
                  suffixIcon: IconButton(onPressed: () {  },icon: const Icon(Icons.search),),
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
                  'Invoices.',
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
                        readInvoicesNotifier.searchInvoices(text);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Hinted Search Text',
                        suffixIcon: IconButton(onPressed: () {  },icon: const Icon(Icons.search),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                  ),
                ),],
                Row(
                  children: [
                    IconButton(onPressed: () { 
                      router.go(
                          '${AppRouter.invoice.path}${AppRouter.addInvoice.path}',
                          extra: InvoiceArgs(isAdd: true),
                      );
                    },
                    icon: const Icon(Icons.add_circle)
                  ),
                  ],
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(color: Colors.black),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: watchInvoices.length,
                itemBuilder: (context, index) {
                  return AccordianInvoice(invoice: watchInvoices[index]);
                },
              ),
            ),
          ),
        ]
      )
    );
  }
}
