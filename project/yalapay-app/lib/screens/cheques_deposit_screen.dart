import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/components/accordian_cheques_deposit.dart';
import 'package:yalapay/data_classes/cheque_deposit_args.dart';
import 'package:yalapay/providers/cheque_deposit_provider.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/providers/selected_cheques_provider.dart';
import 'package:yalapay/routes/app_router.dart';


class ChequeDepositScreen extends ConsumerStatefulWidget {
  const ChequeDepositScreen({super.key});

  @override
  ConsumerState<ChequeDepositScreen> createState() => _ChequeDepositScreenState();
}

class _ChequeDepositScreenState extends ConsumerState<ChequeDepositScreen> {
  bool isIconUp = false;

  void setIsIconUp(bool value) {
    setState(() {
      isIconUp = value;
    });
  }
  
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
    ref.read(chequeProviderNotifier);
    final watchChequeDeposits = ref.watch(chequeDepositProviderNotifier);
    final readChequeDepositsNotifier = ref.read(chequeDepositProviderNotifier.notifier);
    final readSelectedCheque = ref.read(selectedChequeProviderNotifier);

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
                    setState(() {
                      readChequeDepositsNotifier.searchChequeDeposits(text);
                    });
                  },
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
                    'Cheques Deposits.',
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
                    setState(() {
                      readChequeDepositsNotifier.searchChequeDeposits(text);
                    });
                  },
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
                      IconButton(icon: const Icon(Icons.add_circle), onPressed: () {
                        readSelectedCheque.clear();
                        router.go(
                          '${AppRouter.chequeDeposit.path}${AppRouter.addChequeDeposit.path}', 
                          extra: ChequeDepositArgs(isAdd: true));
                      }), 
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
                  itemCount: watchChequeDeposits.length,
                  itemBuilder: (context, index) {
                    return AccordianChequesDeposit(chequeDeposit: watchChequeDeposits[index]);
                  },
                ),
              ),
            ),
          ],
    ));
  }
}
