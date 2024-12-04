import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/components/accordian_payments.dart';
import 'package:yalapay/data_classes/payment_args.dart';
import 'package:yalapay/models/cheque.dart';
import 'package:yalapay/models/payment.dart';
import 'package:yalapay/providers/cheque_provider.dart';
import 'package:yalapay/providers/invoice_provider.dart';
import 'package:yalapay/providers/login_provider.dart';
import 'package:yalapay/providers/payment_provider.dart';
import 'package:yalapay/routes/app_router.dart';

class PaymentsScreen extends ConsumerStatefulWidget {
  final bool isInvoice;
  final int? invoiceId;
  const PaymentsScreen({super.key, required this.isInvoice, this.invoiceId});

  @override
  ConsumerState<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends ConsumerState<PaymentsScreen> {
  List<Payment>? payments;
  double amountDue = 0.0;

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

  void showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final readPaymentNotifier = ref.read(paymentProviderNotifier.notifier);
    final watchPayment = ref.watch(paymentProviderNotifier);
    final readInvoiceNotifier = ref.read(invoiceProviderNotifier.notifier);
    final readChequeNotifier = ref.read(chequeProviderNotifier.notifier);

    payments = widget.isInvoice ? readPaymentNotifier.paymentState(widget.invoiceId!) : watchPayment;
    final isWideScreen = MediaQuery.of(context).size.width >= 860;
    final router = GoRouter.of(context);

    if(widget.isInvoice){
      amountDue = readInvoiceNotifier.getInvoiceById(widget.invoiceId!).amount;
      for(var p in watchPayment){
        if(p.invoiceNo == widget.invoiceId!){
          if(p.chequeNo > 0){
            Cheque temp = readChequeNotifier.getChequeById(p.chequeNo);
            
            if(temp.status != 'Returned'){
              amountDue -= p.amount;
            }

          }
          else{
            amountDue -= p.amount;
          }    
        }
      }
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          if(!isWideScreen && !widget.isInvoice) ...[Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: 40,
              width: 350,
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    readPaymentNotifier.searchPayments(text);
                  });
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
                
                widget.isInvoice ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  IconButton(
                  onPressed: () { 
                    router.pop();
                    }, 
                    icon: const Icon(Icons.arrow_back)),
                    SizedBox(width: 20,),
                    const Text(
                    'Payments.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],) : const Text(
                    'Payments.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                ),

                if(isWideScreen && !widget.isInvoice) ...[Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    height: 40,
                    width: 350,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          readPaymentNotifier.searchPayments(text);
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Hinted Search Text',
                        suffixIcon: const Icon(Icons.search),
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
                      if(!widget.isInvoice) {
                        router.go('${AppRouter.payments.path}${AppRouter.addPayment.path}', extra: PaymentArgs(isAdd: true, isInvoice: widget.isInvoice, invoiceId: 0));
                      }
                      else{
                        if(amountDue <= 0){
                          showNotification('Invoice is fully paid.');
                          return;
                        }
                        else{
                          router.go('${AppRouter.invoice.path}${AppRouter.paymentsFromInvoice.path}${AppRouter.addPaymentFromInvoice.path}', extra: PaymentArgs(isAdd: true, isInvoice: widget.isInvoice, invoiceNo: widget.invoiceId, invoiceId: widget.invoiceId!));
                        }
                      }
                    },
                    icon: const Icon(Icons.add_circle)),
                  ],
                ),
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
                itemCount: payments!.length,
                itemBuilder: (context, index) {
                  return AccordianPayment(payment: payments![index], isInvoice: widget.isInvoice);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
