import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/components/accordian_cheques.dart';
import 'package:yalapay/models/cheque.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class ChequesScreen extends ConsumerStatefulWidget {
  final List<Cheque>? cheques;
  final bool isAdd;
  const ChequesScreen({super.key, this.cheques, required this.isAdd});

  @override
  ConsumerState<ChequesScreen> createState() => _ChequeScreenState();
  
}

class _ChequeScreenState extends ConsumerState<ChequesScreen> {
  bool isIconUp = false;
  List<Cheque>? cheques;

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



  void setIsIconUp(bool value) {
    setState(() {
      isIconUp = value;
    });
  }

  void setCheques(List<Cheque> passed) {
    setState(() {
      cheques = passed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final awaitingCheques = ref.read(chequeProviderNotifier.notifier).filterList('Awaiting');
    final router = GoRouter.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cheques.',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                widget.isAdd ? Row(
                  children: [
                    IconButton(
                      onPressed: () { 
                      router.pop();
                     },
                     icon:  const Icon(Icons.cancel)
                    ),
                  ],
                ) : Container(),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: awaitingCheques.length,
                itemBuilder: (context, index) {
                  return AccordianCheques(cheque: awaitingCheques[index],true);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
